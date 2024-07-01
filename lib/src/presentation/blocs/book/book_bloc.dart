import 'package:bloc/bloc.dart';
import 'book_event.dart';
import 'book_state.dart';
import '../../../domain/usecase/book/get_book_usecase.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final GetBookUseCase _getBookUseCase;

  BookBloc(this._getBookUseCase)
      : super(const BookInitial(
          books: [],
        )) {
    on<GetBooks>(_onLoadBooks);
    on<GetMoreBooks>(_onLoadMoreBooks);
  }

  Future<void> _onLoadBooks(GetBooks event, Emitter<BookState> emit) async {
    emit(const BookLoading());
    final result = await _getBookUseCase(event.params);
    result.fold(
      (failure) => emit(BookError(
        books: const [],
        failure: failure,
      )),
      (bookResponse) => emit(
        BookLoaded(
          count: bookResponse.count,
          next: bookResponse.next,
          previous: bookResponse.previous,
          currentCount: (bookResponse.books ?? []).length,
          books: bookResponse.books,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreBooks(
      GetMoreBooks event, Emitter<BookState> emit) async {
    final currentState = state;
    int currentCount = (currentState.books ?? []).length;
    if (currentState is BookLoaded) {
      emit(BookLoadingMore(books: currentState.books));
      final result =
          await _getBookUseCase(FilterBookParams(pageUrl: event.nextPageUrl));
      result.fold(
        (failure) => emit(BookError(
          books: currentState.books,
          failure: failure,
        )),
        (bookResponse) {
          if (bookResponse.count != 0) {
            emit(
              BookLoaded(
                count: bookResponse.count,
                next: bookResponse.next,
                previous: bookResponse.previous,
                currentCount: currentCount + (bookResponse.books ?? []).length,
                books: (currentState.books ?? []) + (bookResponse.books ?? []),
              ),
            );
          }
        },
      );
    }
  }
}
