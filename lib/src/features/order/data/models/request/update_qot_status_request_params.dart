class UpdateQotStatusRequestParams {
  const UpdateQotStatusRequestParams({
    required this.orderName,
    required this.qotName,
    required this.qotStatus,
  });

  final String orderName;
  final String qotName;
  final String qotStatus;
}
