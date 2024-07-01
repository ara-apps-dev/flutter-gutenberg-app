import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constant/colors.dart';
import '../../../../core/constant/size.dart';
import '../../../../domain/usecase/book/get_book_usecase.dart';
import '../../../blocs/book/book_bloc.dart';
import '../../../blocs/book/book_event.dart';
import '../../../blocs/filter/filter_cubit.dart';

class LikedView extends StatefulWidget {
  const LikedView({super.key});

  @override
  State<LikedView> createState() => _LikedViewState();
}

class _LikedViewState extends State<LikedView> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  void _focusListener() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAppBar(context),
          const Expanded(
            child: SizedBox(),
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
          'Liked Books',
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
}
