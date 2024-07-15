import 'package:flutter/material.dart';

class AllPosts extends StatelessWidget {
  final String headerText;
  final String bodyText;
  const AllPosts({super.key, required this.headerText, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(headerText),
            Text(bodyText),
          ],
        )
      ],
    );
  }
}
