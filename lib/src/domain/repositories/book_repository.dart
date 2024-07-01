import 'package:dartz/dartz.dart';
import 'package:flutter_gutenberg_app/src/domain/entities/book/book_response.dart';

import '../../core/error/failures.dart';
import '../entities/book_detail/book_detail.dart';
import '../usecase/book/get_book_usecase.dart';

abstract class BookRepository {
  Future<Either<Failure, BookResponse>> getBooks(FilterBookParams params);
  Future<Either<Failure, BookDetail>> getBookDetail(int bookId);
}
