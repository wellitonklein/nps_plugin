import 'package:flutter/material.dart';

class SubtitleNPSWidget extends StatelessWidget {
  final String owner;
  final String npsTitle;

  const SubtitleNPSWidget({
    Key? key,
    required this.owner,
    required this.npsTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: npsTitle,
        children: [
          TextSpan(
            text: owner,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const TextSpan(text: '?'),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
      maxLines: 2,
    );
  }
}
