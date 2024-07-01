import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../entities/book_detail/book_detail.dart';
import '../../repositories/book_repository.dart';

class GetBookDetailUseCase {
  final BookRepository repository;

  GetBookDetailUseCase(this.repository);

  Future<Either<Failure, BookDetail>> call(int id) async {
    return await repository.getBookDetail(id);
  }
}
