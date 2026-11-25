/// Query: `user_id` (email or identifier from JWT).
class UserPermissionsRequestParams {
  const UserPermissionsRequestParams({required this.userId});

  final String userId;

  Map<String, dynamic> toQueryParams() => <String, dynamic>{'user_id': userId};
}
