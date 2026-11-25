import 'dart:math';

import 'package:hotel/src/core/config/app_platform_config.dart';
import 'package:hotel/src/core/services/org/org_registry_storage.dart';
import 'package:hotel/src/core/services/org/org_storage.dart';
import 'package:hotel/src/core/services/org/saved_organization.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';
import 'package:hotel/src/features/org/domain/organization_code_generator.dart';
import 'package:hotel/src/features/setup/domain/demo_data_freemium_limits.dart';
import 'package:hotel/src/features/setup/domain/local_test_data_seeder.dart';
import 'package:hotel/src/features/setup/domain/test_data_storage.dart';

/// Legacy extra-demo-org helpers. New demo seeds never create extra organizations.
class TestDataOrganizationSeeder {
  TestDataOrganizationSeeder._();

  static const int extraOrganizationCount = 0;

  static int get targetExtraOrganizationCount =>
      DemoDataFreemiumLimits.extraOrganizations;

  static String slugForDemoOrganization(String code) =>
      'demo_${code.trim().toUpperCase()}';

  static List<String> get _organizationNames => [
    'Himalayan Peak Lodge',
    'Royal Garden Restro',
    'Lakeside ${AppPlatformConfig.appName} Inn',
    'Sunset Valley Hotel',
    'Everest View Restaurant',
    'Green Terrace Lodge',
    'Mountain Breeze Restro',
    'Golden Lotus Hotel',
  ];

  /// No-op when [targetExtraOrganizationCount] is 0 (current default).
  /// Uses the same admin login as the active installation (offline DB user).
  static Future<void> seedExtraOrganizations({
    String? excludeOrganizationName,
    String? excludeOrganizationSlug,
  }) async {
    final targetCount = targetExtraOrganizationCount;
    if (targetCount <= 0) return;

    final existingCodes = await TestDataStorage.getExtraOrgCodes();
    if (existingCodes.length >= targetCount) {
      await _migrateDemoOrganizationSlugs(existingCodes);
      await _ensureRegistered(existingCodes);
      return;
    }

    final registry = await OrgRegistryStorage.getAll();
    final usedCodes = registry.map((o) => o.code.toUpperCase()).toSet();
    final currentCode = (await OrgStorage.getOrgCode())?.toUpperCase();
    if (currentCode != null && currentCode.isNotEmpty) {
      usedCodes.add(currentCode);
    }

    final excludeNorm = excludeOrganizationName?.trim().toLowerCase() ?? '';
    final excludeSlug = excludeOrganizationSlug?.trim() ?? '';
    final namePool = _organizationNames.where((n) {
      if (n.trim().toLowerCase() == excludeNorm) return false;
      if (excludeSlug.isNotEmpty) {
        final slug = n.replaceAll(RegExp(r'\s+'), '');
        if (slug == excludeSlug) return false;
      }
      return true;
    }).toList();
    namePool.shuffle(Random());

    final addedCodes = <String>[];
    var nameIndex = 0;

    while (addedCodes.length < targetCount && nameIndex < namePool.length) {
      final name = namePool[nameIndex++];
      var code = OrganizationCodeGenerator.generate();
      while (usedCodes.contains(code)) {
        code = OrganizationCodeGenerator.generate();
      }
      usedCodes.add(code);

      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: slugForDemoOrganization(code),
          code: code,
          name: name,
          businessType: OrganizationBusinessType.hotel,
        ),
      );
      addedCodes.add(code);
    }

    await TestDataStorage.setExtraOrgCodes(addedCodes);
  }

  static Future<void> _migrateDemoOrganizationSlugs(List<String> codes) async {
    final codeSet = codes.map((c) => c.trim().toUpperCase()).toSet();
    final registry = await OrgRegistryStorage.getAll();
    for (final org in registry) {
      final normalizedCode = org.code.trim().toUpperCase();
      if (!codeSet.contains(normalizedCode)) continue;

      final expectedSlug = slugForDemoOrganization(org.code);
      if (org.slug == expectedSlug) continue;

      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: expectedSlug,
          code: org.code,
          name: org.name,
          businessType: org.businessType,
        ),
      );
    }
  }

  static Future<void> _ensureRegistered(List<String> codes) async {
    final registry = await OrgRegistryStorage.getAll();
    final byCode = {for (final o in registry) o.code.toUpperCase(): o};
    final names = List<String>.from(_organizationNames);

    for (var i = 0; i < codes.length; i++) {
      final code = codes[i];
      if (byCode.containsKey(code.toUpperCase())) continue;

      final name = i < names.length ? names[i] : 'Demo Hotel ${i + 1}';
      await OrgRegistryStorage.addOrUpdate(
        SavedOrganization(
          slug: slugForDemoOrganization(code),
          code: code,
          name: name,
          businessType: OrganizationBusinessType.hotel,
        ),
      );
    }
  }

  static Future<void> removeExtraOrganizations() async {
    final codes = await TestDataStorage.getExtraOrgCodes();
    if (codes.isNotEmpty) {
      await OrgRegistryStorage.removeByCodes(codes);
    }
    await TestDataStorage.clearExtraOrgCodes();
  }

  /// Removes one demo-generated org from the registry and extra-org tracking.
  static Future<void> removeExtraOrganizationByCode(String code) async {
    final normalized = code.trim().toUpperCase();
    if (normalized.isEmpty) return;

    await OrgRegistryStorage.removeByCodes([code]);
    final codes = await TestDataStorage.getExtraOrgCodes();
    final kept = codes
        .where((c) => c.trim().toUpperCase() != normalized)
        .toList();
    await TestDataStorage.setExtraOrgCodes(kept);
  }

  /// True when all extra demo orgs exist in the registry with seeded databases.
  static Future<bool> areExtraDemoOrganizationsReady() async {
    final targetCount = targetExtraOrganizationCount;
    if (targetCount <= 0) return true;

    final codes = await TestDataStorage.getExtraOrgCodes();
    if (codes.length < targetCount) return false;

    final registry = await OrgRegistryStorage.getAll();
    final byCode = {
      for (final o in registry) o.code.trim().toUpperCase(): o,
    };

    for (final code in codes) {
      final normalized = code.trim().toUpperCase();
      final org = byCode[normalized];
      if (org == null) return false;
      if (!await LocalTestDataSeeder.hasDemoContentForSlug(org.slug)) {
        return false;
      }
    }
    return true;
  }

  /// True when the active org is a leftover extra demo org from older test data.
  static Future<bool> isCurrentOrganizationDemoGenerated() async {
    final code = await OrgStorage.getOrgCode();
    return isDemoGeneratedOrganizationCode(code);
  }

  static Future<bool> isDemoGeneratedOrganizationCode(String? code) async {
    if (code == null || code.trim().isEmpty) return false;
    final extra = await TestDataStorage.getExtraOrgCodes();
    final normalized = code.trim().toUpperCase();
    return extra.any((c) => c.trim().toUpperCase() == normalized);
  }

  /// First organization that is not one of the demo-generated extras (user setup org).
  static Future<SavedOrganization?> findPrimaryUserOrganization() async {
    final demoCodes = (await TestDataStorage.getExtraOrgCodes())
        .map((c) => c.trim().toUpperCase())
        .where((c) => c.isNotEmpty)
        .toSet();

    final all = await OrgRegistryStorage.getAll();
    for (final org in all) {
      if (!demoCodes.contains(org.code.trim().toUpperCase())) {
        return org;
      }
    }
    return null;
  }

  /// Activates [org] without signing the user out.
  static Future<void> activateOrganization(SavedOrganization org) async {
    await OrgStorage.saveOrganization(
      slug: org.slug,
      code: org.code,
      name: org.name,
    );
  }
}
