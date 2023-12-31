import 'package:flutter/material.dart';

class ListNPSWidget extends StatelessWidget {
  final int npsSelected;
  final void Function(int) nextPageWithNPS;
  final String? npsUnlikelyLabel;
  final String? npsVeryLikelyLabel;

  const ListNPSWidget({
    super.key,
    required this.npsSelected,
    required this.nextPageWithNPS,
    this.npsUnlikelyLabel,
    this.npsVeryLikelyLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: List.generate(
              11,
              (nps) {
                final isSelected = nps <= npsSelected;
                final primaryColor = Theme.of(context).colorScheme.primary;
                final cardColor = Theme.of(context).cardColor;

                return ChoiceChip(
                  selected: isSelected,
                  elevation: 4,
                  showCheckmark: false,
                  backgroundColor: cardColor,
                  selectedColor: primaryColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: primaryColor),
                  ),
                  labelPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  onSelected: (value) {
                    if (value || (!value && nps < npsSelected)) {
                      nextPageWithNPS(nps);
                    } else {
                      nextPageWithNPS(-1);
                    }
                  },
                  label: Text(
                    '$nps',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: isSelected ? cardColor : primaryColor,
                        ),
                  ),
                );
              },
            )
              ..insert(
                0,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(npsUnlikelyLabel ?? 'Unlikely'),
                    const SizedBox(width: 10),
                  ],
                ),
              )
              ..insert(
                12,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    Text(npsVeryLikelyLabel ?? 'Very likely'),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
