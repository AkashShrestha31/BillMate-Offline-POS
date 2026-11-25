import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/settlement/data/datasources/settlement_remote_data_source.dart';
import 'package:hotel/src/features/settlement/data/models/request/settlement_request_params.dart';
import 'package:hotel/src/features/settlement/data/models/response/settlement_response_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettlementRemoteDataSource)
class SettlementLocalDataSource implements SettlementRemoteDataSource {
  @override
  Future<ApiResponse<SettlementResponseModel>> createSettlement({
    required SettlementRequestParams params,
  }) async {
    return ApiResponse(
      data: SettlementResponseModel(success: true, message: 'Settlement recorded locally'),
      message: 'Settlement recorded locally',
      success: true,
    );
  }
}
