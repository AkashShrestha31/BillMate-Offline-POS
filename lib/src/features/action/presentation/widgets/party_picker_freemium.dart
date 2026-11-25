import 'package:hotel/src/core/services/billing/freemium_feature.dart';
import 'package:hotel/src/features/action/data/models/response/party_response_model.dart';
import 'package:hotel/src/features/party/data/models/response/party_model.dart';

/// Freemium rules for party rows shown in [PartyPickerSheet] and party lists.
abstract final class PartyPickerFreemium {
  static bool isEmployeeTab(String tabRole) =>
      tabRole.trim().toLowerCase() == 'employee';

  static FreemiumFeature featureForTab(String tabRole) =>
      isEmployeeTab(tabRole)
          ? FreemiumFeature.employee
          : FreemiumFeature.party;

  static String? partyRoleForTab(String tabRole) =>
      isEmployeeTab(tabRole) ? null : tabRole.trim().toLowerCase();

  static String recordKeyForParty(PartyItem party, String tabRole) {
    if (isEmployeeTab(tabRole)) {
      final employeeId = party.employeeDetails?.employeeId;
      if (employeeId != null) return employeeId.toString();
    }
    return party.name?.trim() ?? '';
  }

  static String recordKeyForPartyModel(PartyModel party, String tabRole) {
    if (isEmployeeTab(tabRole)) {
      final employeeId = party.employeeDetails?.employeeId;
      if (employeeId != null) return employeeId.toString();
    }
    return party.name.trim();
  }
}
