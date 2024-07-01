import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constant/colors.dart';

class AlertCard extends StatelessWidget {
  final String image;
  final String? message;
  final Function()? onClick;
  const AlertCard({
    super.key,
    required this.image,
    this.message,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        if (message != null)
          Center(
            child: Text(message!),
          ),
        if (onClick != null)
          IconButton(
            onPressed: onClick,
            icon: const FaIcon(
              FontAwesomeIcons.arrowsRotate,
              color: kBlackColor,
              size: 20,
            ),
          ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }
}
