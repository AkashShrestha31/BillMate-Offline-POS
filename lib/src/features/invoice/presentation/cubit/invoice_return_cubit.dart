import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/src/core/errors/app_exception.dart';
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart';
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart';
import 'package:hotel/src/features/invoice/data/models/response/invoice_return_check_model.dart';
import 'package:injectable/injectable.dart';

sealed class InvoiceReturnState {
  const InvoiceReturnState();
}

class InvoiceReturnInitial extends InvoiceReturnState {
  const InvoiceReturnInitial();
}

class InvoiceReturnLoading extends InvoiceReturnState {
  const InvoiceReturnLoading();
}

class InvoiceReturnReady extends InvoiceReturnState {
  const InvoiceReturnReady(this.data, {this.flashMessage});

  final InvoiceReturnCheckData data;
  final String? flashMessage;
}

class InvoiceReturnSubmitting extends InvoiceReturnState {
  const InvoiceReturnSubmitting(this.data);
  final InvoiceReturnCheckData data;
}

class InvoiceReturnFailure extends InvoiceReturnState {
  const InvoiceReturnFailure(this.message);
  final String message;
}

@injectable
class InvoiceReturnCubit extends Cubit<InvoiceReturnState> {
  InvoiceReturnCubit(this._dataSource) : super(const InvoiceReturnInitial());

  final InvoiceReturnRemoteDataSource _dataSource;

  InvoiceType? _invoiceType;
  String? _invoiceName;

  Future<void> load({
    required InvoiceType invoiceType,
    required String invoiceName,
  }) async {
    _invoiceType = invoiceType;
    _invoiceName = invoiceName;
    emit(const InvoiceReturnLoading());
    try {
      final data = await _dataSource.checkReturn(
        invoiceType: invoiceType,
        invoiceName: invoiceName,
      );
      emit(InvoiceReturnReady(data));
    } on AppException catch (e) {
      emit(InvoiceReturnFailure(e.message));
    } catch (e) {
      emit(InvoiceReturnFailure(e.toString()));
    }
  }

  Future<void> submit({
    required String returnDate,
    required String reason,
    required String createdBy,
    required String refundMethod,
    String? refundPaymentMethod,
    required List<InvoiceReturnLine> lines,
  }) async {
    final type = _invoiceType;
    final name = _invoiceName;
    final current = state;
    if (type == null || name == null || current is! InvoiceReturnReady) return;

    final bodyItems = <CreateInvoiceReturnLine>[];
    for (final line in lines) {
      if (line.returnQty <= 0.005) continue;
      bodyItems.add(
        CreateInvoiceReturnLine(
          originalItemName: line.lineId,
          item: line.displayName,
          returnQuantity: line.returnQty,
          rate: line.rate,
          unit: line.unit,
        ),
      );
    }
    if (bodyItems.isEmpty) {
      emit(const InvoiceReturnFailure('Enter return quantity for at least one line.'));
      emit(InvoiceReturnReady(current.data));
      return;
    }

    emit(InvoiceReturnSubmitting(current.data));
    try {
      final msg = await _dataSource.createReturn(
        invoiceType: type,
        body: CreateInvoiceReturnRequest(
          invoiceName: name,
          returnDate: returnDate,
          reason: reason.trim().isEmpty ? '—' : reason.trim(),
          createdBy: createdBy,
          refundMethod: refundMethod,
          refundPaymentMethod: refundPaymentMethod,
          items: bodyItems,
        ),
      );
      final data = await _dataSource.checkReturn(
        invoiceType: type,
        invoiceName: name,
      );
      emit(InvoiceReturnReady(data, flashMessage: msg));
    } on AppException catch (e) {
      emit(InvoiceReturnFailure(e.message));
      emit(InvoiceReturnReady(current.data));
    } catch (e) {
      emit(InvoiceReturnFailure(e.toString()));
      emit(InvoiceReturnReady(current.data));
    }
  }

  Future<String?> cancelReturn({
    required String returnInvoiceName,
    required String cancelledBy,
  }) async {
    final type = _invoiceType;
    final name = _invoiceName;
    if (type == null || name == null) return null;

    final current = state;
    InvoiceReturnCheckData? previous;
    if (current is InvoiceReturnReady) {
      previous = current.data;
    } else if (current is InvoiceReturnSubmitting) {
      previous = current.data;
    }

    if (previous != null) {
      emit(InvoiceReturnSubmitting(previous));
    } else {
      emit(const InvoiceReturnLoading());
    }

    try {
      final msg = await _dataSource.cancelReturn(
        invoiceType: type,
        returnInvoiceName: returnInvoiceName,
        cancelledBy: cancelledBy,
      );
      await load(invoiceType: type, invoiceName: name);
      return msg;
    } on AppException catch (e) {
      if (previous != null) {
        emit(InvoiceReturnFailure(e.message));
        emit(InvoiceReturnReady(previous));
      } else {
        emit(InvoiceReturnFailure(e.message));
      }
      rethrow;
    } catch (e) {
      if (previous != null) {
        emit(InvoiceReturnFailure(e.toString()));
        emit(InvoiceReturnReady(previous));
      } else {
        emit(InvoiceReturnFailure(e.toString()));
      }
      rethrow;
    }
  }
}
