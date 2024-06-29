import 'dart:convert';
import '../../../domain/entities/book/book.dart';
import '../../../domain/entities/book/pagination_meta_data.dart';
import 'pagination_data_model.dart';
import 'book_model.dart';
import '../../../domain/entities/book/book_response.dart';

BookResponseModel bookResponseModelFromJson(String str) =>
    BookResponseModel.fromJson(json.decode(str));

String bookResponseModelToJson(BookResponseModel data) =>
    json.encode(data.toJson());

class BookResponseModel extends BookResponse {
  BookResponseModel({
    required PaginationMetaData meta,
    required List<Book> data,
  }) : super(books: data, paginationMetaData: meta);

  factory BookResponseModel.fromJson(Map<String, dynamic> json) =>
      BookResponseModel(
        meta: PaginationMetaDataModel.fromJson(json["meta"]),
        data: List<BookModel>.from(
            json["data"].map((x) => BookModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": (paginationMetaData as PaginationMetaDataModel).toJson(),
        "data": List<dynamic>.from(
            (books as List<BookModel>).map((x) => x.toJson())),
      };
}
