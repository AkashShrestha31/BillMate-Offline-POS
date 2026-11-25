import 'package:bloc/bloc.dart';
import 'package:hotel/src/features/permission/data/models/request/user_permissions_request_params.dart';
import 'package:hotel/src/features/permission/data/models/response/user_permissions_response_model.dart';
import 'package:hotel/src/features/permission/domain/usecases/user_permissions_use_case.dart';
import 'package:injectable/injectable.dart';

sealed class UserPermissionsState {
  const UserPermissionsState();
}

final class UserPermissionsInitial extends UserPermissionsState {
  const UserPermissionsInitial();
}

final class UserPermissionsLoading extends UserPermissionsState {
  const UserPermissionsLoading();
}

final class UserPermissionsNoInternet extends UserPermissionsState {
  const UserPermissionsNoInternet();
}

final class UserPermissionsError extends UserPermissionsState {
  const UserPermissionsError(this.message);
  final String message;
}

final class UserPermissionsSuccess extends UserPermissionsState {
  const UserPermissionsSuccess(this.data);
  final UserPermissionsResponseModel data;
}

@injectable
class UserPermissionsCubit extends Cubit<UserPermissionsState> {
  UserPermissionsCubit(this._useCase) : super(const UserPermissionsInitial());

  final UserPermissionsUseCase _useCase;

  Future<void> fetchUserPermissions({required String userId}) async {
    if (userId.isEmpty) {
      emit(
        const UserPermissionsSuccess(
          UserPermissionsResponseModel(
            success: true,
            userId: '',
            features: [],
            totalFeatures: 0,
            totalPermissions: 0,
          ),
        ),
      );
      return;
    }

    emit(const UserPermissionsLoading());
    emit(
      (await _useCase.execute(UserPermissionsRequestParams(userId: userId))).fold(
        (error) => error.when(
          serverError: (message) => UserPermissionsError(message),
          noInternet: () => const UserPermissionsNoInternet(),
        ),
        UserPermissionsSuccess.new,
      ),
    );
  }
}
