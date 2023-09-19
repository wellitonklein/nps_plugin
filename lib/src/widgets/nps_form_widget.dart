import 'package:flutter/material.dart';

import 'nps/nps.dart';
import 'title_widget.dart';

class NPSFormWidget extends StatelessWidget {
  final Text npsTitle;
  final int currentNPS;
  final void Function(int) nextPageWithNPS;
  final String? npsUnlikelyLabel;
  final String? npsVeryLikelyLabel;

  const NPSFormWidget({
    super.key,
    required this.currentNPS,
    required this.npsTitle,
    required this.nextPageWithNPS,
    this.npsUnlikelyLabel,
    this.npsVeryLikelyLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(previusPage: null),
                npsTitle,
                const SizedBox(height: 20),
                ListNPSWidget(
                  npsSelected: currentNPS,
                  nextPageWithNPS: nextPageWithNPS,
                  npsUnlikelyLabel: npsUnlikelyLabel,
                  npsVeryLikelyLabel: npsVeryLikelyLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
