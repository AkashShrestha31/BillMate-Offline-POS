import 'package:flutter/foundation.dart';

@immutable
class UserPermissionsResponseModel {
  const UserPermissionsResponseModel({
    required this.success,
    required this.userId,
    required this.features,
    required this.totalFeatures,
    required this.totalPermissions,
  });

  final bool success;
  final String userId;
  final List<UserPermissionFeatureModel> features;
  final int totalFeatures;
  final int totalPermissions;

  factory UserPermissionsResponseModel.fromJson(Map<String, dynamic> json) {
    return UserPermissionsResponseModel(
      success: json['success'] as bool? ?? false,
      userId: json['userId'] as String? ?? '',
      features: (json['features'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => UserPermissionFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalFeatures: (json['total_features'] as num?)?.toInt() ?? 0,
      totalPermissions: (json['total_permissions'] as num?)?.toInt() ?? 0,
    );
  }
}

@immutable
class UserPermissionFeatureModel {
  const UserPermissionFeatureModel({
    required this.featureId,
    required this.featureName,
    required this.featureDisplayName,
    this.featureDescription,
    required this.featureCategory,
    required this.featureIcon,
    required this.featureRoute,
    this.featureSortOrder,
    required this.displayContext,
    required this.permissions,
  });

  final int featureId;
  final String featureName;
  final String featureDisplayName;
  final String? featureDescription;
  final String featureCategory;
  final String featureIcon;
  final String featureRoute;
  final int? featureSortOrder;
  final List<FeatureDisplayContextItem> displayContext;
  final List<UserPermissionGrantModel> permissions;

  factory UserPermissionFeatureModel.fromJson(Map<String, dynamic> json) {
    return UserPermissionFeatureModel(
      featureId: (json['featureId'] as num).toInt(),
      featureName: json['featureName'] as String? ?? '',
      featureDisplayName: json['featureDisplayName'] as String? ?? '',
      featureDescription: json['featureDescription'] as String?,
      featureCategory: json['featureCategory'] as String? ?? '',
      featureIcon: json['featureIcon'] as String? ?? '',
      featureRoute: json['featureRoute'] as String? ?? '',
      featureSortOrder: (json['featureSortOrder'] as num?)?.toInt(),
      displayContext: _parseDisplayContext(json['displayContext']),
      permissions: (json['permissions'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => UserPermissionGrantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Supports new object shape or legacy `[8, 16]` mask integers.
  static List<FeatureDisplayContextItem> _parseDisplayContext(dynamic raw) {
    if (raw == null) return const [];
    final list = raw is List<dynamic> ? raw : const <dynamic>[];
    final out = <FeatureDisplayContextItem>[];
    for (final e in list) {
      if (e is Map<String, dynamic>) {
        out.add(FeatureDisplayContextItem.fromJson(e));
      } else if (e is num) {
        out.add(FeatureDisplayContextItem(maskValue: e.toInt()));
      }
    }
    return out;
  }
}

@immutable
class FeatureDisplayContextItem {
  const FeatureDisplayContextItem({
    this.key,
    this.label,
    this.description,
    this.icon,
    this.maskValue,
  });

  final String? key;
  final String? label;
  final String? description;
  final String? icon;
  /// Bitmask for UI placement (e.g. drawer vs feature list).
  final int? maskValue;

  factory FeatureDisplayContextItem.fromJson(Map<String, dynamic> json) {
    return FeatureDisplayContextItem(
      key: json['key'] as String?,
      label: json['label'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      maskValue: (json['mask_value'] as num?)?.toInt(),
    );
  }
}

@immutable
class UserPermissionGrantModel {
  const UserPermissionGrantModel({
    required this.permissionId,
    required this.permissionKey,
    required this.permissionName,
    this.permissionDescription,
    required this.grantedBy,
    required this.grantedAt,
    this.expiresAt,
  });

  final int permissionId;
  final String permissionKey;
  final String permissionName;
  final String? permissionDescription;
  final String grantedBy;
  final String grantedAt;
  final String? expiresAt;

  factory UserPermissionGrantModel.fromJson(Map<String, dynamic> json) {
    return UserPermissionGrantModel(
      permissionId: (json['permissionId'] as num).toInt(),
      permissionKey: json['permissionKey'] as String? ?? '',
      permissionName: json['permissionName'] as String? ?? '',
      permissionDescription: json['permissionDescription'] as String?,
      grantedBy: json['grantedBy'] as String? ?? '',
      grantedAt: json['grantedAt'] as String? ?? '',
      expiresAt: json['expiresAt'] as String?,
    );
  }
}

extension UserPermissionsResponseModelQuery on UserPermissionsResponseModel {
  /// True if this feature is present and includes a grant for [permissionKey].
  /// [permissionKey] match is case-insensitive so backend casing differences still work.
  bool hasFeaturePermission(String featureName, String permissionKey) {
    final fn = featureName.trim();
    final pk = permissionKey.trim().toLowerCase();
    for (final feature in features) {
      if (feature.featureName.trim() != fn) continue;
      return feature.permissions.any((p) => p.permissionKey.trim().toLowerCase() == pk);
    }
    return false;
  }

  /// True if [featureName] exists and any grant matches one of [permissionKeys].
  bool hasFeatureAnyPermission(String featureName, List<String> permissionKeys) {
    final fn = featureName.trim();
    final keys = permissionKeys.map((k) => k.trim().toLowerCase()).toSet();
    for (final feature in features) {
      if (feature.featureName.trim() != fn) continue;
      return feature.permissions.any((p) => keys.contains(p.permissionKey.trim().toLowerCase()));
    }
    return false;
  }
}
