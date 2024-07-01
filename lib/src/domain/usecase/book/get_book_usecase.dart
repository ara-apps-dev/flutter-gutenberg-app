import 'package:dartz/dartz.dart';
import 'package:flutter_gutenberg_app/src/domain/entities/book/book_response.dart';

import '../../../core/error/failures.dart';
import '../../repositories/book_repository.dart';

class GetBookUseCase {
  final BookRepository repository;

  GetBookUseCase(this.repository);

  Future<Either<Failure, BookResponse>> call(FilterBookParams params) async {
    return await repository.getBooks(params);
  }
}

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
  final String? pageUrl;

  const FilterBookParams({
    this.authorYearStart,
    this.authorYearEnd,
    this.copyright,
    this.ids,
    this.languages,
    this.mimeType,
    this.search,
    this.sort,
    this.topic,
    this.pageUrl,
  });

  FilterBookParams copyWith({
    int? authorYearStart,
    int? authorYearEnd,
    bool? copyright,
    List<int>? ids,
    List<String>? languages,
    String? mimeType,
    String? search,
    String? sort,
    String? topic,
    String? pageUrl,
  }) {
    return FilterBookParams(
      authorYearStart: authorYearStart ?? this.authorYearStart,
      authorYearEnd: authorYearEnd ?? this.authorYearEnd,
      copyright: copyright ?? this.copyright,
      ids: ids ?? this.ids,
      languages: languages ?? this.languages,
      mimeType: mimeType ?? this.mimeType,
      search: search ?? this.search,
      sort: sort ?? this.sort,
      topic: topic ?? this.topic,
      pageUrl: pageUrl ?? this.pageUrl,
    );
  }
}
