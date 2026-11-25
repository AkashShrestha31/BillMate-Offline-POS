import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class InvoicePageWrapper extends StatelessWidget {
  const InvoicePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    AutoRouter.of(context);
    return const AutoRouter();
  }
}
