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
