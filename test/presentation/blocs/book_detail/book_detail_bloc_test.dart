import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_gutenberg_app/src/core/error/failures.dart';
import 'package:flutter_gutenberg_app/src/domain/entities/book_detail/book_detail.dart';
import 'package:flutter_gutenberg_app/src/domain/entities/book_detail/formats.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_detail_usecase.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book_detail/book_detail_bloc.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book_detail/book_detail_event.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book_detail/book_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBookDetailUseCase extends Mock implements GetBookDetailUseCase {}

void main() {
  late MockGetBookDetailUseCase mockGetBookDetailUseCase;
  late BookDetailBloc bookDetailBloc;

  setUp(() {
    mockGetBookDetailUseCase = MockGetBookDetailUseCase();
    bookDetailBloc = BookDetailBloc(mockGetBookDetailUseCase);
  });

  tearDown(() {
    bookDetailBloc.close();
  });

  const int mockBookId = 1;
  final mockBookDetail = BookDetail(
    id: 1,
    title: 'Sample Book',
    authors: [],
    translators: [],
    subjects: [],
    bookshelves: [],
    languages: [],
    copyright: false,
    mediaType: 'text/plain',
    formats: Formats(),
    downloadCount: 0,
  );

  group('BookDetailBloc', () {
    blocTest<BookDetailBloc, BookDetailState>(
      'emits [BookDetailLoading, BookDetailLoaded] when successful',
      build: () {
        when(() => mockGetBookDetailUseCase(any()))
            .thenAnswer((_) async => Right(mockBookDetail));
        return bookDetailBloc;
      },
      act: (bloc) => bloc.add(const GetBookDetail(mockBookId)),
      expect: () => [
        BookDetailLoading(),
        BookDetailLoaded(
          id: mockBookDetail.id,
          title: mockBookDetail.title,
          authors: mockBookDetail.authors,
          translators: mockBookDetail.translators,
          subjects: mockBookDetail.subjects,
          bookshelves: mockBookDetail.bookshelves,
          languages: mockBookDetail.languages,
          copyright: mockBookDetail.copyright,
          mediaType: mockBookDetail.mediaType,
          formats: mockBookDetail.formats,
          downloadCount: mockBookDetail.downloadCount,
        ),
      ],
      verify: (_) {
        verify(() => mockGetBookDetailUseCase(mockBookId)).called(1);
      },
    );

    blocTest<BookDetailBloc, BookDetailState>(
      'emits [BookDetailLoading, BookDetailError] when unsuccessful',
      build: () {
        when(() => mockGetBookDetailUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bookDetailBloc;
      },
      act: (bloc) => bloc.add(const GetBookDetail(mockBookId)),
      expect: () => [
        BookDetailLoading(),
        BookDetailError(ServerFailure()),
      ],
      verify: (_) {
        verify(() => mockGetBookDetailUseCase(mockBookId)).called(1);
      },
    );
  });
}
