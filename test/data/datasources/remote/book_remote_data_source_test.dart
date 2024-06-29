import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:flutter_gutenberg_app/src/core/error/exceptions.dart';
import 'package:flutter_gutenberg_app/src/core/util/url_generate.dart';
import 'package:flutter_gutenberg_app/src/data/data_sources/remote/book_remote_data_source.dart';
import 'package:flutter_gutenberg_app/src/data/models/book/book_response_model.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BookRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BookRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getBooks', () {
    final fakeParams = FilterBookParams(
      sort: 'ascending',
    );

    final expectedUrl = fakeParams.pageUrl ?? constructUrl(fakeParams);
    final fakeResponse = fixture('book/book_remote_response.json');

    test('should throw a ServerException on non-200 status code', () async {
      // Arrange
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response('Error message', 404));

      // Act
      final call = dataSource.getBooks(fakeParams);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test('should return a BookResponseModel when the response is successful',
        () async {
      // Arrange
      when(() => mockHttpClient.get(Uri.parse(expectedUrl),
              headers: any(named: 'headers')))
          .thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParams);

      // Assert
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request to the correct URL when pageUrl is null',
        () async {
      // Arrange
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrl),
            headers: {
              'Content-Type': 'application/json',
            },
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParams);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrl),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test(
        'should perform a GET request to the correct URL when pageUrl is provided',
        () async {
      // Arrange
      final fakeParamsWithPageUrl =
          fakeParams.copyWith(pageUrl: '${Env.baseUrl}book/page=2');
      when(() => mockHttpClient.get(
            Uri.parse(fakeParamsWithPageUrl.pageUrl!),
            headers: {
              'Content-Type': 'application/json',
            },
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithPageUrl);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(fakeParamsWithPageUrl.pageUrl!),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with author year filter', () async {
      final fakeParamsWithAuthorYear = fakeParams.copyWith(
        authorYearStart: 1900,
        authorYearEnd: 1999,
      );
      final expectedUrlWithAuthorYear = constructUrl(fakeParamsWithAuthorYear);

      // Arrange
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithAuthorYear),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithAuthorYear);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithAuthorYear),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with language filter', () async {
      // Arrange
      final fakeParamsWithLanguages =
          fakeParams.copyWith(languages: ['en', 'fr']);
      final expectedUrlWithLanguages = constructUrl(fakeParamsWithLanguages);
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithLanguages),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithLanguages);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithLanguages),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with topic filter', () async {
      // Arrange
      final fakeParamsWithTopic = fakeParams.copyWith(topic: 'children');
      final expectedUrlWithTopic = constructUrl(fakeParamsWithTopic);
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithTopic),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithTopic);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithTopic),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with mime type filter', () async {
      // Arrange
      final fakeParamsWithMimeType =
          fakeParams.copyWith(mimeType: 'text%2Fhtml');
      final expectedUrlWithMimeType = constructUrl(fakeParamsWithMimeType);
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithMimeType),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithMimeType);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithMimeType),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with specific IDs filter', () async {
      // Arrange
      final fakeParamsWithIds = fakeParams.copyWith(ids: [11, 12, 13]);
      final expectedUrlWithIds = constructUrl(fakeParamsWithIds);
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithIds),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithIds);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithIds),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });

    test('should perform a GET request with sort order', () async {
      // Arrange
      final fakeParamsWithSort = fakeParams.copyWith(sort: 'descending');
      final expectedUrlWithSort = constructUrl(fakeParamsWithSort);
      when(() => mockHttpClient.get(
            Uri.parse(expectedUrlWithSort),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getBooks(fakeParamsWithSort);

      // Assert
      verify(() => mockHttpClient.get(Uri.parse(expectedUrlWithSort),
          headers: any(named: 'headers')));
      expect(result, isA<BookResponseModel>());
    });
  });
}
