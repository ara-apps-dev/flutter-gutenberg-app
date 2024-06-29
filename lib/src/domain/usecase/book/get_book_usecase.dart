class FilterBookParams {
  final int? authorYearStart;
  final int? authorYearEnd;
  final bool? copyright;
  final List<int>? ids;
  final List<String>? languages;
  final String? mimeType;
  final String? search;
  final String? sort;
  final String? topic;

  FilterBookParams({
    this.authorYearStart,
    this.authorYearEnd,
    this.copyright,
    this.ids,
    this.languages,
    this.mimeType,
    this.search,
    this.sort,
    this.topic,
  });
}
