import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hotel/src/app/app.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/core/extensions/extensions/context_extension.dart';
import 'package:hotel/src/core/services/api/api_endpoints.dart';
import 'package:hotel/src/features/expense/data/models/request/create_expense_request_params.dart';
import 'package:hotel/src/features/expense/data/models/response/create_expense_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class ExpenseRemoteDataSource {
  Future<CreateExpenseResponseModel> createExpense({required CreateExpenseRequestParams params});
}

// @LazySingleton(as: ExpenseRemoteDataSource)
class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  ExpenseRemoteDataSourceImpl(@Named('authenticated') Dio dio) : _dio = dio;

  final Dio _dio;

  @override
  Future<CreateExpenseResponseModel> createExpense({required CreateExpenseRequestParams params}) async {
    try {
      final options = await scaffoldKey.currentContext!.authorizedOptions;
      final response = await _dio.post(
        options: options,
        '${dotenv.env['BASE_URL']}${ApiEndPoints.createExpense}',
        data: params.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return CreateExpenseResponseModel.fromJson(
          response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : {'message': 'Success'},
        );
      } else {
        throw const AppException(message: 'Unknown Error');
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
