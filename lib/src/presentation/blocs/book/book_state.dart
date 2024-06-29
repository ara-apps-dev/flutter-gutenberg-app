import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/book/book.dart';
import '../../../domain/entities/book/pagination_meta_data.dart';

abstract class BookState extends Equatable {
  final List<Book> books;
  final PaginationMetaData metaData;

  const BookState({required this.books, required this.metaData});

  @override
  List<Object> get props => [books, metaData];
}

class BookInitial extends BookState {
  const BookInitial({
    required super.books,
    required super.metaData,
  });
}

class BookEmpty extends BookState {
  const BookEmpty({
    required super.books,
    required super.metaData,
  });
}

class BookLoading extends BookState {
  const BookLoading({
    required super.books,
    required super.metaData,
  });
}

class BookLoaded extends BookState {
  const BookLoaded({
    required super.books,
    required super.metaData,
  });
}

class BookError extends BookState {
  final Failure failure;

  const BookError({
    required super.books,
    required super.metaData,
    required this.failure,
  });

  @override
  List<Object> get props => [books, metaData, failure];
}
