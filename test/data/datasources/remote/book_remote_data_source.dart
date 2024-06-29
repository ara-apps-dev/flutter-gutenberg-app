import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:flutter_gutenberg_app/src/core/error/exceptions.dart';
import 'package:flutter_gutenberg_app/src/data/data_sources/remote/book_remote_data_source.dart';
import 'package:flutter_gutenberg_app/src/data/models/book/book_response_model.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../../../fixture/fixture_reader.dart';

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
      authorYearStart: 1800,
      authorYearEnd: 1900,
      copyright: false,
      ids: [1, 2, 3],
      languages: ['en'],
      mimeType: 'text/plain',
      search: 'adventure',
      sort: 'ascending',
      topic: 'literature',
      pageUrl: null,
    );

    final expectedUrl =
        '${Env.baseUrl}/books?author_year_start=${fakeParams.authorYearStart}&author_year_end=${fakeParams.authorYearEnd}&copyright=${fakeParams.copyright}&ids=${(fakeParams.ids ?? []).join(',')}&languages=${(fakeParams.languages ?? []).join(',')}&mime_type=${fakeParams.mimeType}&search=${fakeParams.search}&sort=${fakeParams.sort}&topic=${fakeParams.topic}';
    final fakeResponse = fixture('book/book_remote_response.json');

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
          fakeParams.copyWith(pageUrl: 'https://example.com/page=2');
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
  });
}
