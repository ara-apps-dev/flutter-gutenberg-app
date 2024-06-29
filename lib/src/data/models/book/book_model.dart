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
    required super.description,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        authors: List<AuthorModel>.from(
            json["authors"].map((x) => AuthorModel.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors":
            List<dynamic>.from(authors.map((x) => (x as AuthorModel).toJson())),
        "description": description,
      };
}
