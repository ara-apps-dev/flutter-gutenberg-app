import 'package:flutter/material.dart';
import 'src/my_app.dart';
import 'src/core/services/services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.setupLocator();

  runApp(const MyApp());
}
