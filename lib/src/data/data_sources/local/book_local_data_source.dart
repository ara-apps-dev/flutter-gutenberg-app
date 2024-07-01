import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/book_detail/book_detail.dart';
import '../../models/book/book_response_model.dart';
import '../../models/book_detail/book_detail_response_model.dart';

abstract class BookLocalDataSource {
  Future<BookResponseModel> getLastBooks();
  Future<void> saveBooks(BookResponseModel booksToCache);
  Future<void> saveBookDetail(BookDetail bookDetail);
  Future<BookDetail> getBookDetail(int bookId);
  Future<void> likeBook(int bookId);
  Future<List<BookDetail>> getLikedBooks();
}

const cachedBooks = 'CACHED_BOOKS';
const cachedBookDetails = 'CACHED_BOOK_DETAILS';
const likedBooksKey = 'LIKED_BOOKS';

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final SharedPreferences sharedPreferences;
  BookLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<BookResponseModel> getLastBooks() {
    final jsonString = sharedPreferences.getString(cachedBooks);
    if (jsonString != null) {
      return Future.value(bookResponseModelFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveBooks(BookResponseModel booksToCache) {
    return sharedPreferences.setString(
      cachedBooks,
      json.encode(bookResponseModelToJson(booksToCache)),
    );
  }

  @override
  Future<void> saveBookDetail(BookDetail bookDetail) async {
    final jsonString = json.encode(bookDetailToJson(bookDetail));
    await sharedPreferences.setString(
        '$cachedBookDetails-${bookDetail.id}', jsonString);
  }

  @override
  Future<BookDetail> getBookDetail(int bookId) {
    final jsonString =
        sharedPreferences.getString('$cachedBookDetails-$bookId');
    if (jsonString != null) {
      return Future.value(bookDetailFromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> likeBook(int bookId) async {
    final likedBooks = sharedPreferences.getStringList(likedBooksKey) ?? [];
    if (!likedBooks.contains(bookId.toString())) {
      likedBooks.add(bookId.toString());
      await sharedPreferences.setStringList(likedBooksKey, likedBooks);
    }
  }

  @override
  Future<List<BookDetail>> getLikedBooks() async {
    final likedBooksIds = sharedPreferences.getStringList(likedBooksKey) ?? [];
    final likedBooks = <BookDetail>[];

    for (final bookId in likedBooksIds) {
      final jsonString =
          sharedPreferences.getString('$cachedBookDetails-$bookId');
      if (jsonString != null) {
        likedBooks.add(bookDetailFromJson(jsonDecode(jsonString)));
      }
    }

    return Future.value(likedBooks);
  }
}
