import 'package:equatable/equatable.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_usecase.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class GetBooks extends BookEvent {
  final FilterBookParams params;

  const GetBooks(this.params);

  @override
  List<Object> get props => [params];
}

class GetMoreBooks extends BookEvent {
  final String nextPageUrl;

  const GetMoreBooks(this.nextPageUrl);

  @override
  List<Object> get props => [];
}
