import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/file_creation/data/models/request/file_creation_request_params.dart';
import 'package:hotel/src/features/file_creation/data/models/response/file_creation_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/features/file_creation/domain/usecases/file_creation_use_case.dart';
import 'package:injectable/injectable.dart';

part 'file_creation_state.dart';
part 'file_creation_cubit.freezed.dart';

@injectable
class FileCreationCubit extends Cubit<FileCreationState> {
  FileCreationCubit(this._useCase) : super(const FileCreationState.initial());

  final FileCreationUseCase _useCase;

  void getFileCreationDetails({required FileCreationRequestParams fileCreationRequestParam}) async {
    emit(const FileCreationState.loading());
    emit(
      (await _useCase.execute(fileCreationRequestParam)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                FileCreationState.error(message: serverError),
            noInternet: () => const FileCreationState.noInternet()),
        (data) {
          return FileCreationState.success(fileCreationDetails: data);
        },
      ),
    );
  }



  /// Reset state to initial
  void reset() {
    emit(const FileCreationState.initial());
  }

  /// Clear any error state
  void clearError() {
    if (state is _Error) {
      emit(const FileCreationState.initial());
    }
  }
}
