import 'package:flutter/material.dart';

class BookshelfView extends StatefulWidget {
  const BookshelfView({super.key});

  @override
  State<BookshelfView> createState() => _BookshelfViewState();
}

class _BookshelfViewState extends State<BookshelfView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Bookshelf"),
    );
  }
}
