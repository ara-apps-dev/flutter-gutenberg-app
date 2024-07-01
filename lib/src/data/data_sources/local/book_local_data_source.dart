import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../models/book/book_response_model.dart';

abstract class BookLocalDataSource {
  Future<BookResponseModel> getLastBooks();
  Future<void> saveBooks(BookResponseModel booksToCache);
}

const cachedBooks = 'CACHED_BOOKS';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<BookResponseModel> getLastBooks() async {
    final jsonString = sharedPreferences.getString(cachedBooks);
    if (jsonString != null) {
      return BookResponseModel.fromJson(jsonDecode(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveBooks(BookResponseModel booksToCache) async {
    await sharedPreferences.setString(
      cachedBooks,
      json.encode(booksToCache.toJson()),
    );
  }
}
