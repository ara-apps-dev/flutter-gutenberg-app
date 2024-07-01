import '../book/author.dart';
import 'translator.dart';
import 'formats.dart';

class BookDetail {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<Translator>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;
  bool? liked;

  BookDetail({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
    this.liked = false,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) {
    return BookDetail(
      id: json['id'],
      title: json['title'],
      authors: (json['authors'] as List<dynamic>?)
              ?.map((author) => Author.fromJson(author))
              .toList() ??
          [],
      translators: (json['translators'] as List<dynamic>?)
              ?.map((translator) => Translator.fromJson(translator))
              .toList() ??
          [],
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((subject) => subject as String)
              .toList() ??
          [],
      bookshelves: (json['bookshelves'] as List<dynamic>?)
              ?.map((bookshelf) => bookshelf as String)
              .toList() ??
          [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((language) => language as String)
              .toList() ??
          [],
      copyright: json['copyright'] ?? false,
      mediaType: json['media_type'],
      formats:
          json['formats'] != null ? Formats.fromJson(json['formats']) : null,
      downloadCount: json['download_count'],
      liked: json['liked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors?.map((author) => author.toJson()).toList() ?? [],
      'translators':
          translators?.map((translator) => translator.toJson()).toList() ?? [],
      'subjects': subjects ?? [],
      'bookshelves': bookshelves ?? [],
      'languages': languages ?? [],
      'copyright': copyright,
      'media_type': mediaType,
      'formats': formats?.toJson(),
      'download_count': downloadCount,
      'liked': liked,
    };
  }
}
