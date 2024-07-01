import 'package:dartz/dartz.dart';
import 'package:flutter_gutenberg_app/src/data/models/book/book_response_model.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/book/book_response.dart';
import '../../domain/entities/book_detail/book_detail.dart';
import '../../domain/repositories/book_repository.dart';
import '../../domain/usecase/book/get_book_usecase.dart';
import '../data_sources/local/book_local_data_source.dart';
import '../data_sources/remote/book_remote_data_source.dart';

typedef _ConcreteOrBookChooser = Future<BookResponse> Function();
typedef _ConcreteOrBookDetailChooser = Future<BookDetail> Function();

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

  @override
  Future<Either<Failure, BookDetail>> getBookDetail(int bookId) async {
    return await _getBookDetail(() {
      return remoteDataSource.getBookDetail(bookId);
    }, bookId);
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

  Future<Either<Failure, BookDetail>> _getBookDetail(
    _ConcreteOrBookDetailChooser getConcreteOrBookDetail,
    int bookId,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBookDetail = await getConcreteOrBookDetail();
        localDataSource.saveBookDetail(remoteBookDetail);
        return Right(remoteBookDetail);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localBookDetail = await localDataSource.getBookDetail(bookId);
        return Right(localBookDetail);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
