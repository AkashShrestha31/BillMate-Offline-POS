import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotel/src/core/services/response/api_response.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_request_params.dart';
import 'package:hotel/src/features/dashboard/data/models/hotel_sales_response_model.dart';
import 'package:hotel/src/features/dashboard/domain/usecases/hotel_sales_use_case.dart';
import 'package:injectable/injectable.dart';

part 'hotel_sales_state.dart';
part 'hotel_sales_cubit.freezed.dart';

@injectable
class HotelSalesCubit extends Cubit<HotelSalesState> {
  HotelSalesCubit(this._useCase) : super(const HotelSalesState.initial());

  final HotelSalesUseCase _useCase;

  Future<void> getHotelSales({required HotelSalesRequestParams params}) async {
    emit(const HotelSalesState.loading());
    emit((await _useCase.execute(params)).fold(
        (error) => error.when(
            serverError: (serverError) =>
                HotelSalesState.error(message: serverError),
            noInternet: () => const HotelSalesState.noInternet()),
        (data) => HotelSalesState.success(hotelSalesResponseModel: data)));
  }
}
