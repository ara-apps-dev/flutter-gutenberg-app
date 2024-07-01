import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_usecase.dart';

class FilterCubit extends Cubit<FilterBookParams> {
  final TextEditingController searchController = TextEditingController();
  FilterCubit() : super(const FilterBookParams());

  void update({
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
    emit(state.copyWith(
      authorYearStart: authorYearStart,
      authorYearEnd: authorYearEnd,
      copyright: copyright,
      ids: ids,
      languages: languages,
      mimeType: mimeType,
      search: search,
      sort: sort,
      topic: topic,
      pageUrl: pageUrl,
    ));
  }

  void reset() => emit(const FilterBookParams());
}
