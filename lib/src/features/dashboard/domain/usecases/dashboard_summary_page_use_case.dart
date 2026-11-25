import 'package:dartz/dartz.dart';
import 'package:hotel/src/core/errors/app_error.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/core/usecase/base_use_case.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/dashboard_summary_page_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/repositories/dashboard_summary_page_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DashboardSummaryPageUseCase extends BaseUseCase<
    DashboardSummaryPageRequestParams,
    ApiResponse<DashboardSummaryPageResponseModel>> {
  DashboardSummaryPageUseCase(this._repository);

  final DashboardSummaryPageRepository _repository;

  @override
  Future<Either<AppError, ApiResponse<DashboardSummaryPageResponseModel>>>
      execute(DashboardSummaryPageRequestParams param) =>
          _repository.getDashboardSummaryPage(params: param);
}
