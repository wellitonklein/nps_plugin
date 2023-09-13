import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final VoidCallback? previusPage;

  const TitleWidget({super.key, required this.previusPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        previusPage == null
            ? const SizedBox.shrink()
            : BackButton(onPressed: previusPage),
        CloseButton(onPressed: Navigator.of(context).pop),
      ],
    );
  }
}
