import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/features/role/data/models/delete_role_options.dart';
import 'package:hotel/src/features/role/data/models/role_item.dart';
import 'package:hotel/src/features/role/data/models/role_request.dart';
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart';
import 'package:hotel/src/features/role/presentation/cubit/role_manage_success_kind.dart';
import 'package:injectable/injectable.dart';

sealed class RoleManageState {
  const RoleManageState();
}

class RoleManageInitial extends RoleManageState {
  const RoleManageInitial();
}

class RoleManageLoading extends RoleManageState {
  const RoleManageLoading();
}

class RoleManageLoaded extends RoleManageState {
  const RoleManageLoaded(
    this.roles, {
    this.successKind,
    this.transferredPartyCount,
    this.transferTargetRole,
  });

  final List<RoleItem> roles;
  final RoleManageSuccessKind? successKind;
  final int? transferredPartyCount;
  final String? transferTargetRole;
}

class RoleManageError extends RoleManageState {
  const RoleManageError(this.message);

  final String message;
}

@injectable
class RoleManageCubit extends Cubit<RoleManageState> {
  RoleManageCubit(this._repository) : super(const RoleManageInitial());

  final RolesRepository _repository;

  String? _search;

  String _errorMessage(AppError error) => error.when(
        serverError: (message) => message,
        noInternet: () => 'No internet connection',
      );

  Future<void> load({String? search}) async {
    _search = search;
    if (state is! RoleManageLoaded) {
      emit(const RoleManageLoading());
    }
    await _fetchList();
  }

  Future<void> _fetchList({
    RoleManageSuccessKind? successKind,
    int? transferredPartyCount,
    String? transferTargetRole,
  }) async {
    final result = await _repository.getRoles(search: _search);
    result.fold(
      (e) => emit(RoleManageError(_errorMessage(e))),
      (roles) => emit(
        RoleManageLoaded(
          List<RoleItem>.from(roles),
          successKind: successKind,
          transferredPartyCount: transferredPartyCount,
          transferTargetRole: transferTargetRole,
        ),
      ),
    );
  }

  Future<void> create(RoleRequest request) async {
    final result = await _repository.createRole(request);
    await result.fold(
      (e) async => emit(RoleManageError(_errorMessage(e))),
      (_) async => _fetchList(successKind: RoleManageSuccessKind.created),
    );
  }

  Future<void> update({
    required String originalName,
    required RoleRequest request,
  }) async {
    final result = await _repository.updateRole(
      originalName: originalName,
      request: request,
    );
    await result.fold(
      (e) async => emit(RoleManageError(_errorMessage(e))),
      (_) async => _fetchList(successKind: RoleManageSuccessKind.updated),
    );
  }

  Future<void> delete(
    String name, {
    DeleteRoleOptions options = const DeleteRoleOptions(),
    int? transferredPartyCount,
    String? transferTargetRole,
  }) async {
    final result = await _repository.deleteRole(name, options: options);
    await result.fold(
      (e) async => emit(RoleManageError(_errorMessage(e))),
      (_) async {
        final successKind = options.transferPartiesToRole != null
            ? RoleManageSuccessKind.transferred
            : options.deleteAssociatedParties
                ? RoleManageSuccessKind.hardDeleted
                : RoleManageSuccessKind.deleted;
        await _fetchList(
          successKind: successKind,
          transferredPartyCount: transferredPartyCount,
          transferTargetRole:
              transferTargetRole ?? options.transferPartiesToRole,
        );
      },
    );
  }
}
