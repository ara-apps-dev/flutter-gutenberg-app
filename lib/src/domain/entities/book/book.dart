class Author {
  final String name;
  final int birthYear;
  final int deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });
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
}
