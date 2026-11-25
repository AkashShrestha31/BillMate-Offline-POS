import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/login/data/models/login_request_params.dart';
import 'package:hotel/src/features/login/data/models/login_response_model.dart';
import 'package:hotel/src/features/login/domain/usecases/login_use_case.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._useCase) : super(const LoginState.initial());

  final LoginUseCase _useCase;

  Future<void> postLogin({required LoginRequestParams params}) async {
    emit(const LoginState.loading());
    emit((await _useCase.execute(params)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                LoginState.error(message: serverError),
            noInternet: () => const LoginState.noInternet()),
        (data) => LoginState.success(loginResponseModel: data)));
  }
}
