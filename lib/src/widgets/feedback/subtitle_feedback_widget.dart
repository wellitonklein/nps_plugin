import 'package:flutter/material.dart';

class SubtitleFeedbackWidget extends StatelessWidget {
  final String feedbackTitle;

  const SubtitleFeedbackWidget({
    super.key,
    required this.feedbackTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      feedbackTitle,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge,
      maxLines: 2,
    );
  }
}
