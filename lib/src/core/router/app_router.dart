import 'package:flutter/material.dart';
import '../../presentation/views/main/main_view.dart';
import '../error/exceptions.dart';

class AppRouter {
  static const String home = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      default:
        throw const RouteException('Route not found!');
    }
  }
}
