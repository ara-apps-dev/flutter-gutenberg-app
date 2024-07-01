import 'package:bloc/bloc.dart';
import '../../../domain/usecase/book/get_book_detail_usecase.dart';
import 'book_detail_event.dart';
import 'book_detail_state.dart';

class BookDetailBloc extends Bloc<BookDetailEvent, BookDetailState> {
  final GetBookDetailUseCase? getBookDetailUseCase;

  BookDetailBloc(
    this.getBookDetailUseCase,
  ) : super(BookDetailInitial()) {
    on<GetBookDetail>(_onGetBookDetail);
  }

  void _onGetBookDetail(
      GetBookDetail event, Emitter<BookDetailState> emit) async {
    emit(BookDetailLoading());
    final result = await getBookDetailUseCase!(event.bookId);
    result.fold((failure) {
      emit(BookDetailError(failure));
    }, (bookDetail) {
      emit(BookDetailLoaded(
        id: bookDetail.id,
        title: bookDetail.title,
        authors: bookDetail.authors,
        translators: bookDetail.translators,
        subjects: bookDetail.subjects,
        bookshelves: bookDetail.bookshelves,
        languages: bookDetail.languages,
        copyright: bookDetail.copyright,
        mediaType: bookDetail.mediaType,
        formats: bookDetail.formats,
        downloadCount: bookDetail.downloadCount,
      ));
    });
  }
}
