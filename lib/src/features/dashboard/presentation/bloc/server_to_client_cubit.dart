import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/dashboard/data/models/response/server_to_client_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/usecases/server_to_client_use_case.dart';
import 'package:injectable/injectable.dart';

part 'server_to_client_state.dart';
part 'server_to_client_cubit.freezed.dart';

@injectable
class ServerToClientCubit extends Cubit<ServerToClientState> {
  ServerToClientCubit(this._useCase) : super(const ServerToClientState.initial());

  final ServerToClientUseCase _useCase;

  void serverToClient() async {
    emit(const ServerToClientState.loading());
    emit(
      (await _useCase.execute(null)).fold(
        (error) => error.when(
          serverError: (serverError) => ServerToClientState.error(message: serverError),
          noInternet: () => const ServerToClientState.noInternet(),
        ),
        (data) => ServerToClientState.success(responseModel: data),
      ),
    );
  }
}
