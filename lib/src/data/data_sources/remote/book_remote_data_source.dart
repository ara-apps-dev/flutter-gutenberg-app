import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:http/http.dart' as http;
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
  Future<BookResponseModel> getBooks(FilterBookParams params) {
    final queryParameters = {
      if (params.authorYearStart != null)
        'author_year_start': params.authorYearStart.toString(),
      if (params.authorYearEnd != null)
        'author_year_end': params.authorYearEnd.toString(),
      if (params.copyright != null) 'copyright': params.copyright.toString(),
      if (params.ids != null) 'ids': params.ids!.join(','),
      if (params.languages != null) 'languages': params.languages!.join(','),
      if (params.mimeType != null) 'mime_type': params.mimeType!,
      if (params.search != null) 'search': params.search!,
      if (params.sort != null) 'sort': params.sort!,
      if (params.topic != null) 'topic': params.topic!,
    };

    final queryString = Uri(queryParameters: queryParameters).query;
    final url = '${Env.baseUrl}/books?$queryString';

    return _getBookFromUrl(url);
  }

  Future<BookResponseModel> _getBookFromUrl(String url) async {
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
}
