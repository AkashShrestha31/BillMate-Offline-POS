import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/client_to_server_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/usecases/client_to_server_use_case.dart';
import 'package:injectable/injectable.dart';

part 'client_to_server_state.dart';
part 'client_to_server_cubit.freezed.dart';

@injectable
class ClientToServerCubit extends Cubit<ClientToServerState> {
  ClientToServerCubit(this._useCase)
      : super(const ClientToServerState.initial());

  final ClientToServerUseCase _useCase;

  void clientToServer({required ClientToServerRequestParams params}) async {
    emit(const ClientToServerState.loading());
    emit(
      (await _useCase.execute(params)).fold(
        (error) => error.when(
          serverError: (serverError) =>
              ClientToServerState.error(message: serverError),
          noInternet: () => const ClientToServerState.noInternet(),
        ),
        (data) => ClientToServerState.success(responseModel: data),
      ),
    );
  }
}
