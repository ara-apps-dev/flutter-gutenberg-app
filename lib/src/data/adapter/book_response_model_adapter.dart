import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import '../models/book/book_response_model.dart';

// JSON Serialization/Deserialization
BookResponseModel bookResponseModelFromJson(String str) =>
    BookResponseModel.fromJson(json.decode(str));

String bookResponseModelToJson(BookResponseModel data) =>
    json.encode(data.toJson());

// Hive Type Adapter (if needed)
class BookResponseModelAdapter extends TypeAdapter<BookResponseModel> {
  @override
  final int typeId = 0; // Unique identifier for Hive

  @override
  BookResponseModel read(BinaryReader reader) {
    // Implement how to read from Hive
    return BookResponseModel.fromJson(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, BookResponseModel obj) {
    // Implement how to write to Hive
    writer.writeMap(obj.toJson());
  }
}
