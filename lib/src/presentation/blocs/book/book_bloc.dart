
import 'package:bloc/bloc.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/book/book.dart';
import '../../../domain/entities/book/pagination_meta_data.dart';
import '../../../domain/usecase/book/get_book_usecase.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBookUseCase _getBookUseCase;

  BookBloc(this._getBookUseCase)
      : super(BookInitial(
          books: [],
          metaData: PaginationMetaData(
            count: 0,
            next: null,
            previous: null,
          ),
        )) {
    on<GetBooks>(_onLoadBooks);
    on<GetMoreBooks>(_onLoadMoreBooks);
  }

  void _onLoadBooks(GetBooks event, Emitter<BookState> emit) async {
    try {
      emit(BookLoading(books: [], metaData: state.metaData));
      final result = await _getBookUseCase(event.params);
      result.fold(
        (failure) => emit(BookError(
          books: state.books,
          metaData: state.metaData,
          failure: failure,
        )),
        (bookResponse) => emit(BookLoaded(
          books: bookResponse.books,
          metaData: bookResponse.paginationMetaData,
        )),
      );
    } catch (e) {
      emit(BookError(
        books: state.books,
        metaData: state.metaData,
        failure: ExceptionFailure(),
      ));
    }
  }

  void _onLoadMoreBooks(GetMoreBooks event, Emitter<BookState> emit) async {
    var state = this.state;
    if (state is BookLoaded && state.metaData.next != null) {
      try {
        emit(BookLoading(books: state.books, metaData: state.metaData));
        final result = await _getBookUseCase(FilterBookParams(
          pageUrl: state.metaData.next,
        ));
        result.fold(
          (failure) => emit(BookError(
            books: state.books,
            metaData: state.metaData,
            failure: failure,
          )),
          (bookResponse) {
            List<Book> books = List.from(state.books)..addAll(bookResponse.books);
            emit(BookLoaded(
              books: books,
              metaData: bookResponse.paginationMetaData,
            ));
          },
        );
      } catch (e) {
        emit(BookError(
          books: state.books,
          metaData: state.metaData,
          failure: ExceptionFailure(),
        ));
      }
    }
  }
}
