// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hotel/src/core/di/register_modules.dart' as _i694;
import 'package:hotel/src/core/internet/internet_info.dart' as _i36;
import 'package:hotel/src/core/l10n/app_locale_service.dart' as _i118;
import 'package:hotel/src/core/routes/app_router.dart' as _i648;
import 'package:hotel/src/core/services/currency/app_currency_service.dart'
    as _i435;
import 'package:hotel/src/core/services/display_precision/app_display_precision_service.dart'
    as _i864;
import 'package:hotel/src/core/services/force_update/force_update_service.dart'
    as _i348;
import 'package:hotel/src/core/services/local/local_db.dart' as _i121;
import 'package:hotel/src/core/themes/app_theme_mode_service.dart' as _i91;
import 'package:hotel/src/features/action/data/datasources/item_local_data_source.dart'
    as _i504;
import 'package:hotel/src/features/action/data/datasources/item_remote_data_source.dart'
    as _i875;
import 'package:hotel/src/features/action/data/datasources/party_local_data_source.dart'
    as _i111;
import 'package:hotel/src/features/action/data/datasources/party_remote_data_source.dart'
    as _i356;
import 'package:hotel/src/features/action/data/datasources/payment_analytics_local_data_source.dart'
    as _i336;
import 'package:hotel/src/features/action/data/datasources/payment_analytics_remote_data_source.dart'
    as _i987;
import 'package:hotel/src/features/action/data/datasources/payment_local_data_source.dart'
    as _i486;
import 'package:hotel/src/features/action/data/datasources/payment_remote_data_source.dart'
    as _i557;
import 'package:hotel/src/features/action/data/repositories/item_repository_impl.dart'
    as _i517;
import 'package:hotel/src/features/action/data/repositories/party_repository_impl.dart'
    as _i161;
import 'package:hotel/src/features/action/data/repositories/payment_analytics_repository_impl.dart'
    as _i1017;
import 'package:hotel/src/features/action/data/repositories/payment_repository_impl.dart'
    as _i978;
import 'package:hotel/src/features/action/domain/repositories/item_repository.dart'
    as _i1007;
import 'package:hotel/src/features/action/domain/repositories/party_repository.dart'
    as _i489;
import 'package:hotel/src/features/action/domain/repositories/payment_analytics_repository.dart'
    as _i151;
import 'package:hotel/src/features/action/domain/repositories/payment_repository.dart'
    as _i175;
import 'package:hotel/src/features/action/domain/usecases/item_use_cases.dart'
    as _i545;
import 'package:hotel/src/features/action/domain/usecases/party_use_cases.dart'
    as _i178;
import 'package:hotel/src/features/action/domain/usecases/payment_analytics_use_case.dart'
    as _i326;
import 'package:hotel/src/features/action/domain/usecases/update_payment_use_case.dart'
    as _i896;
import 'package:hotel/src/features/action/presentation/cubit/item_cubit.dart'
    as _i326;
import 'package:hotel/src/features/action/presentation/cubit/party_cubit.dart'
    as _i922;
import 'package:hotel/src/features/action/presentation/cubit/payment_analytics_cubit.dart'
    as _i62;
import 'package:hotel/src/features/action/presentation/cubit/payment_cubit.dart'
    as _i61;
import 'package:hotel/src/features/backup/data/google_drive_api_client.dart'
    as _i1007;
import 'package:hotel/src/features/backup/data/google_drive_auth_service.dart'
    as _i520;
import 'package:hotel/src/features/backup/domain/auto_backup_coordinator.dart'
    as _i793;
import 'package:hotel/src/features/backup/domain/books_data_exporter.dart'
    as _i79;
import 'package:hotel/src/features/backup/domain/books_data_importer.dart'
    as _i531;
import 'package:hotel/src/features/backup/domain/books_delta_exporter.dart'
    as _i884;
import 'package:hotel/src/features/backup/domain/books_delta_importer.dart'
    as _i149;
import 'package:hotel/src/features/backup/domain/google_drive_backup_service.dart'
    as _i134;
import 'package:hotel/src/features/backup/domain/google_drive_restore_service.dart'
    as _i604;
import 'package:hotel/src/features/category/data/datasources/category_local_data_source.dart'
    as _i750;
import 'package:hotel/src/features/category/data/datasources/category_remote_data_source.dart'
    as _i144;
import 'package:hotel/src/features/category/data/repositories/category_repository_impl.dart'
    as _i984;
import 'package:hotel/src/features/category/domain/repositories/category_repository.dart'
    as _i178;
import 'package:hotel/src/features/category/presentation/cubit/category_cubit.dart'
    as _i662;
import 'package:hotel/src/features/closing/data/datasources/hotel_summary_remote_data_source.dart'
    as _i927;
import 'package:hotel/src/features/closing/data/repositories/hotel_summary_repository_impl.dart'
    as _i587;
import 'package:hotel/src/features/closing/domain/repositories/hotel_summary_repository.dart'
    as _i90;
import 'package:hotel/src/features/closing/domain/usecases/create_hotel_summary_use_case.dart'
    as _i373;
import 'package:hotel/src/features/closing/domain/usecases/delete_hotel_summary_use_case.dart'
    as _i873;
import 'package:hotel/src/features/closing/domain/usecases/get_hotel_summaries_use_case.dart'
    as _i961;
import 'package:hotel/src/features/closing/domain/usecases/get_hotel_summary_by_id_use_case.dart'
    as _i202;
import 'package:hotel/src/features/closing/domain/usecases/update_hotel_summary_use_case.dart'
    as _i808;
import 'package:hotel/src/features/closing/presentation/bloc/hotel_summary_cubit.dart'
    as _i6;
import 'package:hotel/src/features/contact_book/data/datasources/contact_local_data_source.dart'
    as _i430;
import 'package:hotel/src/features/contact_book/data/datasources/contact_remote_data_source.dart'
    as _i595;
import 'package:hotel/src/features/contact_book/data/repositories/contact_repository_impl.dart'
    as _i812;
import 'package:hotel/src/features/contact_book/domain/repositories/contact_repository.dart'
    as _i173;
import 'package:hotel/src/features/contact_book/domain/usecases/create_contact_use_case.dart'
    as _i807;
import 'package:hotel/src/features/contact_book/domain/usecases/delete_contact_use_case.dart'
    as _i763;
import 'package:hotel/src/features/contact_book/domain/usecases/get_contact_by_id_use_case.dart'
    as _i349;
import 'package:hotel/src/features/contact_book/domain/usecases/get_contacts_use_case.dart'
    as _i1008;
import 'package:hotel/src/features/contact_book/domain/usecases/update_contact_use_case.dart'
    as _i283;
import 'package:hotel/src/features/contact_book/presentation/cubit/contact_cubit.dart'
    as _i596;
import 'package:hotel/src/features/dashboard/data/datasources/client_to_server_local_data_source.dart'
    as _i1037;
import 'package:hotel/src/features/dashboard/data/datasources/client_to_server_remote_data_source.dart'
    as _i628;
import 'package:hotel/src/features/dashboard/data/datasources/dashboard_summary_page_local_data_source.dart'
    as _i980;
import 'package:hotel/src/features/dashboard/data/datasources/dashboard_summary_page_remote_data_source.dart'
    as _i1045;
import 'package:hotel/src/features/dashboard/data/datasources/server_to_client_local_data_source.dart'
    as _i601;
import 'package:hotel/src/features/dashboard/data/datasources/server_to_client_remote_data_source.dart'
    as _i460;
import 'package:hotel/src/features/dashboard/data/repositories/client_to_server_repository_impl.dart'
    as _i47;
import 'package:hotel/src/features/dashboard/data/repositories/dashboard_summary_page_repository_impl.dart'
    as _i1044;
import 'package:hotel/src/features/dashboard/data/repositories/server_to_client_repository_impl.dart'
    as _i297;
import 'package:hotel/src/features/dashboard/domain/repositories/client_to_server_repository.dart'
    as _i631;
import 'package:hotel/src/features/dashboard/domain/repositories/dashboard_summary_page_repository.dart'
    as _i168;
import 'package:hotel/src/features/dashboard/domain/repositories/server_to_client_repository.dart'
    as _i932;
import 'package:hotel/src/features/dashboard/domain/usecases/client_to_server_use_case.dart'
    as _i965;
import 'package:hotel/src/features/dashboard/domain/usecases/dashboard_summary_page_use_case.dart'
    as _i889;
import 'package:hotel/src/features/dashboard/domain/usecases/hotel_sales_use_case.dart'
    as _i343;
import 'package:hotel/src/features/dashboard/domain/usecases/server_to_client_use_case.dart'
    as _i932;
import 'package:hotel/src/features/dashboard/presentation/bloc/client_to_server_cubit.dart'
    as _i863;
import 'package:hotel/src/features/dashboard/presentation/bloc/dashboard_summary_page_cubit.dart'
    as _i529;
import 'package:hotel/src/features/dashboard/presentation/bloc/hotel_sales_cubit.dart'
    as _i662;
import 'package:hotel/src/features/dashboard/presentation/bloc/server_to_client_cubit.dart'
    as _i241;
import 'package:hotel/src/features/employee/data/datasources/employee_local_data_source.dart'
    as _i484;
import 'package:hotel/src/features/employee/data/datasources/employee_remote_data_source.dart'
    as _i423;
import 'package:hotel/src/features/employee/data/repositories/employee_repository_impl.dart'
    as _i1065;
import 'package:hotel/src/features/employee/domain/repositories/employee_repository.dart'
    as _i44;
import 'package:hotel/src/features/employee/domain/usecases/employee_advance_use_case.dart'
    as _i881;
import 'package:hotel/src/features/employee/domain/usecases/employee_outstanding_use_case.dart'
    as _i116;
import 'package:hotel/src/features/employee/presentation/bloc/employee_advance_cubit.dart'
    as _i557;
import 'package:hotel/src/features/employee/presentation/bloc/employee_outstanding_cubit.dart'
    as _i38;
import 'package:hotel/src/features/employee_management/data/datasources/employee_management_local_data_source.dart'
    as _i58;
import 'package:hotel/src/features/employee_management/data/datasources/employee_management_remote_data_source.dart'
    as _i1030;
import 'package:hotel/src/features/employee_management/data/repositories/employee_management_repository_impl.dart'
    as _i1040;
import 'package:hotel/src/features/employee_management/domain/repositories/employee_management_repository.dart'
    as _i991;
import 'package:hotel/src/features/employee_management/domain/usecases/approve_reject_leave_use_case.dart'
    as _i925;
import 'package:hotel/src/features/employee_management/domain/usecases/create_employee_use_case.dart'
    as _i882;
import 'package:hotel/src/features/employee_management/domain/usecases/generate_payroll_use_case.dart'
    as _i436;
import 'package:hotel/src/features/employee_management/domain/usecases/get_attendance_use_case.dart'
    as _i120;
import 'package:hotel/src/features/employee_management/domain/usecases/get_dashboard_use_case.dart'
    as _i248;
import 'package:hotel/src/features/employee_management/domain/usecases/get_employees_use_case.dart'
    as _i277;
import 'package:hotel/src/features/employee_management/domain/usecases/get_leave_applications_use_case.dart'
    as _i66;
import 'package:hotel/src/features/employee_management/domain/usecases/get_leave_balance_use_case.dart'
    as _i791;
import 'package:hotel/src/features/employee_management/domain/usecases/get_payrolls_use_case.dart'
    as _i22;
import 'package:hotel/src/features/employee_management/domain/usecases/record_attendance_use_case.dart'
    as _i552;
import 'package:hotel/src/features/employee_management/domain/usecases/submit_leave_application_use_case.dart'
    as _i1051;
import 'package:hotel/src/features/employee_management/presentation/bloc/attendance_cubit.dart'
    as _i422;
import 'package:hotel/src/features/employee_management/presentation/bloc/dashboard_cubit.dart'
    as _i570;
import 'package:hotel/src/features/employee_management/presentation/bloc/employee_cubit.dart'
    as _i1066;
import 'package:hotel/src/features/employee_management/presentation/bloc/leave_application_cubit.dart'
    as _i663;
import 'package:hotel/src/features/employee_management/presentation/bloc/payroll_cubit.dart'
    as _i336;
import 'package:hotel/src/features/expense/data/datasources/expense_local_data_source.dart'
    as _i815;
import 'package:hotel/src/features/expense/data/datasources/expense_remote_data_source.dart'
    as _i81;
import 'package:hotel/src/features/expense/data/repositories/expense_repository_impl.dart'
    as _i348;
import 'package:hotel/src/features/expense/domain/repositories/expense_repository.dart'
    as _i196;
import 'package:hotel/src/features/expense/domain/usecases/create_expense_use_case.dart'
    as _i336;
import 'package:hotel/src/features/expense/presentation/cubits/create_expense/create_expense_cubit.dart'
    as _i624;
import 'package:hotel/src/features/file_creation/data/datasources/file_creation_remote_data_source.dart'
    as _i1027;
import 'package:hotel/src/features/file_creation/data/repositories/file_creation_repository_impl.dart'
    as _i215;
import 'package:hotel/src/features/file_creation/domain/repositories/file_creation_repository.dart'
    as _i501;
import 'package:hotel/src/features/file_creation/domain/usecases/file_creation_use_case.dart'
    as _i153;
import 'package:hotel/src/features/file_creation/presentation/cubit/file_creation_cubit.dart'
    as _i48;
import 'package:hotel/src/features/hotel_summary/data/datasources/daily_cash_summary_local_data_source.dart'
    as _i831;
import 'package:hotel/src/features/hotel_summary/data/datasources/daily_cash_summary_remote_data_source.dart'
    as _i358;
import 'package:hotel/src/features/hotel_summary/data/repositories/daily_cash_summary_repository_impl.dart'
    as _i700;
import 'package:hotel/src/features/hotel_summary/domain/repositories/daily_cash_summary_repository.dart'
    as _i50;
import 'package:hotel/src/features/hotel_summary/domain/usecases/create_daily_summary_use_case.dart'
    as _i675;
import 'package:hotel/src/features/hotel_summary/domain/usecases/delete_daily_summary_use_case.dart'
    as _i437;
import 'package:hotel/src/features/hotel_summary/domain/usecases/get_daily_summaries_use_case.dart'
    as _i691;
import 'package:hotel/src/features/hotel_summary/domain/usecases/update_daily_summary_use_case.dart'
    as _i1070;
import 'package:hotel/src/features/hotel_summary/presentation/cubit/daily_cash_summary_cubit.dart'
    as _i364;
import 'package:hotel/src/features/invoice/data/datasources/accounting_settings_local_data_source.dart'
    as _i498;
import 'package:hotel/src/features/invoice/data/datasources/accounting_settings_remote_data_source.dart'
    as _i262;
import 'package:hotel/src/features/invoice/data/datasources/invoice_local_data_source.dart'
    as _i384;
import 'package:hotel/src/features/invoice/data/datasources/invoice_remote_data_source.dart'
    as _i845;
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_local_data_source.dart'
    as _i575;
import 'package:hotel/src/features/invoice/data/datasources/invoice_return_remote_data_source.dart'
    as _i520;
import 'package:hotel/src/features/invoice/data/repositories/invoice_repository_impl.dart'
    as _i890;
import 'package:hotel/src/features/invoice/domain/repositories/invoice_repository.dart'
    as _i389;
import 'package:hotel/src/features/invoice/domain/usecases/create_invoice_use_case.dart'
    as _i1064;
import 'package:hotel/src/features/invoice/domain/usecases/delete_invoice_use_case.dart'
    as _i503;
import 'package:hotel/src/features/invoice/domain/usecases/invoice_dates_use_case.dart'
    as _i1045;
import 'package:hotel/src/features/invoice/domain/usecases/invoice_use_case.dart'
    as _i545;
import 'package:hotel/src/features/invoice/domain/usecases/submit_invoice_use_case.dart'
    as _i208;
import 'package:hotel/src/features/invoice/domain/usecases/update_invoice_use_case.dart'
    as _i97;
import 'package:hotel/src/features/invoice/presentation/bloc/filter/filter_cubit.dart'
    as _i198;
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_cubit.dart'
    as _i748;
import 'package:hotel/src/features/invoice/presentation/bloc/login/invoice_purchase_cubit.dart'
    as _i196;
import 'package:hotel/src/features/invoice/presentation/cubit/accounting_settings_cubit.dart'
    as _i532;
import 'package:hotel/src/features/invoice/presentation/cubit/invoice_return_cubit.dart'
    as _i805;
import 'package:hotel/src/features/invoice/presentation/cubits/create_invoice/create_invoice_cubit.dart'
    as _i223;
import 'package:hotel/src/features/invoice/presentation/cubits/delete_invoice/delete_invoice_cubit.dart'
    as _i85;
import 'package:hotel/src/features/invoice/presentation/cubits/invoice_dates/invoice_dates_cubit.dart'
    as _i654;
import 'package:hotel/src/features/invoice/presentation/cubits/submit_invoice/submit_invoice_cubit.dart'
    as _i1061;
import 'package:hotel/src/features/invoice/presentation/cubits/update_invoice/update_invoice_cubit.dart'
    as _i274;
import 'package:hotel/src/features/liquor/data/datasources/liquor_local_data_source.dart'
    as _i590;
import 'package:hotel/src/features/liquor/data/datasources/liquor_remote_data_source.dart'
    as _i917;
import 'package:hotel/src/features/liquor/data/repositories/liquor_repository_impl.dart'
    as _i599;
import 'package:hotel/src/features/liquor/domain/repositories/liquor_repository.dart'
    as _i254;
import 'package:hotel/src/features/liquor/domain/usecases/create_liquor_use_case.dart'
    as _i361;
import 'package:hotel/src/features/liquor/domain/usecases/delete_liquor_use_case.dart'
    as _i1014;
import 'package:hotel/src/features/liquor/domain/usecases/liquor_use_case.dart'
    as _i877;
import 'package:hotel/src/features/liquor/domain/usecases/update_liquor_use_case.dart'
    as _i952;
import 'package:hotel/src/features/liquor/presentation/cubit/liquor_cubit.dart'
    as _i262;
import 'package:hotel/src/features/login/data/datasources/login_local_data_source.dart'
    as _i934;
import 'package:hotel/src/features/login/data/datasources/login_remote_data_source.dart'
    as _i713;
import 'package:hotel/src/features/login/data/repositories/login_repository_impl.dart'
    as _i148;
import 'package:hotel/src/features/login/domain/repositories/login_repository.dart'
    as _i642;
import 'package:hotel/src/features/login/domain/usecases/login_use_case.dart'
    as _i772;
import 'package:hotel/src/features/login/presentation/bloc/login_cubit.dart'
    as _i1066;
import 'package:hotel/src/features/loyalty/domain/loyalty_program_service.dart'
    as _i511;
import 'package:hotel/src/features/opening/data/datasources/opening_remote_data_source.dart'
    as _i859;
import 'package:hotel/src/features/order/data/datasources/order_remote_data_source.dart'
    as _i1036;
import 'package:hotel/src/features/order/data/repositories/order_repository_impl.dart'
    as _i133;
import 'package:hotel/src/features/order/domain/repositories/order_repository.dart'
    as _i44;
import 'package:hotel/src/features/order/domain/usecases/checkout_order_use_case.dart'
    as _i870;
import 'package:hotel/src/features/order/domain/usecases/create_order_use_case.dart'
    as _i1021;
import 'package:hotel/src/features/order/domain/usecases/get_order_activity_use_case.dart'
    as _i860;
import 'package:hotel/src/features/order/domain/usecases/get_order_detail_use_case.dart'
    as _i186;
import 'package:hotel/src/features/order/domain/usecases/get_orders_use_case.dart'
    as _i6;
import 'package:hotel/src/features/order/domain/usecases/update_order_item_status_use_case.dart'
    as _i346;
import 'package:hotel/src/features/order/domain/usecases/update_order_item_use_case.dart'
    as _i721;
import 'package:hotel/src/features/order/domain/usecases/update_order_status_use_case.dart'
    as _i524;
import 'package:hotel/src/features/order/domain/usecases/update_qot_status_use_case.dart'
    as _i169;
import 'package:hotel/src/features/order/domain/usecases/update_qot_use_case.dart'
    as _i522;
import 'package:hotel/src/features/order/presentation/cubit/order_cubit.dart'
    as _i381;
import 'package:hotel/src/features/order/presentation/cubit/order_detail_cubit.dart'
    as _i279;
import 'package:hotel/src/features/org/data/datasources/org_local_data_source.dart'
    as _i541;
import 'package:hotel/src/features/org/data/datasources/org_remote_data_source.dart'
    as _i1066;
import 'package:hotel/src/features/org/domain/accounting_settings_service.dart'
    as _i705;
import 'package:hotel/src/features/org/domain/system_settings_service.dart'
    as _i263;
import 'package:hotel/src/features/org/domain/tax_settings_service.dart'
    as _i224;
import 'package:hotel/src/features/org/presentation/cubit/org_lookup_cubit.dart'
    as _i1069;
import 'package:hotel/src/features/other/data/datasources/other_local_data_source.dart'
    as _i167;
import 'package:hotel/src/features/other/data/datasources/other_remote_data_source.dart'
    as _i778;
import 'package:hotel/src/features/other/data/repositories/other_repository_impl.dart'
    as _i429;
import 'package:hotel/src/features/other/domain/repositories/other_repository.dart'
    as _i114;
import 'package:hotel/src/features/other/domain/usecases/item_counter_use_case.dart'
    as _i88;
import 'package:hotel/src/features/other/presentation/bloc/item_counter_cubit.dart'
    as _i617;
import 'package:hotel/src/features/party/data/datasources/party_local_data_source.dart'
    as _i709;
import 'package:hotel/src/features/party/data/datasources/party_remote_data_source.dart'
    as _i833;
import 'package:hotel/src/features/party/data/repositories/party_repository_impl.dart'
    as _i121;
import 'package:hotel/src/features/party/domain/repositories/party_repository.dart'
    as _i492;
import 'package:hotel/src/features/party/domain/usecases/party_use_cases.dart'
    as _i220;
import 'package:hotel/src/features/party/presentation/bloc/party_cubit.dart'
    as _i914;
import 'package:hotel/src/features/payment_methods/data/datasources/payment_methods_local_data_source.dart'
    as _i990;
import 'package:hotel/src/features/payment_methods/data/datasources/payment_methods_remote_data_source.dart'
    as _i416;
import 'package:hotel/src/features/payment_methods/data/repositories/payment_methods_repository_impl.dart'
    as _i787;
import 'package:hotel/src/features/payment_methods/domain/repositories/payment_methods_repository.dart'
    as _i231;
import 'package:hotel/src/features/payment_methods/domain/usecases/get_payment_methods_use_case.dart'
    as _i832;
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_method_manage_cubit.dart'
    as _i382;
import 'package:hotel/src/features/payment_methods/presentation/cubit/payment_methods_cubit.dart'
    as _i541;
import 'package:hotel/src/features/payroll/data/datasources/payroll_remote_data_source.dart'
    as _i920;
import 'package:hotel/src/features/payroll/data/repositories/payroll_repository_impl.dart'
    as _i578;
import 'package:hotel/src/features/payroll/domain/repositories/payroll_repository.dart'
    as _i511;
import 'package:hotel/src/features/payroll/domain/usecases/payroll_use_cases.dart'
    as _i311;
import 'package:hotel/src/features/payroll/presentation/cubit/payroll_cubit.dart'
    as _i464;
import 'package:hotel/src/features/permission/data/datasources/user_permissions_local_data_source.dart'
    as _i770;
import 'package:hotel/src/features/permission/data/datasources/user_permissions_remote_data_source.dart'
    as _i470;
import 'package:hotel/src/features/permission/data/repositories/user_permissions_repository_impl.dart'
    as _i149;
import 'package:hotel/src/features/permission/domain/repositories/user_permissions_repository.dart'
    as _i569;
import 'package:hotel/src/features/permission/domain/usecases/user_permissions_use_case.dart'
    as _i862;
import 'package:hotel/src/features/permission/presentation/cubit/user_permissions_cubit.dart'
    as _i996;
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_delete_remote_data_source.dart'
    as _i98;
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_details_remote_data_source.dart'
    as _i798;
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_edit_remote_data_source.dart'
    as _i654;
import 'package:hotel/src/features/reconciliation/data/datasources/previous_stock_local_data_source.dart'
    as _i174;
import 'package:hotel/src/features/reconciliation/data/datasources/reconciliation_remote_datasource.dart'
    as _i666;
import 'package:hotel/src/features/reconciliation/data/repositories/previous_stock_delete_repository_impl.dart'
    as _i755;
import 'package:hotel/src/features/reconciliation/data/repositories/previous_stock_details_repository_impl.dart'
    as _i1017;
import 'package:hotel/src/features/reconciliation/data/repositories/previous_stock_edit_repository_impl.dart'
    as _i907;
import 'package:hotel/src/features/reconciliation/data/repositories/reconciliation_repository_impl.dart'
    as _i1033;
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_delete_repository.dart'
    as _i533;
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_details_repository.dart'
    as _i982;
import 'package:hotel/src/features/reconciliation/domain/repositories/previous_stock_edit_repository.dart'
    as _i1057;
import 'package:hotel/src/features/reconciliation/domain/repositories/reconciliation_repository.dart'
    as _i904;
import 'package:hotel/src/features/reconciliation/domain/usecases/generate_reconciliation_direct_report_use_case.dart'
    as _i883;
import 'package:hotel/src/features/reconciliation/domain/usecases/generate_reconciliation_report_use_case.dart'
    as _i650;
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_delete_use_case.dart'
    as _i103;
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_details_use_case.dart'
    as _i892;
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_edit_use_case.dart'
    as _i356;
import 'package:hotel/src/features/reconciliation/domain/usecases/previous_stock_use_case.dart'
    as _i101;
import 'package:hotel/src/features/reconciliation/domain/usecases/upload_reconciliation_usecase.dart'
    as _i567;
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_cubit.dart'
    as _i67;
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_delete_cubit.dart'
    as _i995;
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_details_cubit.dart'
    as _i169;
import 'package:hotel/src/features/reconciliation/presentation/bloc/previous_stock_edit_cubit.dart'
    as _i998;
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_direct_report_cubit.dart'
    as _i671;
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_report_cubit.dart'
    as _i358;
import 'package:hotel/src/features/reconciliation/presentation/bloc/reconciliation_upload_cubit.dart'
    as _i830;
import 'package:hotel/src/features/reports/data/datasources/reports_local_data_source.dart'
    as _i702;
import 'package:hotel/src/features/reports/data/datasources/reports_remote_data_source.dart'
    as _i911;
import 'package:hotel/src/features/reports/data/repositories/reports_repository_impl.dart'
    as _i426;
import 'package:hotel/src/features/reports/domain/repositories/reports_repository.dart'
    as _i789;
import 'package:hotel/src/features/reports/domain/usecases/get_analytics_report_use_case.dart'
    as _i240;
import 'package:hotel/src/features/reports/domain/usecases/get_profit_loss_report_use_case.dart'
    as _i125;
import 'package:hotel/src/features/reports/domain/usecases/get_statement_report_use_case.dart'
    as _i1019;
import 'package:hotel/src/features/reports/presentation/bloc/analytics_report/analytics_report_cubit.dart'
    as _i736;
import 'package:hotel/src/features/reports/presentation/bloc/profit_loss_report/profit_loss_report_cubit.dart'
    as _i711;
import 'package:hotel/src/features/reports/presentation/bloc/statement_report/statement_report_cubit.dart'
    as _i712;
import 'package:hotel/src/features/role/data/datasources/roles_local_data_source.dart'
    as _i569;
import 'package:hotel/src/features/role/data/datasources/roles_remote_data_source.dart'
    as _i859;
import 'package:hotel/src/features/role/data/repositories/roles_repository_impl.dart'
    as _i1007;
import 'package:hotel/src/features/role/domain/repositories/roles_repository.dart'
    as _i551;
import 'package:hotel/src/features/role/presentation/cubit/role_manage_cubit.dart'
    as _i198;
import 'package:hotel/src/features/settlement/data/datasources/partial_settlement_local_data_source.dart'
    as _i512;
import 'package:hotel/src/features/settlement/data/datasources/partial_settlement_remote_data_source.dart'
    as _i693;
import 'package:hotel/src/features/settlement/data/datasources/settlement_local_data_source.dart'
    as _i917;
import 'package:hotel/src/features/settlement/data/datasources/settlement_remote_data_source.dart'
    as _i632;
import 'package:hotel/src/features/settlement/data/repositories/partial_settlement_repository_impl.dart'
    as _i493;
import 'package:hotel/src/features/settlement/data/repositories/settlement_repository_impl.dart'
    as _i647;
import 'package:hotel/src/features/settlement/domain/repositories/partial_settlement_repository.dart'
    as _i884;
import 'package:hotel/src/features/settlement/domain/repositories/settlement_repository.dart'
    as _i591;
import 'package:hotel/src/features/settlement/domain/usecases/partial_settlement_use_case.dart'
    as _i422;
import 'package:hotel/src/features/settlement/domain/usecases/settlement_use_case.dart'
    as _i901;
import 'package:hotel/src/features/settlement/presentation/bloc/partial_settlement_cubit.dart'
    as _i463;
import 'package:hotel/src/features/settlement/presentation/cubit/settlement_cubit.dart'
    as _i1073;
import 'package:hotel/src/features/setup/domain/local_setup_service.dart'
    as _i284;
import 'package:hotel/src/features/stock_adjustment/data/datasources/stock_adjustment_local_data_source.dart'
    as _i353;
import 'package:hotel/src/features/stock_adjustment/data/datasources/stock_adjustment_remote_data_source.dart'
    as _i205;
import 'package:hotel/src/features/stock_adjustment/data/repositories/stock_adjustment_repository_impl.dart'
    as _i499;
import 'package:hotel/src/features/stock_adjustment/domain/repositories/stock_adjustment_repository.dart'
    as _i204;
import 'package:hotel/src/features/stock_adjustment/domain/usecases/create_stock_adjustment_use_case.dart'
    as _i157;
import 'package:hotel/src/features/stock_adjustment/domain/usecases/get_stock_adjustments_use_case.dart'
    as _i1065;
import 'package:hotel/src/features/stock_adjustment/presentation/bloc/stock_adjustment_cubit.dart'
    as _i516;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i198.FilterCubit>(() => _i198.FilterCubit());
    gh.lazySingleton<_i118.AppLocaleService>(() => _i118.AppLocaleService());
    gh.lazySingleton<_i648.AppRouter>(() => registerModule.router);
    gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
    gh.lazySingleton<_i91.AppThemeModeService>(
        () => _i91.AppThemeModeService());
    gh.lazySingleton<_i348.ForceUpdateService>(
        () => _i348.ForceUpdateService());
    gh.lazySingleton<_i121.LocalDb>(() => _i121.LocalDb());
    gh.lazySingleton<_i520.GoogleDriveAuthService>(
        () => _i520.GoogleDriveAuthService());
    gh.lazySingleton<_i778.OtherRemoteDataSource>(
        () => _i167.OtherLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i595.ContactRemoteDataSource>(
        () => _i430.ContactLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i356.PartyRemoteDataSource>(
        () => _i111.PartyLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i693.PartialSettlementRemoteDataSource>(
        () => _i512.PartialSettlementLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i36.InternetInfo>(
        () => _i36.InternetInfoImpl(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i81.ExpenseRemoteDataSource>(
        () => _i815.ExpenseLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i833.PartyRemoteDataSource>(
        () => _i709.PartyLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i262.AccountingSettingsRemoteDataSource>(
        () => _i498.AccountingSettingsLocalDataSource(db: gh<_i121.LocalDb>()));
    gh.lazySingleton<_i859.RolesRemoteDataSource>(
        () => _i569.RolesLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i859.OpeningRemoteDataSource>(
        () => _i859.OpeningLocalDataSourceImpl(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i654.PreviousStockEditRemoteDataSource>(
        () => _i174.PreviousStockEditLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i875.ItemRemoteDataSource>(
        () => _i504.ItemLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i205.StockAdjustmentRemoteDataSource>(
        () => _i353.StockAdjustmentLocalDataSource());
    gh.lazySingleton<_i423.EmployeeRemoteDataSource>(
        () => _i484.EmployeeLocalDataSource());
    gh.lazySingleton<_i1030.EmployeeManagementRemoteDataSource>(
        () => _i58.EmployeeManagementLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i511.PayrollRepository>(
        () => _i578.PayrollRepositoryImpl(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i492.PartyRepository>(
        () => _i121.PartyRepositoryImpl(gh<_i833.PartyRemoteDataSource>()));
    gh.lazySingleton<_i196.ExpenseRepository>(
        () => _i348.ExpenseRepositoryImpl(gh<_i81.ExpenseRemoteDataSource>()));
    gh.lazySingleton<_i917.LiquorRemoteDataSource>(
        () => _i590.LiquorLocalDataSourceImpl(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i1045.DashboardSummaryPageRemoteDataSource>(
        () => _i980.DashboardSummaryPageLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i520.InvoiceReturnRemoteDataSource>(
        () => _i575.InvoiceReturnLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i987.PaymentAnalyticsRemoteDataSource>(
        () => _i336.PaymentAnalyticsLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i1057.PreviousStockEditRepository>(() =>
        _i907.PreviousStockEditRepositoryImpl(
            gh<_i654.PreviousStockEditRemoteDataSource>()));
    gh.lazySingleton<_i845.InvoiceRemoteDataSource>(
        () => _i384.InvoiceLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i435.AppCurrencyService>(
        () => _i435.AppCurrencyService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i541.OrgLocalDataSource>(
        () => _i541.OrgLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i263.SystemSettingsService>(
        () => _i263.SystemSettingsService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i224.TaxSettingsService>(
        () => _i224.TaxSettingsService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i705.AccountingSettingsService>(
        () => _i705.AccountingSettingsService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i284.LocalSetupService>(
        () => _i284.LocalSetupService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i79.BooksDataExporter>(
        () => _i79.BooksDataExporter(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i149.BooksDeltaImporter>(
        () => _i149.BooksDeltaImporter(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i531.BooksDataImporter>(
        () => _i531.BooksDataImporter(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i511.LoyaltyProgramService>(
        () => _i511.LoyaltyProgramService(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i628.ClientToServerRemoteDataSource>(
        () => _i1037.ClientToServerLocalDataSource());
    gh.lazySingleton<_i416.PaymentMethodsRemoteDataSource>(
        () => _i990.PaymentMethodsLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i470.UserPermissionsRemoteDataSource>(
        () => _i770.UserPermissionsLocalDataSource());
    gh.lazySingleton<_i1007.GoogleDriveApiClient>(
        () => _i1007.GoogleDriveApiClient(gh<_i520.GoogleDriveAuthService>()));
    gh.lazySingleton<_i632.SettlementRemoteDataSource>(
        () => _i917.SettlementLocalDataSource());
    gh.lazySingleton<_i604.GoogleDriveRestoreService>(
        () => _i604.GoogleDriveRestoreService(
              gh<_i520.GoogleDriveAuthService>(),
              gh<_i1007.GoogleDriveApiClient>(),
              gh<_i531.BooksDataImporter>(),
              gh<_i121.LocalDb>(),
            ));
    gh.lazySingleton<_i98.PreviousStockDeleteRemoteDataSource>(
        () => _i174.PreviousStockDeleteLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i666.ReconciliationRemoteDataSource>(
        () => _i666.ReconciliationLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i460.ServerToClientRemoteDataSource>(
        () => _i601.ServerToClientLocalDataSource());
    gh.lazySingleton<_i114.OtherRepository>(
        () => _i429.OtherRepositoryImpl(gh<_i778.OtherRemoteDataSource>()));
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.authenticatedDio,
      instanceName: 'authenticated',
    );
    gh.lazySingleton<_i798.PreviousStockDetailsRemoteDataSource>(
        () => _i174.PreviousStockDetailsLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i927.HotelSummaryRemoteDataSource>(
        () => _i927.HotelSummaryLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i358.DailyCashSummaryRemoteDataSource>(
        () => _i831.DailyCashSummaryLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i591.SettlementRepository>(() =>
        _i647.SettlementRepositoryImpl(gh<_i632.SettlementRemoteDataSource>()));
    gh.lazySingleton<_i911.ReportsRemoteDataSource>(
        () => _i702.ReportsLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i88.ItemCounterUseCase>(
        () => _i88.ItemCounterUseCase(gh<_i114.OtherRepository>()));
    gh.lazySingleton<_i884.PartialSettlementRepository>(() =>
        _i493.PartialSettlementRepositoryImpl(
            gh<_i693.PartialSettlementRemoteDataSource>()));
    gh.lazySingleton<_i557.PaymentRemoteDataSource>(
        () => _i486.PaymentLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i713.LoginRemoteDataSource>(
        () => _i934.LoginLocalDataSourceImpl(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i144.CategoryRemoteDataSource>(
        () => _i750.CategoryLocalDataSource(gh<_i121.LocalDb>()));
    gh.lazySingleton<_i50.DailyCashSummaryRepository>(() =>
        _i700.DailyCashSummaryRepositoryImpl(
            gh<_i358.DailyCashSummaryRemoteDataSource>()));
    gh.lazySingleton<_i254.LiquorRepository>(() => _i599.LiquorRepositoryImpl(
          gh<_i917.LiquorRemoteDataSource>(),
          gh<_i36.InternetInfo>(),
        ));
    gh.lazySingleton<_i789.ReportsRepository>(
        () => _i426.ReportsRepositoryImpl(gh<_i911.ReportsRemoteDataSource>()));
    gh.lazySingleton<_i336.CreateExpenseUseCase>(
        () => _i336.CreateExpenseUseCase(gh<_i196.ExpenseRepository>()));
    gh.lazySingleton<_i642.LoginRepository>(() => _i148.LoginRepositoryImpl(
          gh<_i713.LoginRemoteDataSource>(),
          gh<_i36.InternetInfo>(),
        ));
    gh.lazySingleton<_i151.PaymentAnalyticsRepository>(() =>
        _i1017.PaymentAnalyticsRepositoryImpl(
            gh<_i987.PaymentAnalyticsRemoteDataSource>()));
    gh.factory<_i532.AccountingSettingsCubit>(() =>
        _i532.AccountingSettingsCubit(
            gh<_i262.AccountingSettingsRemoteDataSource>()));
    gh.lazySingleton<_i326.PaymentAnalyticsUseCase>(() =>
        _i326.PaymentAnalyticsUseCase(gh<_i151.PaymentAnalyticsRepository>()));
    gh.lazySingleton<_i489.PartyRepository>(
        () => _i161.PartyRepositoryImpl(gh<_i356.PartyRemoteDataSource>()));
    gh.lazySingleton<_i204.StockAdjustmentRepository>(() =>
        _i499.StockAdjustmentRepositoryImpl(
            gh<_i205.StockAdjustmentRemoteDataSource>()));
    gh.lazySingleton<_i1070.UpdateDailySummaryUseCase>(() =>
        _i1070.UpdateDailySummaryUseCase(
            gh<_i50.DailyCashSummaryRepository>()));
    gh.lazySingleton<_i675.CreateDailySummaryUseCase>(() =>
        _i675.CreateDailySummaryUseCase(gh<_i50.DailyCashSummaryRepository>()));
    gh.lazySingleton<_i691.GetDailySummariesUseCase>(() =>
        _i691.GetDailySummariesUseCase(gh<_i50.DailyCashSummaryRepository>()));
    gh.lazySingleton<_i437.DeleteDailySummaryUseCase>(() =>
        _i437.DeleteDailySummaryUseCase(gh<_i50.DailyCashSummaryRepository>()));
    gh.lazySingleton<_i1036.OrderRemoteDataSource>(() =>
        _i1036.OrderRemoteDataSourceImpl(
            gh<_i361.Dio>(instanceName: 'authenticated')));
    gh.factory<_i624.CreateExpenseCubit>(
        () => _i624.CreateExpenseCubit(gh<_i336.CreateExpenseUseCase>()));
    gh.lazySingleton<_i173.ContactRepository>(
        () => _i812.ContactRepositoryImpl(gh<_i595.ContactRemoteDataSource>()));
    gh.lazySingleton<_i178.CategoryRepository>(() =>
        _i984.CategoryRepositoryImpl(gh<_i144.CategoryRemoteDataSource>()));
    gh.lazySingleton<_i311.GeneratePayrollUseCase>(
        () => _i311.GeneratePayrollUseCase(gh<_i511.PayrollRepository>()));
    gh.lazySingleton<_i311.GetPayrollsUseCase>(
        () => _i311.GetPayrollsUseCase(gh<_i511.PayrollRepository>()));
    gh.lazySingleton<_i311.UpdatePaymentStatusUseCase>(
        () => _i311.UpdatePaymentStatusUseCase(gh<_i511.PayrollRepository>()));
    gh.lazySingleton<_i311.DeletePayrollUseCase>(
        () => _i311.DeletePayrollUseCase(gh<_i511.PayrollRepository>()));
    gh.lazySingleton<_i920.PayrollRemoteDataSource>(() =>
        _i920.PayrollRemoteDataSourceImpl(
            gh<_i361.Dio>(instanceName: 'authenticated')));
    gh.lazySingleton<_i884.BooksDeltaExporter>(() => _i884.BooksDeltaExporter(
          gh<_i121.LocalDb>(),
          gh<_i79.BooksDataExporter>(),
        ));
    gh.lazySingleton<_i1027.FileCreationRemoteDataSource>(() =>
        _i1027.FileCreationRemoteDataSourceImpl(
            gh<_i361.Dio>(instanceName: 'authenticated')));
    gh.lazySingleton<_i1007.ItemRepository>(
        () => _i517.ItemRepositoryImpl(gh<_i875.ItemRemoteDataSource>()));
    gh.lazySingleton<_i175.PaymentRepository>(
        () => _i978.PaymentRepositoryImpl(gh<_i557.PaymentRemoteDataSource>()));
    gh.lazySingleton<_i168.DashboardSummaryPageRepository>(() =>
        _i1044.DashboardSummaryPageRepositoryImpl(
            gh<_i1045.DashboardSummaryPageRemoteDataSource>()));
    gh.lazySingleton<_i896.UpdatePaymentUseCase>(
        () => _i896.UpdatePaymentUseCase(gh<_i175.PaymentRepository>()));
    gh.lazySingleton<_i389.InvoiceRepository>(
        () => _i890.InvoiceRepositoryImp(gh<_i845.InvoiceRemoteDataSource>()));
    gh.lazySingleton<_i220.GetPartyListUseCase>(
        () => _i220.GetPartyListUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i220.GetPartyDetailUseCase>(
        () => _i220.GetPartyDetailUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i220.CreatePartyUseCase>(
        () => _i220.CreatePartyUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i220.UpdatePartyUseCase>(
        () => _i220.UpdatePartyUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i220.DeletePartyUseCase>(
        () => _i220.DeletePartyUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i220.ReconcilePartyUseCase>(
        () => _i220.ReconcilePartyUseCase(gh<_i492.PartyRepository>()));
    gh.lazySingleton<_i125.GetProfitLossReportUseCase>(
        () => _i125.GetProfitLossReportUseCase(gh<_i789.ReportsRepository>()));
    gh.lazySingleton<_i240.GetAnalyticsReportUseCase>(
        () => _i240.GetAnalyticsReportUseCase(gh<_i789.ReportsRepository>()));
    gh.lazySingleton<_i1019.GetStatementReportUseCase>(
        () => _i1019.GetStatementReportUseCase(gh<_i789.ReportsRepository>()));
    gh.lazySingleton<_i551.RolesRepository>(
        () => _i1007.RolesRepositoryImpl(gh<_i859.RolesRemoteDataSource>()));
    gh.lazySingleton<_i904.ReconciliationRepository>(
        () => _i1033.ReconciliationRepositoryImpl(
              gh<_i666.ReconciliationRemoteDataSource>(),
              gh<_i36.InternetInfo>(),
            ));
    gh.lazySingleton<_i44.OrderRepository>(() => _i133.OrderRepositoryImpl(
          gh<_i1036.OrderRemoteDataSource>(),
          gh<_i36.InternetInfo>(),
        ));
    gh.lazySingleton<_i631.ClientToServerRepository>(() =>
        _i47.ClientToServerRepositoryImpl(
            gh<_i628.ClientToServerRemoteDataSource>()));
    gh.lazySingleton<_i982.PreviousStockDetailsRepository>(() =>
        _i1017.PreviousStockDetailsRepositoryImpl(
            gh<_i798.PreviousStockDetailsRemoteDataSource>()));
    gh.lazySingleton<_i569.UserPermissionsRepository>(() =>
        _i149.UserPermissionsRepositoryImpl(
            gh<_i470.UserPermissionsRemoteDataSource>()));
    gh.lazySingleton<_i44.EmployeeRepository>(() =>
        _i1065.EmployeeRepositoryImpl(gh<_i423.EmployeeRemoteDataSource>()));
    gh.lazySingleton<_i991.EmployeeManagementRepository>(() =>
        _i1040.EmployeeManagementRepositoryImpl(
            gh<_i1030.EmployeeManagementRemoteDataSource>()));
    gh.lazySingleton<_i772.LoginUseCase>(
        () => _i772.LoginUseCase(gh<_i642.LoginRepository>()));
    gh.lazySingleton<_i932.ServerToClientRepository>(() =>
        _i297.ServerToClientRepositoryImpl(
            gh<_i460.ServerToClientRemoteDataSource>()));
    gh.lazySingleton<_i116.EmployeeOutstandingUseCase>(
        () => _i116.EmployeeOutstandingUseCase(gh<_i44.EmployeeRepository>()));
    gh.lazySingleton<_i881.EmployeeAdvanceUseCase>(
        () => _i881.EmployeeAdvanceUseCase(gh<_i44.EmployeeRepository>()));
    gh.lazySingleton<_i90.HotelSummaryRepository>(
        () => _i587.HotelSummaryRepositoryImpl(
              gh<_i927.HotelSummaryRemoteDataSource>(),
              gh<_i36.InternetInfo>(),
            ));
    gh.factory<_i736.AnalyticsReportCubit>(() =>
        _i736.AnalyticsReportCubit(gh<_i240.GetAnalyticsReportUseCase>()));
    gh.factory<_i805.InvoiceReturnCubit>(() =>
        _i805.InvoiceReturnCubit(gh<_i520.InvoiceReturnRemoteDataSource>()));
    gh.lazySingleton<_i901.SettlementUseCase>(
        () => _i901.SettlementUseCase(gh<_i591.SettlementRepository>()));
    gh.lazySingleton<_i356.PreviousStockEditUseCase>(() =>
        _i356.PreviousStockEditUseCase(
            gh<_i1057.PreviousStockEditRepository>()));
    gh.factory<_i998.PreviousStockEditCubit>(() =>
        _i998.PreviousStockEditCubit(gh<_i356.PreviousStockEditUseCase>()));
    gh.lazySingleton<_i533.PreviousStockDeleteRepository>(() =>
        _i755.PreviousStockDeleteRepositoryImpl(
            gh<_i98.PreviousStockDeleteRemoteDataSource>()));
    gh.factory<_i557.EmployeeAdvanceCubit>(
        () => _i557.EmployeeAdvanceCubit(gh<_i881.EmployeeAdvanceUseCase>()));
    gh.factory<_i364.DailyCashSummaryCubit>(() => _i364.DailyCashSummaryCubit(
          gh<_i675.CreateDailySummaryUseCase>(),
          gh<_i691.GetDailySummariesUseCase>(),
          gh<_i1070.UpdateDailySummaryUseCase>(),
          gh<_i437.DeleteDailySummaryUseCase>(),
        ));
    gh.lazySingleton<_i1014.DeleteLiquorUseCase>(
        () => _i1014.DeleteLiquorUseCase(gh<_i254.LiquorRepository>()));
    gh.lazySingleton<_i877.LiquorUseCase>(
        () => _i877.LiquorUseCase(gh<_i254.LiquorRepository>()));
    gh.lazySingleton<_i361.CreateLiquorUseCase>(
        () => _i361.CreateLiquorUseCase(gh<_i254.LiquorRepository>()));
    gh.lazySingleton<_i952.UpdateLiquorUseCase>(
        () => _i952.UpdateLiquorUseCase(gh<_i254.LiquorRepository>()));
    gh.lazySingleton<_i1066.OrgRemoteDataSource>(() =>
        _i1066.OrgRemoteDataSource(
            gh<_i361.Dio>(instanceName: 'authenticated')));
    gh.lazySingleton<_i422.PartialSettlementUseCase>(() =>
        _i422.PartialSettlementUseCase(
            gh<_i884.PartialSettlementRepository>()));
    gh.factory<_i711.ProfitLossReportCubit>(() =>
        _i711.ProfitLossReportCubit(gh<_i125.GetProfitLossReportUseCase>()));
    gh.lazySingleton<_i231.PaymentMethodsRepository>(() =>
        _i787.PaymentMethodsRepositoryImpl(
            gh<_i416.PaymentMethodsRemoteDataSource>()));
    gh.lazySingleton<_i864.AppDisplayPrecisionService>(() =>
        _i864.AppDisplayPrecisionService(gh<_i263.SystemSettingsService>()));
    gh.lazySingleton<_i103.PreviousStockDeleteUseCase>(() =>
        _i103.PreviousStockDeleteUseCase(
            gh<_i533.PreviousStockDeleteRepository>()));
    gh.lazySingleton<_i1045.InvoiceDatesUseCase>(
        () => _i1045.InvoiceDatesUseCase(gh<_i389.InvoiceRepository>()));
    gh.lazySingleton<_i503.DeleteInvoiceUseCase>(
        () => _i503.DeleteInvoiceUseCase(gh<_i389.InvoiceRepository>()));
    gh.lazySingleton<_i545.InvoiceUseCase>(
        () => _i545.InvoiceUseCase(gh<_i389.InvoiceRepository>()));
    gh.lazySingleton<_i97.UpdateInvoiceUseCase>(
        () => _i97.UpdateInvoiceUseCase(gh<_i389.InvoiceRepository>()));
    gh.lazySingleton<_i208.SubmitInvoiceUseCase>(
        () => _i208.SubmitInvoiceUseCase(gh<_i389.InvoiceRepository>()));
    gh.lazySingleton<_i1064.CreateInvoiceUseCase>(
        () => _i1064.CreateInvoiceUseCase(gh<_i389.InvoiceRepository>()));
    gh.factory<_i1069.OrgLookupCubit>(() => _i1069.OrgLookupCubit(
          gh<_i1066.OrgRemoteDataSource>(),
          gh<_i541.OrgLocalDataSource>(),
        ));
    gh.factory<_i1061.SubmitInvoiceCubit>(
        () => _i1061.SubmitInvoiceCubit(gh<_i208.SubmitInvoiceUseCase>()));
    gh.lazySingleton<_i932.ServerToClientUseCase>(() =>
        _i932.ServerToClientUseCase(gh<_i932.ServerToClientRepository>()));
    gh.factory<_i617.ItemCounterCubit>(
        () => _i617.ItemCounterCubit(gh<_i88.ItemCounterUseCase>()));
    gh.factory<_i662.CategoryCubit>(
        () => _i662.CategoryCubit(gh<_i178.CategoryRepository>()));
    gh.factory<_i62.PaymentAnalyticsCubit>(
        () => _i62.PaymentAnalyticsCubit(gh<_i326.PaymentAnalyticsUseCase>()));
    gh.lazySingleton<_i501.FileCreationRepository>(
        () => _i215.FileCreationRepositoryImpl(
              gh<_i1027.FileCreationRemoteDataSource>(),
              gh<_i36.InternetInfo>(),
            ));
    gh.lazySingleton<_i157.CreateStockAdjustmentUseCase>(() =>
        _i157.CreateStockAdjustmentUseCase(
            gh<_i204.StockAdjustmentRepository>()));
    gh.lazySingleton<_i1065.GetStockAdjustmentsUseCase>(() =>
        _i1065.GetStockAdjustmentsUseCase(
            gh<_i204.StockAdjustmentRepository>()));
    gh.lazySingleton<_i925.ApproveRejectLeaveUseCase>(() =>
        _i925.ApproveRejectLeaveUseCase(
            gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i552.RecordAttendanceUseCase>(() =>
        _i552.RecordAttendanceUseCase(
            gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i791.GetLeaveBalanceUseCase>(() =>
        _i791.GetLeaveBalanceUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i1051.SubmitLeaveApplicationUseCase>(() =>
        _i1051.SubmitLeaveApplicationUseCase(
            gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i248.GetDashboardUseCase>(() =>
        _i248.GetDashboardUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i22.GetPayrollsUseCase>(() =>
        _i22.GetPayrollsUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i882.CreateEmployeeUseCase>(() =>
        _i882.CreateEmployeeUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i277.GetEmployeesUseCase>(() =>
        _i277.GetEmployeesUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i436.GeneratePayrollUseCase>(() =>
        _i436.GeneratePayrollUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i66.GetLeaveApplicationsUseCase>(() =>
        _i66.GetLeaveApplicationsUseCase(
            gh<_i991.EmployeeManagementRepository>()));
    gh.lazySingleton<_i120.GetAttendanceUseCase>(() =>
        _i120.GetAttendanceUseCase(gh<_i991.EmployeeManagementRepository>()));
    gh.factory<_i262.LiquorCubit>(() => _i262.LiquorCubit(
          gh<_i877.LiquorUseCase>(),
          gh<_i361.CreateLiquorUseCase>(),
          gh<_i952.UpdateLiquorUseCase>(),
          gh<_i1014.DeleteLiquorUseCase>(),
        ));
    gh.lazySingleton<_i545.GetItemsUseCase>(
        () => _i545.GetItemsUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.GetItemByIdUseCase>(
        () => _i545.GetItemByIdUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.CreateItemUseCase>(
        () => _i545.CreateItemUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.UpdateItemUseCase>(
        () => _i545.UpdateItemUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.DeleteItemUseCase>(
        () => _i545.DeleteItemUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.MergeItemsBulkOperationUseCase>(() =>
        _i545.MergeItemsBulkOperationUseCase(gh<_i1007.ItemRepository>()));
    gh.lazySingleton<_i545.BulkCreateItemsUseCase>(
        () => _i545.BulkCreateItemsUseCase(gh<_i1007.ItemRepository>()));
    gh.factory<_i516.StockAdjustmentCubit>(() => _i516.StockAdjustmentCubit(
          gh<_i157.CreateStockAdjustmentUseCase>(),
          gh<_i1065.GetStockAdjustmentsUseCase>(),
        ));
    gh.lazySingleton<_i889.DashboardSummaryPageUseCase>(() =>
        _i889.DashboardSummaryPageUseCase(
            gh<_i168.DashboardSummaryPageRepository>()));
    gh.lazySingleton<_i343.HotelSalesUseCase>(() =>
        _i343.HotelSalesUseCase(gh<_i168.DashboardSummaryPageRepository>()));
    gh.lazySingleton<_i892.PreviousStockDetailsUseCase>(() =>
        _i892.PreviousStockDetailsUseCase(
            gh<_i982.PreviousStockDetailsRepository>()));
    gh.lazySingleton<_i178.GetPartiesUseCase>(
        () => _i178.GetPartiesUseCase(gh<_i489.PartyRepository>()));
    gh.lazySingleton<_i178.GetPartyByIdUseCase>(
        () => _i178.GetPartyByIdUseCase(gh<_i489.PartyRepository>()));
    gh.lazySingleton<_i178.CreatePartyUseCase>(
        () => _i178.CreatePartyUseCase(gh<_i489.PartyRepository>()));
    gh.lazySingleton<_i178.UpdatePartyUseCase>(
        () => _i178.UpdatePartyUseCase(gh<_i489.PartyRepository>()));
    gh.lazySingleton<_i178.DeletePartyUseCase>(
        () => _i178.DeletePartyUseCase(gh<_i489.PartyRepository>()));
    gh.factory<_i662.HotelSalesCubit>(
        () => _i662.HotelSalesCubit(gh<_i343.HotelSalesUseCase>()));
    gh.factory<_i663.LeaveApplicationCubit>(() => _i663.LeaveApplicationCubit(
          gh<_i66.GetLeaveApplicationsUseCase>(),
          gh<_i1051.SubmitLeaveApplicationUseCase>(),
          gh<_i925.ApproveRejectLeaveUseCase>(),
          gh<_i791.GetLeaveBalanceUseCase>(),
          gh<_i991.EmployeeManagementRepository>(),
        ));
    gh.factory<_i654.InvoiceDatesCubit>(
        () => _i654.InvoiceDatesCubit(gh<_i1045.InvoiceDatesUseCase>()));
    gh.factory<_i570.DashboardCubit>(() => _i570.DashboardCubit(
          gh<_i248.GetDashboardUseCase>(),
          gh<_i991.EmployeeManagementRepository>(),
        ));
    gh.factory<_i382.PaymentMethodManageCubit>(() =>
        _i382.PaymentMethodManageCubit(gh<_i231.PaymentMethodsRepository>()));
    gh.lazySingleton<_i832.GetPaymentMethodsUseCase>(() =>
        _i832.GetPaymentMethodsUseCase(gh<_i231.PaymentMethodsRepository>()));
    gh.factory<_i914.PartyCubit>(() => _i914.PartyCubit(
          gh<_i220.GetPartyListUseCase>(),
          gh<_i220.GetPartyDetailUseCase>(),
          gh<_i220.CreatePartyUseCase>(),
          gh<_i220.UpdatePartyUseCase>(),
          gh<_i220.DeletePartyUseCase>(),
          gh<_i220.ReconcilePartyUseCase>(),
        ));
    gh.factory<_i463.PartialSettlementCubit>(() =>
        _i463.PartialSettlementCubit(gh<_i422.PartialSettlementUseCase>()));
    gh.factory<_i326.ItemCubit>(() => _i326.ItemCubit(
          gh<_i545.GetItemsUseCase>(),
          gh<_i545.GetItemByIdUseCase>(),
          gh<_i545.CreateItemUseCase>(),
          gh<_i545.UpdateItemUseCase>(),
          gh<_i545.DeleteItemUseCase>(),
          gh<_i545.MergeItemsBulkOperationUseCase>(),
          gh<_i545.BulkCreateItemsUseCase>(),
        ));
    gh.factory<_i38.EmployeeOutstandingCubit>(() =>
        _i38.EmployeeOutstandingCubit(gh<_i116.EmployeeOutstandingUseCase>()));
    gh.lazySingleton<_i807.CreateContactUseCase>(
        () => _i807.CreateContactUseCase(gh<_i173.ContactRepository>()));
    gh.lazySingleton<_i283.UpdateContactUseCase>(
        () => _i283.UpdateContactUseCase(gh<_i173.ContactRepository>()));
    gh.lazySingleton<_i763.DeleteContactUseCase>(
        () => _i763.DeleteContactUseCase(gh<_i173.ContactRepository>()));
    gh.lazySingleton<_i349.GetContactByIdUseCase>(
        () => _i349.GetContactByIdUseCase(gh<_i173.ContactRepository>()));
    gh.lazySingleton<_i1008.GetContactsUseCase>(
        () => _i1008.GetContactsUseCase(gh<_i173.ContactRepository>()));
    gh.factory<_i748.InvoiceCubit>(
        () => _i748.InvoiceCubit(gh<_i545.InvoiceUseCase>()));
    gh.factory<_i196.InvoicePurchaseCubit>(
        () => _i196.InvoicePurchaseCubit(gh<_i545.InvoiceUseCase>()));
    gh.factory<_i464.PayrollCubit>(() => _i464.PayrollCubit(
          gh<_i311.GeneratePayrollUseCase>(),
          gh<_i311.GetPayrollsUseCase>(),
          gh<_i311.UpdatePaymentStatusUseCase>(),
          gh<_i311.DeletePayrollUseCase>(),
        ));
    gh.factory<_i596.ContactCubit>(() => _i596.ContactCubit(
          gh<_i1008.GetContactsUseCase>(),
          gh<_i349.GetContactByIdUseCase>(),
          gh<_i807.CreateContactUseCase>(),
          gh<_i283.UpdateContactUseCase>(),
          gh<_i763.DeleteContactUseCase>(),
        ));
    gh.lazySingleton<_i134.GoogleDriveBackupService>(
        () => _i134.GoogleDriveBackupService(
              gh<_i520.GoogleDriveAuthService>(),
              gh<_i79.BooksDataExporter>(),
              gh<_i884.BooksDeltaExporter>(),
              gh<_i1007.GoogleDriveApiClient>(),
              gh<_i121.LocalDb>(),
            ));
    gh.factory<_i1073.SettlementCubit>(
        () => _i1073.SettlementCubit(gh<_i901.SettlementUseCase>()));
    gh.factory<_i712.StatementReportCubit>(() =>
        _i712.StatementReportCubit(gh<_i1019.GetStatementReportUseCase>()));
    gh.factory<_i61.PaymentCubit>(
        () => _i61.PaymentCubit(gh<_i896.UpdatePaymentUseCase>()));
    gh.factory<_i223.CreateInvoiceCubit>(
        () => _i223.CreateInvoiceCubit(gh<_i1064.CreateInvoiceUseCase>()));
    gh.lazySingleton<_i965.ClientToServerUseCase>(() =>
        _i965.ClientToServerUseCase(gh<_i631.ClientToServerRepository>()));
    gh.factory<_i995.PreviousStockDeleteCubit>(() =>
        _i995.PreviousStockDeleteCubit(gh<_i103.PreviousStockDeleteUseCase>()));
    gh.lazySingleton<_i186.GetOrderDetailUseCase>(
        () => _i186.GetOrderDetailUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i524.UpdateOrderStatusUseCase>(
        () => _i524.UpdateOrderStatusUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i6.GetOrdersUseCase>(
        () => _i6.GetOrdersUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i522.UpdateQotUseCase>(
        () => _i522.UpdateQotUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i346.UpdateOrderItemStatusUseCase>(
        () => _i346.UpdateOrderItemStatusUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i169.UpdateQotStatusUseCase>(
        () => _i169.UpdateQotStatusUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i860.GetOrderActivityUseCase>(
        () => _i860.GetOrderActivityUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i721.UpdateOrderItemUseCase>(
        () => _i721.UpdateOrderItemUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i870.CheckoutOrderUseCase>(
        () => _i870.CheckoutOrderUseCase(gh<_i44.OrderRepository>()));
    gh.lazySingleton<_i1021.CreateOrderUseCase>(
        () => _i1021.CreateOrderUseCase(gh<_i44.OrderRepository>()));
    gh.factory<_i198.RoleManageCubit>(
        () => _i198.RoleManageCubit(gh<_i551.RolesRepository>()));
    gh.lazySingleton<_i373.CreateHotelSummaryUseCase>(() =>
        _i373.CreateHotelSummaryUseCase(gh<_i90.HotelSummaryRepository>()));
    gh.lazySingleton<_i202.GetHotelSummaryByIdUseCase>(() =>
        _i202.GetHotelSummaryByIdUseCase(gh<_i90.HotelSummaryRepository>()));
    gh.lazySingleton<_i808.UpdateHotelSummaryUseCase>(() =>
        _i808.UpdateHotelSummaryUseCase(gh<_i90.HotelSummaryRepository>()));
    gh.lazySingleton<_i961.GetHotelSummariesUseCase>(() =>
        _i961.GetHotelSummariesUseCase(gh<_i90.HotelSummaryRepository>()));
    gh.lazySingleton<_i873.DeleteHotelSummaryUseCase>(() =>
        _i873.DeleteHotelSummaryUseCase(gh<_i90.HotelSummaryRepository>()));
    gh.lazySingleton<_i862.UserPermissionsUseCase>(() =>
        _i862.UserPermissionsUseCase(gh<_i569.UserPermissionsRepository>()));
    gh.lazySingleton<_i101.PreviousStockUseCase>(
        () => _i101.PreviousStockUseCase(gh<_i904.ReconciliationRepository>()));
    gh.factory<_i650.GenerateReconciliationReportUseCase>(() =>
        _i650.GenerateReconciliationReportUseCase(
            gh<_i904.ReconciliationRepository>()));
    gh.factory<_i883.GenerateReconciliationDirectReportUseCase>(() =>
        _i883.GenerateReconciliationDirectReportUseCase(
            gh<_i904.ReconciliationRepository>()));
    gh.factory<_i567.UploadReconciliationDataUseCase>(() =>
        _i567.UploadReconciliationDataUseCase(
            gh<_i904.ReconciliationRepository>()));
    gh.factory<_i1066.LoginCubit>(
        () => _i1066.LoginCubit(gh<_i772.LoginUseCase>()));
    gh.lazySingleton<_i153.FileCreationUseCase>(
        () => _i153.FileCreationUseCase(gh<_i501.FileCreationRepository>()));
    gh.factory<_i169.PreviousStockDetailsCubit>(() =>
        _i169.PreviousStockDetailsCubit(
            gh<_i892.PreviousStockDetailsUseCase>()));
    gh.factory<_i422.AttendanceCubit>(() => _i422.AttendanceCubit(
          gh<_i120.GetAttendanceUseCase>(),
          gh<_i552.RecordAttendanceUseCase>(),
          gh<_i991.EmployeeManagementRepository>(),
        ));
    gh.factory<_i1066.EmployeeCubit>(() => _i1066.EmployeeCubit(
          gh<_i277.GetEmployeesUseCase>(),
          gh<_i882.CreateEmployeeUseCase>(),
          gh<_i991.EmployeeManagementRepository>(),
        ));
    gh.factory<_i336.PayrollCubit>(() => _i336.PayrollCubit(
          gh<_i22.GetPayrollsUseCase>(),
          gh<_i436.GeneratePayrollUseCase>(),
          gh<_i991.EmployeeManagementRepository>(),
        ));
    gh.factory<_i241.ServerToClientCubit>(
        () => _i241.ServerToClientCubit(gh<_i932.ServerToClientUseCase>()));
    gh.factory<_i381.OrderCubit>(
        () => _i381.OrderCubit(gh<_i6.GetOrdersUseCase>()));
    gh.factory<_i85.DeleteInvoiceCubit>(
        () => _i85.DeleteInvoiceCubit(gh<_i503.DeleteInvoiceUseCase>()));
    gh.factory<_i274.UpdateInvoiceCubit>(
        () => _i274.UpdateInvoiceCubit(gh<_i97.UpdateInvoiceUseCase>()));
    gh.factory<_i6.HotelSummaryCubit>(() => _i6.HotelSummaryCubit(
          gh<_i961.GetHotelSummariesUseCase>(),
          gh<_i202.GetHotelSummaryByIdUseCase>(),
          gh<_i373.CreateHotelSummaryUseCase>(),
          gh<_i808.UpdateHotelSummaryUseCase>(),
          gh<_i873.DeleteHotelSummaryUseCase>(),
        ));
    gh.factory<_i67.PreviousStockCubit>(
        () => _i67.PreviousStockCubit(gh<_i101.PreviousStockUseCase>()));
    gh.factory<_i529.DashboardSummaryPageCubit>(() =>
        _i529.DashboardSummaryPageCubit(
            gh<_i889.DashboardSummaryPageUseCase>()));
    gh.factory<_i358.ReconciliationReportCubit>(() =>
        _i358.ReconciliationReportCubit(
            gh<_i650.GenerateReconciliationReportUseCase>()));
    gh.factory<_i541.PaymentMethodsCubit>(
        () => _i541.PaymentMethodsCubit(gh<_i832.GetPaymentMethodsUseCase>()));
    gh.factory<_i996.UserPermissionsCubit>(
        () => _i996.UserPermissionsCubit(gh<_i862.UserPermissionsUseCase>()));
    gh.lazySingleton<_i793.AutoBackupCoordinator>(
        () => _i793.AutoBackupCoordinator(
              gh<_i134.GoogleDriveBackupService>(),
              gh<_i604.GoogleDriveRestoreService>(),
              gh<_i520.GoogleDriveAuthService>(),
              gh<_i1007.GoogleDriveApiClient>(),
              gh<_i36.InternetInfo>(),
              gh<_i121.LocalDb>(),
            ));
    gh.factory<_i922.PartyCubit>(() => _i922.PartyCubit(
          gh<_i178.GetPartiesUseCase>(),
          gh<_i178.GetPartyByIdUseCase>(),
          gh<_i178.CreatePartyUseCase>(),
          gh<_i178.UpdatePartyUseCase>(),
          gh<_i178.DeletePartyUseCase>(),
        ));
    gh.factory<_i279.OrderDetailCubit>(() => _i279.OrderDetailCubit(
          gh<_i186.GetOrderDetailUseCase>(),
          gh<_i860.GetOrderActivityUseCase>(),
          gh<_i870.CheckoutOrderUseCase>(),
          gh<_i346.UpdateOrderItemStatusUseCase>(),
          gh<_i721.UpdateOrderItemUseCase>(),
          gh<_i169.UpdateQotStatusUseCase>(),
          gh<_i522.UpdateQotUseCase>(),
        ));
    gh.factory<_i830.ReconciliationUploadCubit>(() =>
        _i830.ReconciliationUploadCubit(
            gh<_i567.UploadReconciliationDataUseCase>()));
    gh.factory<_i48.FileCreationCubit>(
        () => _i48.FileCreationCubit(gh<_i153.FileCreationUseCase>()));
    gh.factory<_i671.ReconciliationDirectReportCubit>(() =>
        _i671.ReconciliationDirectReportCubit(
            gh<_i883.GenerateReconciliationDirectReportUseCase>()));
    gh.factory<_i863.ClientToServerCubit>(
        () => _i863.ClientToServerCubit(gh<_i965.ClientToServerUseCase>()));
    return this;
  }
}

class _$RegisterModule extends _i694.RegisterModule {}
