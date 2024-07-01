import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/error/exceptions.dart';
import '../../../domain/entities/book_detail/book_detail.dart';
import '../../models/book/book_response_model.dart';

abstract class BookLocalDataSource {
  Future<BookResponseModel> getLastBooks();
  Future<void> saveBooks(BookResponseModel booksToCache);
  Future<void> saveBookDetail(BookDetail bookDetail);
  Future<BookDetail> getBookDetail(int bookId);
  Future<void> likeBook(int bookId);
  Future<List<BookDetail>> getLikedBooks();
}

class BookLocalDataSourceImpl implements BookLocalDataSource {
  final HiveInterface hive;

  BookLocalDataSourceImpl({required this.hive});

  @override
  Future<BookResponseModel> getLastBooks() async {
    try {
      final box = await hive.openBox<BookResponseModel>('cached_books');
      if (box.isNotEmpty) {
        final cachedBooks = box.getAt(0);
        return cachedBooks!;
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveBooks(BookResponseModel booksToCache) async {
    final box = await hive.openBox<BookResponseModel>('cached_books');
    await box.clear();
    await box.add(booksToCache);
  }

  @override
  Future<void> saveBookDetail(BookDetail bookDetail) async {
    final box = await hive.openBox<BookDetail>('cached_book_details');
    await box.put(bookDetail.id, bookDetail);
  }

  @override
  Future<BookDetail> getBookDetail(int bookId) async {
    final box = await hive.openBox<BookDetail>('cached_book_details');
    final jsonMap = box.get(bookId);
    if (jsonMap != null) {
      return BookDetail.fromJson(jsonMap as Map<String, dynamic>);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> likeBook(int bookId) async {
    final box = await hive.openBox<BookDetail>('cached_book_details');
    final bookDetail = box.get(bookId);
    if (bookDetail != null) {
      bookDetail.liked = true;
      await box.put(bookId, bookDetail);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<BookDetail>> getLikedBooks() async {
    final box = await hive.openBox<BookDetail>('cached_book_details');
    final likedBooks =
        box.values.where((book) => (book).liked ?? false).toList();
    return likedBooks.cast<BookDetail>();
  }
}
