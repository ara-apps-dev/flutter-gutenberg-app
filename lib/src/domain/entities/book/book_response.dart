import 'pagination_meta_data.dart';
import 'book.dart';

class BookResponse {
  final PaginationMetaData paginationMetaData;
  final List<Book> books;

  BookResponse({
    required this.paginationMetaData,
    required this.books,
  });
}
