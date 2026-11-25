import 'package:flutter/material.dart';

const kBoxDecoration = BoxDecoration(
  color: Colors.white, // Background color
  borderRadius: BorderRadius.all(Radius.circular(10)), // Rounded corners
  boxShadow: [
    BoxShadow(
      blurRadius: 6,
      spreadRadius: 0,
      offset: Offset(0, 1),
      color: Color(0x1A333333), // Semi-transparent shadow
    ),
  ],
);
