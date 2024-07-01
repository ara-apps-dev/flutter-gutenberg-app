import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/book/author.dart';
import '../../../domain/entities/book_detail/formats.dart';
import '../../../domain/entities/book_detail/translator.dart';

abstract class BookDetailState extends Equatable {
  final int? id;
  final String? title;
  final List<Author>? authors;
  final List<Translator>? translators;
  final List<String>? subjects;
  final List<String>? bookshelves;
  final List<String>? languages;
  final bool? copyright;
  final String? mediaType;
  final Formats? formats;
  final int? downloadCount;
  final bool? liked;

  const BookDetailState({
    this.id,
    this.title,
    this.authors,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
    this.liked,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        translators,
        subjects,
        bookshelves,
        languages,
        copyright,
        mediaType,
        formats,
        downloadCount,
        liked,
      ];
}

class BookDetailInitial extends BookDetailState {}

class BookDetailLoading extends BookDetailState {}

class BookDetailLoaded extends BookDetailState {
  const BookDetailLoaded({
    super.id,
    super.title,
    super.authors,
    super.translators,
    super.subjects,
    super.bookshelves,
    super.languages,
    super.copyright,
    super.mediaType,
    super.formats,
    super.downloadCount,
    super.liked,
  });
}

class BookDetailError extends BookDetailState {
  final Failure failure;

  const BookDetailError(this.failure);

  @override
  List<Object?> get props => [failure];
}
