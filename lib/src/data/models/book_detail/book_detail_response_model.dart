import 'dart:convert';

import '../../../domain/entities/book_detail/book_detail.dart';

BookDetail bookDetailFromJson(String str) =>
    BookDetail.fromJson(json.decode(str));

String bookDetailToJson(BookDetail data) =>
    json.encode(data.toJson());
