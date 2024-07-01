import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/book/book.dart';

abstract class BookState extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<Book>? books;
  final int? currentCount;

  const BookState({
    this.books,
    this.count,
    this.next,
    this.previous,
    this.currentCount,
  });

  @override
  List<Object?> get props => [count, next, previous, books, currentCount];
}

class BookInitial extends BookState {
  const BookInitial({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
  });
}

class BookEmpty extends BookState {
  const BookEmpty({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
  });
}

class BookLoadingMore extends BookState {
  const BookLoadingMore({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
  });
}

class BookLoading extends BookState {
  const BookLoading({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
  });
}

class BookLoaded extends BookState {
  const BookLoaded({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
  });
}

class BookError extends BookState {
  final Failure failure;

  const BookError({
    super.books,
    super.count,
    super.next,
    super.previous,
    super.currentCount,
    required this.failure,
  });

  @override
  List<Object?> get props => [books, count, next, previous, failure];
}

