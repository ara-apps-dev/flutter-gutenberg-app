import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/book/book.dart';
import '../../../domain/entities/book/pagination_meta_data.dart';

abstract class HomeState extends Equatable {
  final List<Book> books;
  final PaginationMetaData metaData;
  const HomeState({required this.books, required this.metaData});
}

class BookInitial extends HomeState {
  const BookInitial({
    required super.books,
    required super.metaData,
  });

  @override
  List<Object> get props => [];
}

class BookEmpty extends HomeState {
  const BookEmpty({
    required super.books,
    required super.metaData,
  });

  @override
  List<Object> get props => [];
}

class BookLoaded extends HomeState {
  const BookLoaded({
    required super.books,
    required super.metaData,
  });

  @override
  List<Object> get props => [];
}

class BookError extends HomeState {
  final Failure failure;
  const BookError({
    required super.books,
    required super.metaData,
    required this.failure,
  });

  @override
  List<Object> get props => [];
}
