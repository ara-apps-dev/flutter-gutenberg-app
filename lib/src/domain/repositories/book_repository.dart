import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/models/book/book_response_model.dart';
import '../usecase/book/get_book_usecase.dart';

abstract class BookRepository {
  Future<Either<Failure, BookResponseModel>> getBooks(FilterBookParams params);
}
