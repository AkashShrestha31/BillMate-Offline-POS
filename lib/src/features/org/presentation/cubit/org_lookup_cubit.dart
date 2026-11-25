import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:hotel/src/core/di/injection.dart';
import 'package:hotel/src/core/l10n/default_l10n.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/services/local/local_db.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/data/datasources/org_local_data_source.dart';
import 'package:hotel/src/features/org/data/datasources/org_remote_data_source.dart';
import 'package:hotel/src/features/org/data/models/org_response_model.dart';
import 'package:hotel/src/features/org/domain/org_code_utils.dart';
import 'package:hotel/src/features/org/domain/org_switch_coordinator.dart';

sealed class OrgLookupState {
  const OrgLookupState();
}

class OrgLookupInitial extends OrgLookupState {
  const OrgLookupInitial();
}

class OrgLookupLoading extends OrgLookupState {
  const OrgLookupLoading();
}

class OrgLookupSuccess extends OrgLookupState {
  const OrgLookupSuccess({required this.orgName});

  final String? orgName;
}

class OrgLookupError extends OrgLookupState {
  const OrgLookupError(this.message);

  final String message;
}

@injectable
class OrgLookupCubit extends Cubit<OrgLookupState> {
  OrgLookupCubit(this._remoteDataSource, this._localDataSource)
      : super(const OrgLookupInitial());

  final OrgRemoteDataSource _remoteDataSource;
  final OrgLocalDataSource _localDataSource;

  Future<void> resolveOrganization(String code) async {
    final trimmed = normalizeOrganizationCode(code);
    if (trimmed.isEmpty) {
      emit(OrgLookupError(defaultL10n.enterOrganizationCode));
      return;
    }

    emit(const OrgLookupLoading());
    try {
      final local = await _localDataSource.findByCode(trimmed);
      if (local != null) {
        await _persistOrg(local, trimmed);
        emit(OrgLookupSuccess(orgName: local.name));
        return;
      }

      final org = await _remoteDataSource.fetchOrganization(trimmed);
      await _persistOrg(org, trimmed);
      emit(OrgLookupSuccess(orgName: org.name));
    } on AppException catch (e) {
      emit(OrgLookupError(e.message));
    } catch (_) {
      emit(OrgLookupError(defaultL10n.organizationNotFoundCheckCode));
    }
  }

  Future<void> _persistOrg(
    OrgResponseModel org,
    String fallbackCode,
  ) async {
    final resolvedCode = org.code ?? fallbackCode;
    final slug = await _resolveStorageSlug(org, fallbackCode);
    await OrgStorage.saveOrganization(
      slug: slug,
      code: resolvedCode,
      name: org.name,
      businessType: org.businessType,
      allowedEmailDomain: org.allowedEmailDomain,
    );
    await OrgRegistryStorage.addOrUpdate(
      SavedOrganization(
        slug: slug,
        code: resolvedCode,
        name: org.name ?? slug,
        businessType: org.businessType,
      ),
    );
    await OrgStorage.saveActiveDatabaseSlug(slug);
    await getIt<LocalDb>().resetConnection();
    OrgSwitchCoordinator.notifier.value++;
  }

  /// Prefer the on-device database slug from the registry over a remote slug.
  Future<String> _resolveStorageSlug(
    OrgResponseModel org,
    String fallbackCode,
  ) async {
    final code = (org.code ?? fallbackCode).trim().toUpperCase();
    for (final saved in await OrgRegistryStorage.getAll()) {
      if (saved.code.toUpperCase() == code &&
          await LocalDb.databaseExistsForOrg(saved.slug)) {
        return saved.slug;
      }
    }
    return org.slug;
  }
}
