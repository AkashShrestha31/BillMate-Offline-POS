part of 'file_creation_cubit.dart';

@freezed
class FileCreationState with _$FileCreationState {
  const factory FileCreationState.initial() = _Initial;

  const factory FileCreationState.loading() = _Loading;

  const factory FileCreationState.noInternet() = _NoInternet;

  const factory FileCreationState.error({required String message}) = _Error;

  const factory FileCreationState.success(
      {required FileCreationDetails fileCreationDetails}) = _Success;
}
