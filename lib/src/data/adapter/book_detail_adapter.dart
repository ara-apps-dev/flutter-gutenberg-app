import 'package:hive/hive.dart';

import '../../domain/entities/book/author.dart';
import '../../domain/entities/book_detail/book_detail.dart';
import '../../domain/entities/book_detail/formats.dart';
import '../../domain/entities/book_detail/translator.dart';

class BookDetailAdapter extends TypeAdapter<BookDetail> {
  @override
  final typeId = 1;

  @override
  BookDetail read(BinaryReader reader) {
    return BookDetail(
      id: reader.read() as int?,
      title: reader.read() as String?,
      authors: (reader.read() as List)
          .map((author) => Author.fromJson(author))
          .toList()
          .cast<Author>(),
      translators: (reader.read() as List)
          .map((translator) => Translator.fromJson(translator))
          .toList()
          .cast<Translator>(),
      subjects: (reader.read() as List).cast<String>(),
      bookshelves: (reader.read() as List).cast<String>(),
      languages: (reader.read() as List).cast<String>(),
      copyright: reader.read() as bool?,
      mediaType: reader.read() as String?,
      formats:
          reader.read() != null ? Formats.fromJson(reader.read() as Map) : null,
      downloadCount: reader.read() as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookDetail obj) {
    writer.write(obj.id);
    writer.write(obj.title);
    writer.write(obj.authors?.map((author) => author.toJson()).toList() ?? []);
    writer.write(
        obj.translators?.map((translator) => translator.toJson()).toList() ??
            []);
    writer.write(obj.subjects ?? []);
    writer.write(obj.bookshelves ?? []);
    writer.write(obj.languages ?? []);
    writer.write(obj.copyright);
    writer.write(obj.mediaType);
    writer.write(obj.formats?.toJson());
    writer.write(obj.downloadCount);
  }
}
