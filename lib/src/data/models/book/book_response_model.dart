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
  final PaginationMetaData? meta;
  final List<Book>? data;

  BookResponseModel({
    required this.meta,
    required this.data,
  }) : super(
            books: data ?? [],
            paginationMetaData:
                meta ?? PaginationMetaData(count: 0, next: "", previous: ""));

  factory BookResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BookResponseModel(
        meta: null,
        data: [],
      );
    }

    return BookResponseModel(
      meta: json["meta"] != null
          ? PaginationMetaDataModel.fromJson(json["meta"])
          : null,
      data: json["data"] != null
          ? List<Book>.from(json["data"].map((x) => BookModel.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (meta != null) {
      json["meta"] = meta!.toJson();
    }

    if (data != null) {
      json["data"] = data!.map((x) => x.toJson()).toList();
    }

    return json;
  }
}
