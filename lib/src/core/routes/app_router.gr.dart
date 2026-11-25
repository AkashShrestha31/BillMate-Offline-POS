// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i53;
import 'package:flutter/foundation.dart' as _i64;
import 'package:flutter/material.dart' as _i54;
import 'package:hotel/src/features/action/data/models/response/item_response_model.dart'
    as _i61;
import 'package:hotel/src/features/action/presentation/pages/bulk_add_items_page.dart'
    as _i4;
import 'package:hotel/src/features/action/presentation/pages/item_details_page.dart'
    as _i21;
import 'package:hotel/src/features/action/presentation/pages/item_edit_page.dart'
    as _i22;
import 'package:hotel/src/features/billing/presentation/pages/premium_paywall_page.dart'
    as _i45;
import 'package:hotel/src/features/category/presentation/pages/categories_list_page.dart'
    as _i5;
import 'package:hotel/src/features/closing/data/models/request/hotel_summary_request_params.dart'
    as _i60;
import 'package:hotel/src/features/closing/presentation/pages/hotel_summary_page.dart'
    as _i16;
import 'package:hotel/src/features/contact_book/data/models/response/contact_model.dart'
    as _i55;
import 'package:hotel/src/features/contact_book/presentation/pages/contact_form_page.dart'
    as _i6;
import 'package:hotel/src/features/contact_book/presentation/pages/contact_list_page.dart'
    as _i7;
import 'package:hotel/src/features/dashboard/presentation/pages/hotel_sales_page.dart'
    as _i15;
import 'package:hotel/src/features/dashboard/presentation/pages/main_screen.dart'
    as _i27;
import 'package:hotel/src/features/dashboard/presentation/pages/more_page.dart'
    as _i28;
import 'package:hotel/src/features/employee_management/presentation/pages/employee_dashboard_page.dart'
    as _i12;
import 'package:hotel/src/features/employee_management/presentation/pages/employee_form_page.dart'
    as _i13;
import 'package:hotel/src/features/expense/presentation/pages/add_expense_page.dart'
    as _i1;
import 'package:hotel/src/features/hotel_summary/data/models/response/daily_cash_summary_response_model.dart'
    as _i56;
import 'package:hotel/src/features/hotel_summary/presentation/pages/create_daily_cash_summary_page.dart'
    as _i8;
import 'package:hotel/src/features/hotel_summary/presentation/pages/daily_cash_summary_page.dart'
    as _i10;
import 'package:hotel/src/features/hotel_summary/presentation/pages/opening_amount_page.dart'
    as _i29;
import 'package:hotel/src/features/invoice/data/models/request/invoice_request_params.dart'
    as _i57;
import 'package:hotel/src/features/invoice/data/models/response/invoice_sales_response_model.dart'
    as _i58;
import 'package:hotel/src/features/invoice/presentation/pages/login/create_invoice_page.dart'
    as _i9;
import 'package:hotel/src/features/invoice/presentation/pages/login/invoice_details_page.dart'
    as _i18;
import 'package:hotel/src/features/invoice/presentation/pages/login/invoice_edit_page.dart'
    as _i19;
import 'package:hotel/src/features/invoice/presentation/pages/login/invoice_page_wrapper.dart'
    as _i20;
import 'package:hotel/src/features/invoice/presentation/pages/login/party_invoice_page.dart'
    as _i39;
import 'package:hotel/src/features/invoice/presentation/pages/login/party_invoice_tabbed_page.dart'
    as _i40;
import 'package:hotel/src/features/invoice/presentation/pages/login/quick_add_items_page.dart'
    as _i49;
import 'package:hotel/src/features/liquor/data/models/response/liquor_response_model.dart'
    as _i59;
import 'package:hotel/src/features/liquor/presentation/liquor_price_calculator.dart'
    as _i24;
import 'package:hotel/src/features/liquor/presentation/pages/add_product_page.dart'
    as _i2;
import 'package:hotel/src/features/liquor/presentation/pages/edit_product_page.dart'
    as _i11;
import 'package:hotel/src/features/liquor/presentation/pages/product_settings_page.dart'
    as _i48;
import 'package:hotel/src/features/login/presentation/pages/login_page.dart'
    as _i26;
import 'package:hotel/src/features/onboarding/presentation/pages/app_walkthrough_page.dart'
    as _i3;
import 'package:hotel/src/features/onboarding/presentation/pages/language_selection_page.dart'
    as _i23;
import 'package:hotel/src/features/opening/presentation/pages/opening_page.dart'
    as _i30;
import 'package:hotel/src/features/order/presentation/pages/order_check_in_page.dart'
    as _i31;
import 'package:hotel/src/features/order/presentation/pages/order_detail_page.dart'
    as _i32;
import 'package:hotel/src/features/order/presentation/pages/order_kot_review_page.dart'
    as _i33;
import 'package:hotel/src/features/order/presentation/pages/order_page.dart'
    as _i34;
import 'package:hotel/src/features/order/presentation/pages/order_qot_hub_page.dart'
    as _i35;
import 'package:hotel/src/features/org/presentation/pages/organization_code_page.dart'
    as _i36;
import 'package:hotel/src/features/other/presentation/pages/inventory_dashboard.dart'
    as _i17;
import 'package:hotel/src/features/party/data/models/response/party_model.dart'
    as _i62;
import 'package:hotel/src/features/party/presentation/pages/party_details_page.dart'
    as _i37;
import 'package:hotel/src/features/party/presentation/pages/party_edit_page.dart'
    as _i38;
import 'package:hotel/src/features/party/presentation/pages/party_statement_page.dart'
    as _i41;
import 'package:hotel/src/features/payment_methods/presentation/pages/payment_methods_list_page.dart'
    as _i42;
import 'package:hotel/src/features/payroll/data/models/response/payroll_model.dart'
    as _i63;
import 'package:hotel/src/features/payroll/presentation/pages/generate_payroll_page.dart'
    as _i14;
import 'package:hotel/src/features/payroll/presentation/pages/payroll_detail_page.dart'
    as _i43;
import 'package:hotel/src/features/payroll/presentation/pages/payroll_list_page.dart'
    as _i44;
import 'package:hotel/src/features/reconciliation/presentation/pages/previous_stock_details_page.dart'
    as _i46;
import 'package:hotel/src/features/reconciliation/presentation/pages/previous_stock_page.dart'
    as _i47;
import 'package:hotel/src/features/reconciliation/presentation/pages/stock_upload_page.dart'
    as _i52;
import 'package:hotel/src/features/setup/presentation/pages/local_setup_page.dart'
    as _i25;
import 'package:hotel/src/features/splash/presentation/pages/startup_splash_page.dart'
    as _i51;
import 'package:hotel/src/features/table/presentation/pages/restaurant_floor_plan.dart'
    as _i50;

/// generated route for
/// [_i1.AddExpensePage]
class AddExpenseRoute extends _i53.PageRouteInfo<AddExpenseRouteArgs> {
  AddExpenseRoute({
    _i54.Key? key,
    _i54.VoidCallback? onComplete,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         AddExpenseRoute.name,
         args: AddExpenseRouteArgs(key: key, onComplete: onComplete),
         initialChildren: children,
       );

  static const String name = 'AddExpenseRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddExpenseRouteArgs>(
        orElse: () => const AddExpenseRouteArgs(),
      );
      return _i53.WrappedRoute(
        child: _i1.AddExpensePage(key: args.key, onComplete: args.onComplete),
      );
    },
  );
}

class AddExpenseRouteArgs {
  const AddExpenseRouteArgs({this.key, this.onComplete});

  final _i54.Key? key;

  final _i54.VoidCallback? onComplete;

  @override
  String toString() {
    return 'AddExpenseRouteArgs{key: $key, onComplete: $onComplete}';
  }
}

/// generated route for
/// [_i2.AddProductPage]
class AddProductRoute extends _i53.PageRouteInfo<void> {
  const AddProductRoute({List<_i53.PageRouteInfo>? children})
    : super(AddProductRoute.name, initialChildren: children);

  static const String name = 'AddProductRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i2.AddProductPage();
    },
  );
}

/// generated route for
/// [_i3.AppWalkthroughPage]
class AppWalkthroughRoute extends _i53.PageRouteInfo<void> {
  const AppWalkthroughRoute({List<_i53.PageRouteInfo>? children})
    : super(AppWalkthroughRoute.name, initialChildren: children);

  static const String name = 'AppWalkthroughRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i3.AppWalkthroughPage();
    },
  );
}

/// generated route for
/// [_i4.BulkAddItemsPage]
class BulkAddItemsRoute extends _i53.PageRouteInfo<void> {
  const BulkAddItemsRoute({List<_i53.PageRouteInfo>? children})
    : super(BulkAddItemsRoute.name, initialChildren: children);

  static const String name = 'BulkAddItemsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i4.BulkAddItemsPage();
    },
  );
}

/// generated route for
/// [_i5.CategoriesListPage]
class CategoriesListRoute extends _i53.PageRouteInfo<void> {
  const CategoriesListRoute({List<_i53.PageRouteInfo>? children})
    : super(CategoriesListRoute.name, initialChildren: children);

  static const String name = 'CategoriesListRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i5.CategoriesListPage();
    },
  );
}

/// generated route for
/// [_i6.ContactFormPage]
class ContactFormRoute extends _i53.PageRouteInfo<ContactFormRouteArgs> {
  ContactFormRoute({
    _i54.Key? key,
    _i55.ContactModel? contact,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ContactFormRoute.name,
         args: ContactFormRouteArgs(key: key, contact: contact),
         initialChildren: children,
       );

  static const String name = 'ContactFormRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ContactFormRouteArgs>(
        orElse: () => const ContactFormRouteArgs(),
      );
      return _i53.WrappedRoute(
        child: _i6.ContactFormPage(key: args.key, contact: args.contact),
      );
    },
  );
}

class ContactFormRouteArgs {
  const ContactFormRouteArgs({this.key, this.contact});

  final _i54.Key? key;

  final _i55.ContactModel? contact;

  @override
  String toString() {
    return 'ContactFormRouteArgs{key: $key, contact: $contact}';
  }
}

/// generated route for
/// [_i7.ContactListPage]
class ContactListRoute extends _i53.PageRouteInfo<void> {
  const ContactListRoute({List<_i53.PageRouteInfo>? children})
    : super(ContactListRoute.name, initialChildren: children);

  static const String name = 'ContactListRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return _i53.WrappedRoute(child: const _i7.ContactListPage());
    },
  );
}

/// generated route for
/// [_i8.CreateDailyCashSummaryPage]
class CreateDailyCashSummaryRoute
    extends _i53.PageRouteInfo<CreateDailyCashSummaryRouteArgs> {
  CreateDailyCashSummaryRoute({
    _i54.Key? key,
    _i56.DailyCashSummaryModel? summary,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         CreateDailyCashSummaryRoute.name,
         args: CreateDailyCashSummaryRouteArgs(key: key, summary: summary),
         initialChildren: children,
       );

  static const String name = 'CreateDailyCashSummaryRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateDailyCashSummaryRouteArgs>(
        orElse: () => const CreateDailyCashSummaryRouteArgs(),
      );
      return _i8.CreateDailyCashSummaryPage(
        key: args.key,
        summary: args.summary,
      );
    },
  );
}

class CreateDailyCashSummaryRouteArgs {
  const CreateDailyCashSummaryRouteArgs({this.key, this.summary});

  final _i54.Key? key;

  final _i56.DailyCashSummaryModel? summary;

  @override
  String toString() {
    return 'CreateDailyCashSummaryRouteArgs{key: $key, summary: $summary}';
  }
}

/// generated route for
/// [_i9.CreateInvoicePage]
class CreateInvoiceRoute extends _i53.PageRouteInfo<CreateInvoiceRouteArgs> {
  CreateInvoiceRoute({
    _i54.Key? key,
    DateTime? selectedDate,
    required dynamic Function() onComplete,
    required _i57.InvoiceType invoiceType,
    _i58.InvoiceItem? invoiceToEdit,
    _i58.InvoiceItem? invoiceToDuplicate,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         CreateInvoiceRoute.name,
         args: CreateInvoiceRouteArgs(
           key: key,
           selectedDate: selectedDate,
           onComplete: onComplete,
           invoiceType: invoiceType,
           invoiceToEdit: invoiceToEdit,
           invoiceToDuplicate: invoiceToDuplicate,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateInvoiceRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateInvoiceRouteArgs>();
      return _i53.WrappedRoute(
        child: _i9.CreateInvoicePage(
          key: args.key,
          selectedDate: args.selectedDate,
          onComplete: args.onComplete,
          invoiceType: args.invoiceType,
          invoiceToEdit: args.invoiceToEdit,
          invoiceToDuplicate: args.invoiceToDuplicate,
        ),
      );
    },
  );
}

class CreateInvoiceRouteArgs {
  const CreateInvoiceRouteArgs({
    this.key,
    this.selectedDate,
    required this.onComplete,
    required this.invoiceType,
    this.invoiceToEdit,
    this.invoiceToDuplicate,
  });

  final _i54.Key? key;

  final DateTime? selectedDate;

  final dynamic Function() onComplete;

  final _i57.InvoiceType invoiceType;

  final _i58.InvoiceItem? invoiceToEdit;

  final _i58.InvoiceItem? invoiceToDuplicate;

  @override
  String toString() {
    return 'CreateInvoiceRouteArgs{key: $key, selectedDate: $selectedDate, onComplete: $onComplete, invoiceType: $invoiceType, invoiceToEdit: $invoiceToEdit, invoiceToDuplicate: $invoiceToDuplicate}';
  }
}

/// generated route for
/// [_i10.DailyCashSummaryPage]
class DailyCashSummaryRoute extends _i53.PageRouteInfo<void> {
  const DailyCashSummaryRoute({List<_i53.PageRouteInfo>? children})
    : super(DailyCashSummaryRoute.name, initialChildren: children);

  static const String name = 'DailyCashSummaryRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return _i53.WrappedRoute(child: const _i10.DailyCashSummaryPage());
    },
  );
}

/// generated route for
/// [_i11.EditProductPage]
class EditProductRoute extends _i53.PageRouteInfo<EditProductRouteArgs> {
  EditProductRoute({
    _i54.Key? key,
    required _i59.LiquorItem liquorItem,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         EditProductRoute.name,
         args: EditProductRouteArgs(key: key, liquorItem: liquorItem),
         initialChildren: children,
       );

  static const String name = 'EditProductRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProductRouteArgs>();
      return _i11.EditProductPage(key: args.key, liquorItem: args.liquorItem);
    },
  );
}

class EditProductRouteArgs {
  const EditProductRouteArgs({this.key, required this.liquorItem});

  final _i54.Key? key;

  final _i59.LiquorItem liquorItem;

  @override
  String toString() {
    return 'EditProductRouteArgs{key: $key, liquorItem: $liquorItem}';
  }
}

/// generated route for
/// [_i12.EmployeeDashboardPage]
class EmployeeDashboardRoute extends _i53.PageRouteInfo<void> {
  const EmployeeDashboardRoute({List<_i53.PageRouteInfo>? children})
    : super(EmployeeDashboardRoute.name, initialChildren: children);

  static const String name = 'EmployeeDashboardRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i12.EmployeeDashboardPage();
    },
  );
}

/// generated route for
/// [_i13.EmployeeFormPage]
class EmployeeFormRoute extends _i53.PageRouteInfo<EmployeeFormRouteArgs> {
  EmployeeFormRoute({
    _i54.Key? key,
    int? employeeId,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         EmployeeFormRoute.name,
         args: EmployeeFormRouteArgs(key: key, employeeId: employeeId),
         initialChildren: children,
       );

  static const String name = 'EmployeeFormRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EmployeeFormRouteArgs>(
        orElse: () => const EmployeeFormRouteArgs(),
      );
      return _i13.EmployeeFormPage(key: args.key, employeeId: args.employeeId);
    },
  );
}

class EmployeeFormRouteArgs {
  const EmployeeFormRouteArgs({this.key, this.employeeId});

  final _i54.Key? key;

  final int? employeeId;

  @override
  String toString() {
    return 'EmployeeFormRouteArgs{key: $key, employeeId: $employeeId}';
  }
}

/// generated route for
/// [_i14.GeneratePayrollPage]
class GeneratePayrollRoute extends _i53.PageRouteInfo<void> {
  const GeneratePayrollRoute({List<_i53.PageRouteInfo>? children})
    : super(GeneratePayrollRoute.name, initialChildren: children);

  static const String name = 'GeneratePayrollRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i14.GeneratePayrollPage();
    },
  );
}

/// generated route for
/// [_i15.HotelSalesPage]
class HotelSalesRoute extends _i53.PageRouteInfo<void> {
  const HotelSalesRoute({List<_i53.PageRouteInfo>? children})
    : super(HotelSalesRoute.name, initialChildren: children);

  static const String name = 'HotelSalesRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i15.HotelSalesPage();
    },
  );
}

/// generated route for
/// [_i16.HotelSummaryPage]
class HotelSummaryRoute extends _i53.PageRouteInfo<HotelSummaryRouteArgs> {
  HotelSummaryRoute({
    _i54.Key? key,
    required _i60.HotelSummaryRequestParams hotelSummaryRequestParams,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         HotelSummaryRoute.name,
         args: HotelSummaryRouteArgs(
           key: key,
           hotelSummaryRequestParams: hotelSummaryRequestParams,
         ),
         initialChildren: children,
       );

  static const String name = 'HotelSummaryRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HotelSummaryRouteArgs>();
      return _i16.HotelSummaryPage(
        key: args.key,
        hotelSummaryRequestParams: args.hotelSummaryRequestParams,
      );
    },
  );
}

class HotelSummaryRouteArgs {
  const HotelSummaryRouteArgs({
    this.key,
    required this.hotelSummaryRequestParams,
  });

  final _i54.Key? key;

  final _i60.HotelSummaryRequestParams hotelSummaryRequestParams;

  @override
  String toString() {
    return 'HotelSummaryRouteArgs{key: $key, hotelSummaryRequestParams: $hotelSummaryRequestParams}';
  }
}

/// generated route for
/// [_i17.InventoryDashboardPage]
class InventoryDashboardRoute extends _i53.PageRouteInfo<void> {
  const InventoryDashboardRoute({List<_i53.PageRouteInfo>? children})
    : super(InventoryDashboardRoute.name, initialChildren: children);

  static const String name = 'InventoryDashboardRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i17.InventoryDashboardPage();
    },
  );
}

/// generated route for
/// [_i18.InvoiceDetailsPage]
class InvoiceDetailsRoute extends _i53.PageRouteInfo<InvoiceDetailsRouteArgs> {
  InvoiceDetailsRoute({
    _i54.Key? key,
    required _i58.InvoiceItem invoice,
    dynamic Function()? onSubmit,
    dynamic Function()? onDelete,
    dynamic Function()? onCompleted,
    required _i57.InvoiceType invoiceType,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         InvoiceDetailsRoute.name,
         args: InvoiceDetailsRouteArgs(
           key: key,
           invoice: invoice,
           onSubmit: onSubmit,
           onDelete: onDelete,
           onCompleted: onCompleted,
           invoiceType: invoiceType,
         ),
         initialChildren: children,
       );

  static const String name = 'InvoiceDetailsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceDetailsRouteArgs>();
      return _i18.InvoiceDetailsPage(
        key: args.key,
        invoice: args.invoice,
        onSubmit: args.onSubmit,
        onDelete: args.onDelete,
        onCompleted: args.onCompleted,
        invoiceType: args.invoiceType,
      );
    },
  );
}

class InvoiceDetailsRouteArgs {
  const InvoiceDetailsRouteArgs({
    this.key,
    required this.invoice,
    this.onSubmit,
    this.onDelete,
    this.onCompleted,
    required this.invoiceType,
  });

  final _i54.Key? key;

  final _i58.InvoiceItem invoice;

  final dynamic Function()? onSubmit;

  final dynamic Function()? onDelete;

  final dynamic Function()? onCompleted;

  final _i57.InvoiceType invoiceType;

  @override
  String toString() {
    return 'InvoiceDetailsRouteArgs{key: $key, invoice: $invoice, onSubmit: $onSubmit, onDelete: $onDelete, onCompleted: $onCompleted, invoiceType: $invoiceType}';
  }
}

/// generated route for
/// [_i19.InvoiceEditPage]
class InvoiceEditRoute extends _i53.PageRouteInfo<InvoiceEditRouteArgs> {
  InvoiceEditRoute({
    _i54.Key? key,
    _i58.InvoiceItem? invoice,
    dynamic Function()? onSave,
    required _i57.InvoiceType invoiceType,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         InvoiceEditRoute.name,
         args: InvoiceEditRouteArgs(
           key: key,
           invoice: invoice,
           onSave: onSave,
           invoiceType: invoiceType,
         ),
         initialChildren: children,
       );

  static const String name = 'InvoiceEditRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<InvoiceEditRouteArgs>();
      return _i53.WrappedRoute(
        child: _i19.InvoiceEditPage(
          key: args.key,
          invoice: args.invoice,
          onSave: args.onSave,
          invoiceType: args.invoiceType,
        ),
      );
    },
  );
}

class InvoiceEditRouteArgs {
  const InvoiceEditRouteArgs({
    this.key,
    this.invoice,
    this.onSave,
    required this.invoiceType,
  });

  final _i54.Key? key;

  final _i58.InvoiceItem? invoice;

  final dynamic Function()? onSave;

  final _i57.InvoiceType invoiceType;

  @override
  String toString() {
    return 'InvoiceEditRouteArgs{key: $key, invoice: $invoice, onSave: $onSave, invoiceType: $invoiceType}';
  }
}

/// generated route for
/// [_i20.InvoicePageWrapper]
class InvoiceRouteWrapper extends _i53.PageRouteInfo<void> {
  const InvoiceRouteWrapper({List<_i53.PageRouteInfo>? children})
    : super(InvoiceRouteWrapper.name, initialChildren: children);

  static const String name = 'InvoiceRouteWrapper';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i20.InvoicePageWrapper();
    },
  );
}

/// generated route for
/// [_i21.ItemDetailsPage]
class ItemDetailsRoute extends _i53.PageRouteInfo<ItemDetailsRouteArgs> {
  ItemDetailsRoute({
    _i54.Key? key,
    String? initialCategory,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ItemDetailsRoute.name,
         args: ItemDetailsRouteArgs(
           key: key,
           initialCategory: initialCategory,
         ),
         initialChildren: children,
       );

  static const String name = 'ItemDetailsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemDetailsRouteArgs>(
        orElse: () => const ItemDetailsRouteArgs(),
      );
      return _i21.ItemDetailsPage(
        key: args.key,
        initialCategory: args.initialCategory,
      );
    },
  );
}

class ItemDetailsRouteArgs {
  const ItemDetailsRouteArgs({this.key, this.initialCategory});

  final _i54.Key? key;

  final String? initialCategory;

  @override
  String toString() {
    return 'ItemDetailsRouteArgs{key: $key, initialCategory: $initialCategory}';
  }
}

/// generated route for
/// [_i22.ItemEditPage]
class ItemEditRoute extends _i53.PageRouteInfo<ItemEditRouteArgs> {
  ItemEditRoute({
    _i54.Key? key,
    _i61.ItemModel? item,
    bool isEditing = false,
    String? initialItemName,
    String? initialPurpose,
    String? initialCategory,
    bool asBottomSheet = false,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ItemEditRoute.name,
         args: ItemEditRouteArgs(
           key: key,
           item: item,
           isEditing: isEditing,
           initialItemName: initialItemName,
           initialPurpose: initialPurpose,
           initialCategory: initialCategory,
           asBottomSheet: asBottomSheet,
         ),
         initialChildren: children,
       );

  static const String name = 'ItemEditRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemEditRouteArgs>(
        orElse: () => const ItemEditRouteArgs(),
      );
      return _i22.ItemEditPage(
        key: args.key,
        item: args.item,
        isEditing: args.isEditing,
        initialItemName: args.initialItemName,
        initialPurpose: args.initialPurpose,
        initialCategory: args.initialCategory,
        asBottomSheet: args.asBottomSheet,
      );
    },
  );
}

class ItemEditRouteArgs {
  const ItemEditRouteArgs({
    this.key,
    this.item,
    this.isEditing = false,
    this.initialItemName,
    this.initialPurpose,
    this.initialCategory,
    this.asBottomSheet = false,
  });

  final _i54.Key? key;

  final _i61.ItemModel? item;

  final bool isEditing;

  final String? initialItemName;

  final String? initialPurpose;

  final String? initialCategory;

  final bool asBottomSheet;

  @override
  String toString() {
    return 'ItemEditRouteArgs{key: $key, item: $item, isEditing: $isEditing, initialItemName: $initialItemName, initialPurpose: $initialPurpose, initialCategory: $initialCategory, asBottomSheet: $asBottomSheet}';
  }
}

/// generated route for
/// [_i23.LanguageSelectionPage]
class LanguageSelectionRoute extends _i53.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i53.PageRouteInfo>? children})
    : super(LanguageSelectionRoute.name, initialChildren: children);

  static const String name = 'LanguageSelectionRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i23.LanguageSelectionPage();
    },
  );
}

/// generated route for
/// [_i24.LiquorPricePage]
class LiquorPriceRoute extends _i53.PageRouteInfo<void> {
  const LiquorPriceRoute({List<_i53.PageRouteInfo>? children})
    : super(LiquorPriceRoute.name, initialChildren: children);

  static const String name = 'LiquorPriceRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i24.LiquorPricePage();
    },
  );
}

/// generated route for
/// [_i25.LocalSetupPage]
class LocalSetupRoute extends _i53.PageRouteInfo<void> {
  const LocalSetupRoute({List<_i53.PageRouteInfo>? children})
    : super(LocalSetupRoute.name, initialChildren: children);

  static const String name = 'LocalSetupRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i25.LocalSetupPage();
    },
  );
}

/// generated route for
/// [_i26.LoginPage]
class LoginRoute extends _i53.PageRouteInfo<void> {
  const LoginRoute({List<_i53.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i26.LoginPage();
    },
  );
}

/// generated route for
/// [_i27.MainPage]
class MainRoute extends _i53.PageRouteInfo<void> {
  const MainRoute({List<_i53.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i27.MainPage();
    },
  );
}

/// generated route for
/// [_i28.MorePage]
class MoreRoute extends _i53.PageRouteInfo<void> {
  const MoreRoute({List<_i53.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i28.MorePage();
    },
  );
}

/// generated route for
/// [_i29.OpeningAmountPage]
class OpeningAmountRoute extends _i53.PageRouteInfo<OpeningAmountRouteArgs> {
  OpeningAmountRoute({
    _i54.Key? key,
    required _i56.DailyCashSummaryResponseModel response,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         OpeningAmountRoute.name,
         args: OpeningAmountRouteArgs(key: key, response: response),
         initialChildren: children,
       );

  static const String name = 'OpeningAmountRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OpeningAmountRouteArgs>();
      return _i29.OpeningAmountPage(key: args.key, response: args.response);
    },
  );
}

class OpeningAmountRouteArgs {
  const OpeningAmountRouteArgs({this.key, required this.response});

  final _i54.Key? key;

  final _i56.DailyCashSummaryResponseModel response;

  @override
  String toString() {
    return 'OpeningAmountRouteArgs{key: $key, response: $response}';
  }
}

/// generated route for
/// [_i30.OpeningPage]
class OpeningRoute extends _i53.PageRouteInfo<void> {
  const OpeningRoute({List<_i53.PageRouteInfo>? children})
    : super(OpeningRoute.name, initialChildren: children);

  static const String name = 'OpeningRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i30.OpeningPage();
    },
  );
}

/// generated route for
/// [_i31.OrderCheckInPage]
class OrderCheckInRoute extends _i53.PageRouteInfo<OrderCheckInRouteArgs> {
  OrderCheckInRoute({
    _i54.Key? key,
    required String cartJson,
    String? initialTableLabel,
    bool isExistingOrderAddition = false,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         OrderCheckInRoute.name,
         args: OrderCheckInRouteArgs(
           key: key,
           cartJson: cartJson,
           initialTableLabel: initialTableLabel,
           isExistingOrderAddition: isExistingOrderAddition,
         ),
         initialChildren: children,
       );

  static const String name = 'OrderCheckInRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderCheckInRouteArgs>();
      return _i31.OrderCheckInPage(
        key: args.key,
        cartJson: args.cartJson,
        initialTableLabel: args.initialTableLabel,
        isExistingOrderAddition: args.isExistingOrderAddition,
      );
    },
  );
}

class OrderCheckInRouteArgs {
  const OrderCheckInRouteArgs({
    this.key,
    required this.cartJson,
    this.initialTableLabel,
    this.isExistingOrderAddition = false,
  });

  final _i54.Key? key;

  final String cartJson;

  final String? initialTableLabel;

  final bool isExistingOrderAddition;

  @override
  String toString() {
    return 'OrderCheckInRouteArgs{key: $key, cartJson: $cartJson, initialTableLabel: $initialTableLabel, isExistingOrderAddition: $isExistingOrderAddition}';
  }
}

/// generated route for
/// [_i32.OrderDetailPage]
class OrderDetailRoute extends _i53.PageRouteInfo<OrderDetailRouteArgs> {
  OrderDetailRoute({
    _i54.Key? key,
    required String orderName,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         OrderDetailRoute.name,
         args: OrderDetailRouteArgs(key: key, orderName: orderName),
         initialChildren: children,
       );

  static const String name = 'OrderDetailRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderDetailRouteArgs>();
      return _i32.OrderDetailPage(key: args.key, orderName: args.orderName);
    },
  );
}

class OrderDetailRouteArgs {
  const OrderDetailRouteArgs({this.key, required this.orderName});

  final _i54.Key? key;

  final String orderName;

  @override
  String toString() {
    return 'OrderDetailRouteArgs{key: $key, orderName: $orderName}';
  }
}

/// generated route for
/// [_i33.OrderKotReviewPage]
class OrderKotReviewRoute extends _i53.PageRouteInfo<OrderKotReviewRouteArgs> {
  OrderKotReviewRoute({
    _i54.Key? key,
    required String cartJson,
    required String tableNumber,
    required String displayTableLabel,
    String? customerMetaNotes,
    bool hideGuestCount = false,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         OrderKotReviewRoute.name,
         args: OrderKotReviewRouteArgs(
           key: key,
           cartJson: cartJson,
           tableNumber: tableNumber,
           displayTableLabel: displayTableLabel,
           customerMetaNotes: customerMetaNotes,
           hideGuestCount: hideGuestCount,
         ),
         initialChildren: children,
       );

  static const String name = 'OrderKotReviewRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OrderKotReviewRouteArgs>();
      return _i53.WrappedRoute(
        child: _i33.OrderKotReviewPage(
          key: args.key,
          cartJson: args.cartJson,
          tableNumber: args.tableNumber,
          displayTableLabel: args.displayTableLabel,
          customerMetaNotes: args.customerMetaNotes,
          hideGuestCount: args.hideGuestCount,
        ),
      );
    },
  );
}

class OrderKotReviewRouteArgs {
  const OrderKotReviewRouteArgs({
    this.key,
    required this.cartJson,
    required this.tableNumber,
    required this.displayTableLabel,
    this.customerMetaNotes,
    this.hideGuestCount = false,
  });

  final _i54.Key? key;

  final String cartJson;

  final String tableNumber;

  final String displayTableLabel;

  final String? customerMetaNotes;

  final bool hideGuestCount;

  @override
  String toString() {
    return 'OrderKotReviewRouteArgs{key: $key, cartJson: $cartJson, tableNumber: $tableNumber, displayTableLabel: $displayTableLabel, customerMetaNotes: $customerMetaNotes, hideGuestCount: $hideGuestCount}';
  }
}

/// generated route for
/// [_i34.OrderPage]
class OrderRoute extends _i53.PageRouteInfo<void> {
  const OrderRoute({List<_i53.PageRouteInfo>? children})
    : super(OrderRoute.name, initialChildren: children);

  static const String name = 'OrderRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i34.OrderPage();
    },
  );
}

/// generated route for
/// [_i35.OrderQotHubPage]
class OrderQotHubRoute extends _i53.PageRouteInfo<void> {
  const OrderQotHubRoute({List<_i53.PageRouteInfo>? children})
    : super(OrderQotHubRoute.name, initialChildren: children);

  static const String name = 'OrderQotHubRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i35.OrderQotHubPage();
    },
  );
}

/// generated route for
/// [_i36.OrganizationCodePage]
class OrganizationCodeRoute extends _i53.PageRouteInfo<void> {
  const OrganizationCodeRoute({List<_i53.PageRouteInfo>? children})
    : super(OrganizationCodeRoute.name, initialChildren: children);

  static const String name = 'OrganizationCodeRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i36.OrganizationCodePage();
    },
  );
}

/// generated route for
/// [_i37.PartyDetailsPage]
class PartyDetailsRoute extends _i53.PageRouteInfo<PartyDetailsRouteArgs> {
  PartyDetailsRoute({
    _i54.Key? key,
    bool deferInitialFetch = false,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PartyDetailsRoute.name,
         args: PartyDetailsRouteArgs(
           key: key,
           deferInitialFetch: deferInitialFetch,
         ),
         initialChildren: children,
       );

  static const String name = 'PartyDetailsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyDetailsRouteArgs>(
        orElse: () => const PartyDetailsRouteArgs(),
      );
      return _i37.PartyDetailsPage(
        key: args.key,
        deferInitialFetch: args.deferInitialFetch,
      );
    },
  );
}

class PartyDetailsRouteArgs {
  const PartyDetailsRouteArgs({this.key, this.deferInitialFetch = false});

  final _i54.Key? key;

  final bool deferInitialFetch;

  @override
  String toString() {
    return 'PartyDetailsRouteArgs{key: $key, deferInitialFetch: $deferInitialFetch}';
  }
}

/// generated route for
/// [_i38.PartyEditPage]
class PartyEditRoute extends _i53.PageRouteInfo<PartyEditRouteArgs> {
  PartyEditRoute({
    _i54.Key? key,
    _i62.PartyModel? party,
    bool isEditing = false,
    String? presetRole,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PartyEditRoute.name,
         args: PartyEditRouteArgs(
           key: key,
           party: party,
           isEditing: isEditing,
           presetRole: presetRole,
         ),
         initialChildren: children,
       );

  static const String name = 'PartyEditRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyEditRouteArgs>(
        orElse: () => const PartyEditRouteArgs(),
      );
      return _i38.PartyEditPage(
        key: args.key,
        party: args.party,
        isEditing: args.isEditing,
        presetRole: args.presetRole,
      );
    },
  );
}

class PartyEditRouteArgs {
  const PartyEditRouteArgs({
    this.key,
    this.party,
    this.isEditing = false,
    this.presetRole,
  });

  final _i54.Key? key;

  final _i62.PartyModel? party;

  final bool isEditing;

  final String? presetRole;

  @override
  String toString() {
    return 'PartyEditRouteArgs{key: $key, party: $party, isEditing: $isEditing, presetRole: $presetRole}';
  }
}

/// generated route for
/// [_i39.PartyInvoicePage]
class PartyInvoiceRoute extends _i53.PageRouteInfo<PartyInvoiceRouteArgs> {
  PartyInvoiceRoute({
    _i54.Key? key,
    bool canPop = true,
    String? partyName,
    DateTime? date,
    bool showScaffold = true,
    _i57.InvoiceType? invoiceType,
    String? itemName,
    _i54.ValueNotifier<String>? tabbedParentSearchQuery,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PartyInvoiceRoute.name,
         args: PartyInvoiceRouteArgs(
           key: key,
           canPop: canPop,
           partyName: partyName,
           date: date,
           showScaffold: showScaffold,
           invoiceType: invoiceType,
           itemName: itemName,
           tabbedParentSearchQuery: tabbedParentSearchQuery,
         ),
         initialChildren: children,
       );

  static const String name = 'PartyInvoiceRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyInvoiceRouteArgs>(
        orElse: () => const PartyInvoiceRouteArgs(),
      );
      return _i53.WrappedRoute(
        child: _i39.PartyInvoicePage(
          key: args.key,
          canPop: args.canPop,
          partyName: args.partyName,
          date: args.date,
          showScaffold: args.showScaffold,
          invoiceType: args.invoiceType,
          itemName: args.itemName,
          tabbedParentSearchQuery: args.tabbedParentSearchQuery,
        ),
      );
    },
  );
}

class PartyInvoiceRouteArgs {
  const PartyInvoiceRouteArgs({
    this.key,
    this.canPop = true,
    this.partyName,
    this.date,
    this.showScaffold = true,
    this.invoiceType,
    this.itemName,
    this.tabbedParentSearchQuery,
  });

  final _i54.Key? key;

  final bool canPop;

  final String? partyName;

  final DateTime? date;

  final bool showScaffold;

  final _i57.InvoiceType? invoiceType;

  final String? itemName;

  final _i54.ValueNotifier<String>? tabbedParentSearchQuery;

  @override
  String toString() {
    return 'PartyInvoiceRouteArgs{key: $key, canPop: $canPop, partyName: $partyName, date: $date, showScaffold: $showScaffold, invoiceType: $invoiceType, itemName: $itemName, tabbedParentSearchQuery: $tabbedParentSearchQuery}';
  }
}

/// generated route for
/// [_i40.PartyInvoiceTabbedPage]
class PartyInvoiceTabbedRoute
    extends _i53.PageRouteInfo<PartyInvoiceTabbedRouteArgs> {
  PartyInvoiceTabbedRoute({
    _i54.Key? key,
    required String partyName,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PartyInvoiceTabbedRoute.name,
         args: PartyInvoiceTabbedRouteArgs(key: key, partyName: partyName),
         initialChildren: children,
       );

  static const String name = 'PartyInvoiceTabbedRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyInvoiceTabbedRouteArgs>();
      return _i40.PartyInvoiceTabbedPage(
        key: args.key,
        partyName: args.partyName,
      );
    },
  );
}

class PartyInvoiceTabbedRouteArgs {
  const PartyInvoiceTabbedRouteArgs({this.key, required this.partyName});

  final _i54.Key? key;

  final String partyName;

  @override
  String toString() {
    return 'PartyInvoiceTabbedRouteArgs{key: $key, partyName: $partyName}';
  }
}

/// generated route for
/// [_i41.PartyStatementPage]
class PartyStatementRoute extends _i53.PageRouteInfo<PartyStatementRouteArgs> {
  PartyStatementRoute({
    _i54.Key? key,
    required String partyName,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PartyStatementRoute.name,
         args: PartyStatementRouteArgs(key: key, partyName: partyName),
         initialChildren: children,
       );

  static const String name = 'PartyStatementRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PartyStatementRouteArgs>();
      return _i41.PartyStatementPage(key: args.key, partyName: args.partyName);
    },
  );
}

class PartyStatementRouteArgs {
  const PartyStatementRouteArgs({this.key, required this.partyName});

  final _i54.Key? key;

  final String partyName;

  @override
  String toString() {
    return 'PartyStatementRouteArgs{key: $key, partyName: $partyName}';
  }
}

/// generated route for
/// [_i42.PaymentMethodsListPage]
class PaymentMethodsListRoute extends _i53.PageRouteInfo<void> {
  const PaymentMethodsListRoute({List<_i53.PageRouteInfo>? children})
    : super(PaymentMethodsListRoute.name, initialChildren: children);

  static const String name = 'PaymentMethodsListRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i42.PaymentMethodsListPage();
    },
  );
}

/// generated route for
/// [_i43.PayrollDetailPage]
class PayrollDetailRoute extends _i53.PageRouteInfo<PayrollDetailRouteArgs> {
  PayrollDetailRoute({
    _i54.Key? key,
    required _i63.PayrollModel payroll,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PayrollDetailRoute.name,
         args: PayrollDetailRouteArgs(key: key, payroll: payroll),
         initialChildren: children,
       );

  static const String name = 'PayrollDetailRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PayrollDetailRouteArgs>();
      return _i43.PayrollDetailPage(key: args.key, payroll: args.payroll);
    },
  );
}

class PayrollDetailRouteArgs {
  const PayrollDetailRouteArgs({this.key, required this.payroll});

  final _i54.Key? key;

  final _i63.PayrollModel payroll;

  @override
  String toString() {
    return 'PayrollDetailRouteArgs{key: $key, payroll: $payroll}';
  }
}

/// generated route for
/// [_i44.PayrollListPage]
class PayrollListRoute extends _i53.PageRouteInfo<void> {
  const PayrollListRoute({List<_i53.PageRouteInfo>? children})
    : super(PayrollListRoute.name, initialChildren: children);

  static const String name = 'PayrollListRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i44.PayrollListPage();
    },
  );
}

/// generated route for
/// [_i45.PremiumPaywallPage]
class PremiumPaywallRoute extends _i53.PageRouteInfo<PremiumPaywallRouteArgs> {
  PremiumPaywallRoute({
    _i54.Key? key,
    bool fromSettings = false,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PremiumPaywallRoute.name,
         args: PremiumPaywallRouteArgs(key: key, fromSettings: fromSettings),
         initialChildren: children,
       );

  static const String name = 'PremiumPaywallRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PremiumPaywallRouteArgs>(
        orElse: () => const PremiumPaywallRouteArgs(),
      );
      return _i45.PremiumPaywallPage(
        key: args.key,
        fromSettings: args.fromSettings,
      );
    },
  );
}

class PremiumPaywallRouteArgs {
  const PremiumPaywallRouteArgs({this.key, this.fromSettings = false});

  final _i54.Key? key;

  final bool fromSettings;

  @override
  String toString() {
    return 'PremiumPaywallRouteArgs{key: $key, fromSettings: $fromSettings}';
  }
}

/// generated route for
/// [_i46.PreviousStockDetailsPage]
class PreviousStockDetailsRoute
    extends _i53.PageRouteInfo<PreviousStockDetailsRouteArgs> {
  PreviousStockDetailsRoute({
    _i54.Key? key,
    required String reportingDate,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         PreviousStockDetailsRoute.name,
         args: PreviousStockDetailsRouteArgs(
           key: key,
           reportingDate: reportingDate,
         ),
         initialChildren: children,
       );

  static const String name = 'PreviousStockDetailsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PreviousStockDetailsRouteArgs>();
      return _i46.PreviousStockDetailsPage(
        key: args.key,
        reportingDate: args.reportingDate,
      );
    },
  );
}

class PreviousStockDetailsRouteArgs {
  const PreviousStockDetailsRouteArgs({this.key, required this.reportingDate});

  final _i54.Key? key;

  final String reportingDate;

  @override
  String toString() {
    return 'PreviousStockDetailsRouteArgs{key: $key, reportingDate: $reportingDate}';
  }
}

/// generated route for
/// [_i47.PreviousStockPage]
class PreviousStockRoute extends _i53.PageRouteInfo<void> {
  const PreviousStockRoute({List<_i53.PageRouteInfo>? children})
    : super(PreviousStockRoute.name, initialChildren: children);

  static const String name = 'PreviousStockRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i47.PreviousStockPage();
    },
  );
}

/// generated route for
/// [_i48.ProductSettingsPage]
class ProductSettingsRoute
    extends _i53.PageRouteInfo<ProductSettingsRouteArgs> {
  ProductSettingsRoute({
    _i54.Key? key,
    required List<_i59.LiquorItem> products,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         ProductSettingsRoute.name,
         args: ProductSettingsRouteArgs(key: key, products: products),
         initialChildren: children,
       );

  static const String name = 'ProductSettingsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductSettingsRouteArgs>();
      return _i48.ProductSettingsPage(key: args.key, products: args.products);
    },
  );
}

class ProductSettingsRouteArgs {
  const ProductSettingsRouteArgs({this.key, required this.products});

  final _i54.Key? key;

  final List<_i59.LiquorItem> products;

  @override
  String toString() {
    return 'ProductSettingsRouteArgs{key: $key, products: $products}';
  }
}

/// generated route for
/// [_i49.QuickAddItemsPage]
class QuickAddItemsRoute extends _i53.PageRouteInfo<QuickAddItemsRouteArgs> {
  QuickAddItemsRoute({
    _i64.Key? key,
    required _i57.InvoiceType invoiceType,
    bool fromQuickSales = false,
    bool fromRestaurantOrder = false,
    String? initialTableNumber,
    String? menuTitleSuffix,
    String? initialRestaurantCartJson,
    int? Function(_i61.ItemModel)? onItemSelected,
    _i64.ValueNotifier<double>? cartTotalNotifier,
    Map<String, int>? initialQuantities,
    _i64.ValueNotifier<List<_i49.SelectedItemSummary>>? selectedItemsNotifier,
    void Function(String)? onIncreaseItem,
    void Function(String)? onDecreaseItem,
    bool showDoneButton = false,
    bool showPartySelector = false,
    String? initialPartyName,
    void Function(String, {String? currency})? onPartySelected,
    _i64.VoidCallback? onDone,
    List<_i53.PageRouteInfo>? children,
  }) : super(
         QuickAddItemsRoute.name,
         args: QuickAddItemsRouteArgs(
           key: key,
           invoiceType: invoiceType,
           fromQuickSales: fromQuickSales,
           fromRestaurantOrder: fromRestaurantOrder,
           initialTableNumber: initialTableNumber,
           menuTitleSuffix: menuTitleSuffix,
           initialRestaurantCartJson: initialRestaurantCartJson,
           onItemSelected: onItemSelected,
           cartTotalNotifier: cartTotalNotifier,
           initialQuantities: initialQuantities,
           selectedItemsNotifier: selectedItemsNotifier,
           onIncreaseItem: onIncreaseItem,
           onDecreaseItem: onDecreaseItem,
           showDoneButton: showDoneButton,
           showPartySelector: showPartySelector,
           initialPartyName: initialPartyName,
           onPartySelected: onPartySelected,
           onDone: onDone,
         ),
         initialChildren: children,
       );

  static const String name = 'QuickAddItemsRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuickAddItemsRouteArgs>();
      return _i53.WrappedRoute(
        child: _i49.QuickAddItemsPage(
          key: args.key,
          invoiceType: args.invoiceType,
          fromQuickSales: args.fromQuickSales,
          fromRestaurantOrder: args.fromRestaurantOrder,
          initialTableNumber: args.initialTableNumber,
          menuTitleSuffix: args.menuTitleSuffix,
          initialRestaurantCartJson: args.initialRestaurantCartJson,
          onItemSelected: args.onItemSelected,
          cartTotalNotifier: args.cartTotalNotifier,
          initialQuantities: args.initialQuantities,
          selectedItemsNotifier: args.selectedItemsNotifier,
          onIncreaseItem: args.onIncreaseItem,
          onDecreaseItem: args.onDecreaseItem,
          showDoneButton: args.showDoneButton,
          showPartySelector: args.showPartySelector,
          initialPartyName: args.initialPartyName,
          onPartySelected: args.onPartySelected,
          onDone: args.onDone,
        ),
      );
    },
  );
}

class QuickAddItemsRouteArgs {
  const QuickAddItemsRouteArgs({
    this.key,
    required this.invoiceType,
    this.fromQuickSales = false,
    this.fromRestaurantOrder = false,
    this.initialTableNumber,
    this.menuTitleSuffix,
    this.initialRestaurantCartJson,
    this.onItemSelected,
    this.cartTotalNotifier,
    this.initialQuantities,
    this.selectedItemsNotifier,
    this.onIncreaseItem,
    this.onDecreaseItem,
    this.showDoneButton = false,
    this.showPartySelector = false,
    this.initialPartyName,
    this.onPartySelected,
    this.onDone,
  });

  final _i64.Key? key;

  final _i57.InvoiceType invoiceType;

  final bool fromQuickSales;

  final bool fromRestaurantOrder;

  final String? initialTableNumber;

  final String? menuTitleSuffix;

  final String? initialRestaurantCartJson;

  final int? Function(_i61.ItemModel)? onItemSelected;

  final _i64.ValueNotifier<double>? cartTotalNotifier;

  final Map<String, int>? initialQuantities;

  final _i64.ValueNotifier<List<_i49.SelectedItemSummary>>?
  selectedItemsNotifier;

  final void Function(String)? onIncreaseItem;

  final void Function(String)? onDecreaseItem;

  final bool showDoneButton;

  final bool showPartySelector;

  final String? initialPartyName;

  final void Function(String, {String? currency})? onPartySelected;

  final _i64.VoidCallback? onDone;

  @override
  String toString() {
    return 'QuickAddItemsRouteArgs{key: $key, invoiceType: $invoiceType, fromQuickSales: $fromQuickSales, fromRestaurantOrder: $fromRestaurantOrder, initialTableNumber: $initialTableNumber, menuTitleSuffix: $menuTitleSuffix, initialRestaurantCartJson: $initialRestaurantCartJson, onItemSelected: $onItemSelected, cartTotalNotifier: $cartTotalNotifier, initialQuantities: $initialQuantities, selectedItemsNotifier: $selectedItemsNotifier, onIncreaseItem: $onIncreaseItem, onDecreaseItem: $onDecreaseItem, showDoneButton: $showDoneButton, showPartySelector: $showPartySelector, initialPartyName: $initialPartyName, onPartySelected: $onPartySelected, onDone: $onDone}';
  }
}

/// generated route for
/// [_i50.RestaurantFloorPlanPage]
class RestaurantFloorPlanRoute extends _i53.PageRouteInfo<void> {
  const RestaurantFloorPlanRoute({List<_i53.PageRouteInfo>? children})
    : super(RestaurantFloorPlanRoute.name, initialChildren: children);

  static const String name = 'RestaurantFloorPlanRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i50.RestaurantFloorPlanPage();
    },
  );
}

/// generated route for
/// [_i51.StartupSplashPage]
class StartupSplashRoute extends _i53.PageRouteInfo<void> {
  const StartupSplashRoute({List<_i53.PageRouteInfo>? children})
    : super(StartupSplashRoute.name, initialChildren: children);

  static const String name = 'StartupSplashRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i51.StartupSplashPage();
    },
  );
}

/// generated route for
/// [_i52.StockUploadPage]
class StockUploadRoute extends _i53.PageRouteInfo<void> {
  const StockUploadRoute({List<_i53.PageRouteInfo>? children})
    : super(StockUploadRoute.name, initialChildren: children);

  static const String name = 'StockUploadRoute';

  static _i53.PageInfo page = _i53.PageInfo(
    name,
    builder: (data) {
      return const _i52.StockUploadPage();
    },
  );
}
