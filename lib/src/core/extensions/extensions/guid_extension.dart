import 'package:uuid/uuid.dart';

class Guid {
  final String value;
  static final Uuid _uuid = Uuid();

  // Constructor to create a GUID with a provided value
  Guid(this.value);

  // Factory constructor to generate a new GUID
  factory Guid.newGuid() {
    return Guid(_uuid.v4());
  }

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Guid && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;
}
