class Author {
  final String name;
  final int birthYear;
  final int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "birth_year": birthYear,
      "death_year": deathYear,
    };
  }
}

class Book {
  final int id;
  final String title;
  final List<Author> authors;
  final String description;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "authors": authors.map((author) => author.toJson()).toList(),
      "description": description,
    };
  }
}
