import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_request.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/domain/repositories/payment_methods_repository.dart';
import 'package:injectable/injectable.dart';

sealed class PaymentMethodManageState {
  const PaymentMethodManageState();
}

class PaymentMethodManageInitial extends PaymentMethodManageState {
  const PaymentMethodManageInitial();
}

class PaymentMethodManageLoading extends PaymentMethodManageState {
  const PaymentMethodManageLoading();
}

class PaymentMethodManageLoaded extends PaymentMethodManageState {
  const PaymentMethodManageLoaded(
    this.methods, {
    this.successMessage,
  });

  final List<PaymentMethodItem> methods;
  final String? successMessage;
}

class PaymentMethodManageError extends PaymentMethodManageState {
  const PaymentMethodManageError(this.message);

  final String message;
}

@injectable
class PaymentMethodManageCubit extends Cubit<PaymentMethodManageState> {
  PaymentMethodManageCubit(this._repository) : super(const PaymentMethodManageInitial());

  final PaymentMethodsRepository _repository;

  String? _search;
  String? _typeFilter;

  String _errorMessage(AppError error) => error.when(
        serverError: (message) => message,
        noInternet: () => 'No internet connection',
      );

  Future<void> load({String? search, String? type}) async {
    _search = search;
    _typeFilter = type;
    if (state is! PaymentMethodManageLoaded) {
      emit(const PaymentMethodManageLoading());
    }
    await _fetchList();
  }

  Future<void> _fetchList({String? successMessage}) async {
    final result = await _repository.getPaymentMethods(
      PaymentMethodsQuery(q: _search, type: _typeFilter),
    );
    result.fold(
      (e) => emit(PaymentMethodManageError(_errorMessage(e))),
      (response) => emit(
        PaymentMethodManageLoaded(
          List<PaymentMethodItem>.from(response.data),
          successMessage: successMessage,
        ),
      ),
    );
  }

  Future<void> create(PaymentMethodRequest request) async {
    final result = await _repository.createPaymentMethod(request);
    await result.fold(
      (e) async => emit(PaymentMethodManageError(_errorMessage(e))),
      (_) async => _fetchList(successMessage: 'Payment method created'),
    );
  }

  Future<void> update({
    required String originalName,
    required PaymentMethodRequest request,
  }) async {
    final result = await _repository.updatePaymentMethod(
      name: originalName,
      request: request,
    );
    await result.fold(
      (e) async => emit(PaymentMethodManageError(_errorMessage(e))),
      (_) async => _fetchList(successMessage: 'Payment method updated'),
    );
  }

  Future<void> delete(String name) async {
    final result = await _repository.deletePaymentMethod(name);
    await result.fold(
      (e) async => emit(PaymentMethodManageError(_errorMessage(e))),
      (_) async => _fetchList(successMessage: 'Payment method deleted'),
    );
  }
}
