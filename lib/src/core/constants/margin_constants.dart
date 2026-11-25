import 'package:flutter/material.dart';

// Horizontal Margins
const horizontalMarginTiny = SizedBox(width: 2.0); // Tiny margin
const horizontalMarginXSmall = SizedBox(width: 4.0); // Extra small margin
const horizontalMarginSmall = SizedBox(width: 8.0); // Small margin
const horizontalMarginMedium = SizedBox(width: 16.0); // Medium margin
const horizontalMarginLarge = SizedBox(width: 24.0); // Large margin
const horizontalMarginXLarge = SizedBox(width: 32.0); // Extra-large margin
const horizontalMarginXXLarge =
    SizedBox(width: 48.0); // Extra-extra-large margin

// Vertical Margins
const verticalMarginTiny = SizedBox(height: 2.0); // Tiny margin
const verticalMarginXSmall = SizedBox(height: 4.0); // Extra small margin
const verticalMarginSmall = SizedBox(height: 8.0); // Small margin
const verticalMarginMedium = SizedBox(height: 16.0); // Medium margin
const verticalMargin20 = SizedBox(height: 20.0); // 20 margin
const verticalMarginLarge = SizedBox(height: 24.0); // Large margin
const verticalMarginXLarge = SizedBox(height: 32.0); // Extra-large margin
const verticalMargin40 = SizedBox(height: 40.0); // 40 margin
const verticalMarginXXLarge =
    SizedBox(height: 48.0); // Extra-extra-large margin

verticalMargin({required double height}) => SizedBox(height: height);

const emptyBox = SizedBox.shrink(); // Extra-extra-large margin
