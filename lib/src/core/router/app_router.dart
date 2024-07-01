import 'package:flutter/material.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/book/book_detail_view.dart';
import '../../presentation/views/main/main_view.dart';
import '../error/exceptions.dart';

class AppRouter {
  static const String home = '/';
  static const String bookDetails = '/book-details';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MainView());
      case bookDetails:
        int bookId = routeSettings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => BookDetailView(bookId: bookId));
      default:
        throw const RouteException('Route not found!');
    }
  }
}
