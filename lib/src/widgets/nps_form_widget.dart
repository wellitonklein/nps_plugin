import 'package:flutter/material.dart';

import 'nps/nps.dart';
import 'title_widget.dart';

class NPSFormWidget extends StatelessWidget {
  final String owner;
  final String npsTitle;
  final int currentNPS;
  final void Function(int) nextPageWithNPS;

  const NPSFormWidget({
    super.key,
    required this.currentNPS,
    required this.nextPageWithNPS,
    required this.npsTitle,
    required this.owner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Column(
        children: [
          const TitleWidget(previusPage: null),
          SubtitleNPSWidget(npsTitle: npsTitle, owner: owner),
          const SizedBox(height: 20),
          ListNPSWidget(
            npsSelected: currentNPS,
            nextPageWithNPS: nextPageWithNPS,
          ),
        ],
      ),
    );
  }
}
