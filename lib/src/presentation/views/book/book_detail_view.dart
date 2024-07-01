import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/src/core/constant/colors.dart';
import 'package:flutter_gutenberg_app/src/core/constant/size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../blocs/book_detail/book_detail_bloc.dart';
import '../../blocs/book_detail/book_detail_event.dart';
import '../../blocs/book_detail/book_detail_state.dart';

class BookDetailView extends StatefulWidget {
  final int bookId;

  const BookDetailView({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailView> createState() => _BookDetailViewState();
}

class _BookDetailViewState extends State<BookDetailView> {
  @override
  void initState() {
    super.initState();
    context.read<BookDetailBloc>().add(GetBookDetail(widget.bookId));
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url.startsWith('http') ? url : 'https:$url');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Detail'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            icon: BlocBuilder<BookDetailBloc, BookDetailState>(
              builder: (context, state) {
                return FaIcon(
                  FontAwesomeIcons.solidThumbsUp,
                  size: 20.0,
                  color: (state is BookDetailLoaded) && (state.liked ?? false)
                      ? kWhiteColor
                      : kGreyColor,
                );
              },
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<BookDetailBloc, BookDetailState>(
        builder: (context, state) {
          if (state is BookDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BookDetailLoaded) {
            final book = state;
            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<BookDetailBloc>()
                    .add(GetBookDetail(widget.bookId));
                await context
                    .read<BookDetailBloc>()
                    .stream
                    .firstWhere((state) => state is! BookDetailLoading);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ListView(
                  children: [
                    const SizedBox(height: defaultMargin * 3),
                    if (book.formats?.coverImage != null)
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.3,
                        child: Image.network(book.formats?.coverImage ?? ''),
                      ),
                    const SizedBox(height: defaultMargin),
                    Text(book.title ?? '',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: defaultMargin),
                    Text(
                        'Author(s): ${(book.authors ?? []).map((a) => a.name).join(', ')}'),
                    const SizedBox(height: defaultMargin),
                    Text('Subjects: ${(book.subjects ?? []).join(', ')}'),
                    const SizedBox(height: defaultMargin),
                    Text('Bookshelves: ${(book.bookshelves ?? []).join(', ')}'),
                    const SizedBox(height: defaultMargin),
                    Text('Languages: ${(book.languages ?? []).join(', ')}'),
                    const SizedBox(height: defaultMargin),
                    Text('Download Count: ${book.downloadCount ?? 0}'),
                    const SizedBox(height: defaultMargin),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final viewUrl = book.formats?.htmlText ??
                                book.formats?.plainTextUTF8;
                            if (viewUrl != null) {
                              _launchURL(viewUrl);
                            }
                          },
                          child: const Text('View'),
                        ),
                        const SizedBox(width: defaultMargin),
                        ElevatedButton(
                          onPressed: () {
                            final downloadUrl = book.formats?.fileZip;
                            if (downloadUrl != null) {
                              _launchURL(downloadUrl);
                            }
                          },
                          child: const Text('Download'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is BookDetailError) {
            return const Center(child: Text('Error: Unexpected State'));
          } else {
            return const Center(child: Text('Unexpected State'));
          }
        },
      ),
    );
  }
}
