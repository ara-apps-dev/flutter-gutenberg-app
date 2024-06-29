import '../../../env/env.dart';
import '../../domain/usecase/book/get_book_usecase.dart';

String constructUrl(FilterBookParams params) {
  final queryParameters = {
    'author_year_start': params.authorYearStart?.toString(),
    'author_year_end': params.authorYearEnd?.toString(),
    'copyright': params.copyright?.toString(),
    'ids': params.ids?.join(','),
    'languages': params.languages?.join(','),
    'mime_type': params.mimeType,
    'search': params.search,
    'sort': params.sort,
    'topic': params.topic,
  }..removeWhere((key, value) => value == null);

  final uri = Uri.parse('${Env.baseUrl}/books')
      .replace(queryParameters: queryParameters);
  return uri.toString();
}
