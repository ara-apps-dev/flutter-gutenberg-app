import 'package:http/http.dart' as http;
import '../../../../env/env.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/util/url_generate.dart';
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
    final url = params.pageUrl ?? constructUrl(params);
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
