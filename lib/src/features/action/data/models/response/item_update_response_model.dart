import 'package:json_annotation/json_annotation.dart';
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart';

part 'item_update_response_model.g.dart';

@JsonSerializable(includeIfNull: false)
class ItemUpdateResponseModel {
  final bool success;
  final String message;
  final ItemModel? item;
  final ItemTableUpdates? itemTableUpdates;
  final Map<String, ChangeDetail>? changes;
  final String? modifiedAt;
  final String? modifiedBy;

  ItemUpdateResponseModel({
    required this.success,
    required this.message,
    this.item,
    this.itemTableUpdates,
    this.changes,
    this.modifiedAt,
    this.modifiedBy,
  });

  factory ItemUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ItemUpdateResponseModelFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$ItemUpdateResponseModelToJson(this);
    return _toSnakeCase(json);
  }

  static Map<String, dynamic> _toSnakeCase(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    json.forEach((key, value) {
      final snakeKey = key.replaceAllMapped(
        RegExp(r'[A-Z]'),
            (match) => '_${match.group(0)!.toLowerCase()}',
      );
      result[snakeKey] = value;
    });
    return result;
  }
}

@JsonSerializable(includeIfNull: false)
class ItemTableUpdates {
  final List<String>? fieldsUpdated;
  final Map<String, dynamic>? updatedValues;

  ItemTableUpdates({
    this.fieldsUpdated,
    this.updatedValues,
  });

  factory ItemTableUpdates.fromJson(Map<String, dynamic> json) =>
      _$ItemTableUpdatesFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$ItemTableUpdatesToJson(this);
    return _toSnakeCase(json);
  }

  static Map<String, dynamic> _toSnakeCase(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    json.forEach((key, value) {
      final snakeKey = key.replaceAllMapped(
        RegExp(r'[A-Z]'),
            (match) => '_${match.group(0)!.toLowerCase()}',
      );
      result[snakeKey] = value;
    });
    return result;
  }
}

@JsonSerializable(includeIfNull: false)
class ChangeDetail {
  final dynamic old;
  @JsonKey(name: 'new')
  final dynamic newValue;

  ChangeDetail({
    this.old,
    this.newValue,
  });

  factory ChangeDetail.fromJson(Map<String, dynamic> json) =>
      _$ChangeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeDetailToJson(this);
}