import 'dart:convert';

import 'book_model.dart';
import '../../../domain/entities/book/book.dart';
import '../../../domain/entities/book/book_response.dart';

BookResponseModel bookResponseModelFromJson(String str) =>
    BookResponseModel.fromJson(json.decode(str));

String bookResponseModelToJson(BookResponseModel data) =>
    json.encode(data.toJson());

class BookResponseModel extends BookResponse {
  final int count;
  final String next;
  final String previous;
  final List<Book>? results;

  BookResponseModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  }) : super(
          count: count,
          next: next,
          previous: previous,
          books: results ?? [],
        );

  factory BookResponseModel.fromJson(Map<String, dynamic> json) {
    return BookResponseModel(
      count: json["count"] ?? 0,
      next: json["next"] ?? '',
      previous: json["previous"] ?? '',
      results: json["results"] != null
          ? List<Book>.from(json["results"].map((x) => BookModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      "count": count,
      "next": next,
      "previous": previous,
      "results":
          results != null ? results!.map((x) => x.toJson()).toList() : [],
    };

    return json;
  }
}
