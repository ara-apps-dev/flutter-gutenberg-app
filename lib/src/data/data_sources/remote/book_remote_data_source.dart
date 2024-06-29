import 'package:http/http.dart' as http;
import '../../../../env/env.dart';
import '../../../core/error/exceptions.dart';
import '../../../domain/usecase/book/get_book_usecase.dart';
import '../../models/book/book_response_model.dart';

abstract class BookRemoteDataSource {
  Future<BookResponseModel> getBooks(FilterBookParams params);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;
  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookResponseModel> getBooks(FilterBookParams params) async {
    final url = params.pageUrl ?? _constructUrl(params);
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return bookResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }

  String _constructUrl(FilterBookParams params) {
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
}
