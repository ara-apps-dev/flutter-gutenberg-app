class Translator {
  final String name;
  final int? birthYear;
  final int? deathYear;

  Translator({
    required this.name,
    this.birthYear,
    this.deathYear,
  });

  factory Translator.fromJson(Map<String, dynamic> json) {
    return Translator(
      name: json['name'],
      birthYear: json['birth_year'],
      deathYear: json['death_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birth_year': birthYear,
      'death_year': deathYear,
    };
  }
}
