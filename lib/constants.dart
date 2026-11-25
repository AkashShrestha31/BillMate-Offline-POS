import 'package:flutter/material.dart';
import 'package:hotel/src/core/themes/app_colors.dart';
import 'package:hotel/src/core/services/currency/app_currency_formatter.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

export 'package:hotel/src/core/themes/app_fonts.dart';

Color get primaryColor => AppColors.primaryColor;
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

/// Reporting currency symbol from setup / settings ([AppCurrencyFormatter]).
String get currencySymbol => AppCurrencyFormatter.symbol;
