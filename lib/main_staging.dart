import 'package:hotel/bootstrap.dart';
import 'package:hotel/src/app/presentation/view/app.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/config/app_env_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnvLoader.load('.env-staging');
  await bootstrap(() => const App());
}
