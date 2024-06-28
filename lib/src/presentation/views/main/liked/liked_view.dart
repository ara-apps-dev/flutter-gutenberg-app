import 'package:flutter/material.dart';

class LikedView extends StatefulWidget {
  const LikedView({super.key});

  @override
  State<LikedView> createState() => _LikedViewState();
}

class _LikedViewState extends State<LikedView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Liked"),
    );
  }
}
