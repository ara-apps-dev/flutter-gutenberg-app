import 'book.dart';

class BookResponse {
  final int count;
  final String next;
  final String previous;
  final List<Book> books;

  BookResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.books,
  });

  // Optional: You can add a factory constructor for JSON deserialization if needed.
  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      count: json['count'] ?? 0,
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      books: json['books'] != null
          ? List<Book>.from(json['books'].map((x) => Book.fromJson(x)))
          : [],
    );
  }

  // Optional: You can add a toJson method for serialization to JSON.
  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'books': books.map((book) => book.toJson()).toList(),
    };
  }
}
