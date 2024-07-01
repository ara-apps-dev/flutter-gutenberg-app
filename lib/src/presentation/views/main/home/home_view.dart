import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/src/core/constant/colors.dart';
import 'package:flutter_gutenberg_app/src/core/constant/size.dart';
import 'package:flutter_gutenberg_app/src/presentation/widgets/book_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../domain/usecase/book/get_book_usecase.dart';
import '../../../blocs/book/book_bloc.dart';
import '../../../blocs/book/book_event.dart';
import '../../../blocs/book/book_state.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../widgets/alert_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels >
        scrollController.position.maxScrollExtent - 200) {
      final state = context.read<BookBloc>().state;
      if (state is BookLoaded &&
          (state.next != null || state.next!.isNotEmpty)) {
        context.read<BookBloc>().add(GetMoreBooks(state.next!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocBuilder<BookBloc, BookState>(
                builder: (context, state) {
                  if (state is BookLoaded && (state.books ?? []).isEmpty) {
                    return _buildEmptyAlert();
                  }
                  if (state is BookError && (state.books ?? []).isEmpty) {
                    return _buildErrorAlert(state);
                  }
                  return Stack(
                    children: [
                      _buildBookGrid(state),
                      if (state is BookLoadingMore)
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: defaultRadius / 2.1,
                                horizontal: defaultRadius / 2.1,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(defaultRadius),
                                  topRight: Radius.circular(defaultRadius),
                                ),
                                color: kPrimaryColor37,
                              ),
                              child: const SizedBox(
                                width: defaultRadius,
                                height: defaultRadius,
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                  strokeWidth: defaultRadius / 6,
                                  backgroundColor: kTransparentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (state is! BookLoadingMore)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: defaultRadius / 4,
                                horizontal: defaultRadius / 1.5,
                              ),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(defaultRadius),
                                  topRight: Radius.circular(defaultRadius),
                                ),
                                color: kPrimaryColor37,
                              ),
                              child: Text(
                                'Show ${state.currentCount ?? 0} of ${state.count ?? 0}',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
        MediaQuery.of(context).padding.top + defaultMargin,
      ),
      child: AppBar(
        title: Text(
          'Gutenberg App',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: Platform.isIOS ? 120 : 100,
              bottom: defaultMargin * 0.7,
              left: defaultMargin,
              right: defaultMargin),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: BlocBuilder<FilterCubit, FilterBookParams>(
                    builder: (context, state) {
                      return _buildSearchField(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      focusNode: _focusNode,
      autofocus: false,
      controller: context.read<FilterCubit>().searchController,
      onChanged: (val) {
        context.read<FilterCubit>().update(pageUrl: null, search: val);
      },
      onSubmitted: (val) {
        final filter = FilterBookParams(pageUrl: null, search: val);
        context.read<BookBloc>().add(GetBooks(filter));
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
        suffixIcon: _buildSearchIcon(context),
        border: const OutlineInputBorder(),
        hintText: "Search Book",
        fillColor: kBackgroundColor,
        filled: true,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kTransparentColor, width: 0),
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
          borderSide: const BorderSide(color: kTransparentColor, width: 0),
        ),
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (context.read<FilterCubit>().searchController.text.isNotEmpty) {
          context.read<FilterCubit>().searchController.clear();
          if (_isFocused) {
            context.read<FilterCubit>().reset();
            context.read<BookBloc>().add(const GetBooks(FilterBookParams()));
          } else {
            context.read<FilterCubit>().update();
          }
        } else {
          context.read<FilterCubit>().update();
        }
      },
      icon: BlocBuilder<FilterCubit, FilterBookParams>(
        builder: (context, state) {
          return Icon(
            (state.search ?? '').isNotEmpty
                ? FontAwesomeIcons.xmark
                : FontAwesomeIcons.magnifyingGlass,
            color: kBlackColor,
            size: 20,
          );
        },
      ),
    );
  }

  Widget _buildEmptyAlert() {
    return const Center(
      child: AlertCard(
        image: kEmpty,
        message: "Books not found!",
      ),
    );
  }

  Widget _buildErrorAlert(BookError state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state.failure is NetworkFailure)
          AlertCard(
            image: kNoConnection,
            message: "Network failure\nTry again!",
            onClick: () {
              context.read<BookBloc>().add(GetBooks(FilterBookParams(
                  search: context.read<FilterCubit>().searchController.text)));
            },
          ),
        if (state.failure is ServerFailure) Image.asset(kInternalServerError),
        if (state.failure is CacheFailure) Image.asset(kNoConnection),
        const Center(child: Text("Books not found!")),
        IconButton(
          onPressed: () {
            context.read<BookBloc>().add(GetBooks(FilterBookParams(
                search: context.read<FilterCubit>().searchController.text)));
          },
          icon: const Icon(Icons.refresh),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      ],
    );
  }

  Widget _buildBookGrid(BookState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FilterCubit>().searchController.clear();
        context.read<BookBloc>().add(const GetBooks(FilterBookParams()));
      },
      child: Scrollbar(
        controller: scrollController,
        radius: Radius.circular(defaultRadius),
        child: GridView.custom(
          padding: EdgeInsets.only(
            top: defaultMargin,
            left: defaultMargin / 2,
            right: defaultMargin / 2,
            bottom: (defaultMargin + MediaQuery.of(context).padding.bottom),
          ),
          gridDelegate: SliverStairedGridDelegate(
            startCrossAxisDirectionReversed: false,
            crossAxisSpacing: defaultMargin,
            tileBottomSpace: defaultMargin,
            mainAxisSpacing: defaultMargin / 2,
            pattern: const [
              StairedGridTile(0.5, 0.77),
              StairedGridTile(0.5, 0.77),
            ],
          ),
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < (state.books ?? []).length) {
                return Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 240,
                  color: kTransparentColor,
                  child: BookCard(book: (state.books ?? [])[index]),
                );
              } else if ((state.books ?? []).isEmpty) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.white,
                  child: const BookCard(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            childCount:
                (state.books ?? []).length + (state is BookLoading ? 10 : 0),
          ),
        ),
      ),
    );
  }
}
