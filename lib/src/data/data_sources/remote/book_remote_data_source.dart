import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:flutter_gutenberg_app/src/data/models/book_detail/book_detail_response_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/exceptions.dart';
import '../../../core/util/url_generate.dart';
import '../../../domain/entities/book_detail/book_detail.dart';
import '../../../domain/usecase/book/get_book_usecase.dart';
import '../../models/book/book_response_model.dart';

abstract class BookRemoteDataSource {
  Future<BookResponseModel> getBooks(FilterBookParams params);
  Future<BookDetail> getBookDetail(int bookId);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<BookResponseModel> getBooks(FilterBookParams params) async {
    final url = params.pageUrl ?? constructUrl(params);

    try {
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
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<BookDetail> getBookDetail(int bookId) async {
    final url = '${Env.baseUrl}/books/$bookId/';

    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return bookDetailFromJson(response.body);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
