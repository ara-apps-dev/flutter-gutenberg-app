import 'package:equatable/equatable.dart';

abstract class BookDetailEvent extends Equatable {
  const BookDetailEvent();

  @override
  List<Object?> get props => [];
}

class GetBookDetail extends BookDetailEvent {
  final int bookId;

  const GetBookDetail(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class LikeBook extends BookDetailEvent {
  final int bookId;

  const LikeBook(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class GetLikedBooks extends BookDetailEvent {
  const GetLikedBooks();

  @override
  List<Object?> get props => [];
}
