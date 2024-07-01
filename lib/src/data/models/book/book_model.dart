import '../../../domain/entities/book/author.dart';
import '../../../domain/entities/book/book.dart';

class AuthorModel extends Author {
  AuthorModel({
    required super.name,
    required super.birthYear,
    required super.deathYear,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
      };
}

class BookModel extends Book {
  BookModel({
    required super.id,
    required super.title,
    required super.authors,
    required super.subjects,
    required super.bookshelves,
    required super.languages,
    required super.copyright,
    required super.mediaType,
    required super.formats,
    required super.downloadCount,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        authors: List<AuthorModel>.from(
            json["authors"].map((x) => AuthorModel.fromJson(x))),
        subjects: List<String>.from(json["subjects"]),
        bookshelves: List<String>.from(json["bookshelves"]),
        languages: List<String>.from(json["languages"]),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: Map<String, String>.from(json["formats"]),
        downloadCount: json["download_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors":
            List<dynamic>.from(authors.map((x) => (x as AuthorModel).toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats,
        "download_count": downloadCount,
      };
}
