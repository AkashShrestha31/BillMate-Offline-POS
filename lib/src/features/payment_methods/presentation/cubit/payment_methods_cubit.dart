import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_methods_query.dart';
import 'package:hotel/src/features/payment_methods/domain/usecases/get_payment_methods_use_case.dart';
import 'package:hotel/src/features/payment_methods/data/models/payment_method_item.dart';
import 'package:injectable/injectable.dart';

part 'payment_methods_state.dart';
part 'payment_methods_cubit.freezed.dart';

@injectable
class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(this._useCase) : super(const PaymentMethodsState.initial());

  final GetPaymentMethodsUseCase _useCase;

  /// Loads payment methods (optional server-side [q] / [type] filters).
  Future<void> load({String? q, String? type}) async {
    emit(const PaymentMethodsState.loading());
    final result = await _useCase.execute(PaymentMethodsQuery(q: q, type: type));
    emit(
      result.fold(
        (error) => error.when(
          serverError: (message) => PaymentMethodsState.error(message: message),
          noInternet: () => const PaymentMethodsState.noInternet(),
        ),
        (data) => PaymentMethodsState.success(methods: data.data),
      ),
    );
  }

  void reset() {
    emit(const PaymentMethodsState.initial());
  }
}

extension PaymentMethodsStateX on PaymentMethodsState {
  /// Names from API, or empty if not loaded yet / error.
  List<String> paymentMethodNames() => maybeWhen(
        success: (methods) => methods
            .map((e) => e.name.trim())
            .where((n) => n.isNotEmpty)
            .toList(),
        orElse: () => const [],
      );

  /// Names for chips when the API list is ready. Empty while loading — callers should fall back to defaults if needed.
  List<String> paymentMethodNamesForChips() {
    final n = paymentMethodNames();
    return n.isNotEmpty ? n : const [];
  }
}
