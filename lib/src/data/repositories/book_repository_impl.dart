import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/book/book_response.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecase/book/get_book_usecase.dart';
import '../data_sources/local/book_local_data_source.dart';
import '../data_sources/remote/book_remote_data_source.dart';
import '../models/book/book_response_model.dart';

typedef _ConcreteOrBookChooser = Future<BookResponse> Function();

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BookResponse>> getBooks(
      FilterBookParams params) async {
    return await _getBooks(() {
      return remoteDataSource.getBooks(params);
    });
  }

  Future<Either<Failure, BookResponse>> _getBooks(
    _ConcreteOrBookChooser getConcreteOrBooks,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBooks = await getConcreteOrBooks();
        localDataSource.saveBooks(remoteBooks as BookResponseModel);
        return Right(remoteBooks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localBooks = await localDataSource.getLastBooks();
        return Right(localBooks);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
