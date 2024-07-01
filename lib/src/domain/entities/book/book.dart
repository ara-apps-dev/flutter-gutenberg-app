import '../book_detail/formats.dart';
import 'author.dart';

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  final String mediaType;
  final Formats formats;
  final int downloadCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.subjects,
    required this.bookshelves,
    required this.languages,
    required this.copyright,
    required this.mediaType,
    required this.formats,
    required this.downloadCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      authors: json['authors'] != null
          ? List<Author>.from(json['authors'].map((x) => Author.fromJson(x)))
          : [],
      subjects: json['subjects'] != null
          ? List<String>.from(json['subjects'].map((x) => x.toString()))
          : [],
      bookshelves: json['bookshelves'] != null
          ? List<String>.from(json['bookshelves'].map((x) => x.toString()))
          : [],
      languages: json['languages'] != null
          ? List<String>.from(json['languages'].map((x) => x.toString()))
          : [],
      copyright: json['copyright'] ?? false,
      mediaType: json['media_type'] ?? '',
      formats: Formats.fromJson(json['formats']),
      downloadCount: json['download_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats,
        "download_count": downloadCount,
      };

  String? getCoverImageUrl() {
    return formats.coverImage;
  }
}
