import 'package:flutter/material.dart';

import 'nps_page.dart';

typedef NPSOutput = ({
  int nps,
  String message,
  String phone,
});

/// [owner] - Nome do sistema ou empresa
///
/// [npsTitle] - Descrição que irá aparecer na avaliação
///
/// [feedbackTitle] - Descrição que irá aparecer no feedback

Future<NPSOutput?> npsStart(
  BuildContext context, {
  required Text npsTitle,
  required String feedbackTitle,
  bool showInputPhone = true,
  String? npsUnlikelyLabel,
  String? npsVeryLikelyLabel,
  String? buttonLabel,
  String? feedbackHintLabel,
  String? phoneHintLabel,
}) {
  return showModalBottomSheet<NPSOutput>(
    context: context,
    useSafeArea: true,
    isDismissible: false,
    backgroundColor: Theme.of(context).cardColor,
    enableDrag: false,
    constraints: const BoxConstraints(maxHeight: 200),
    builder: (context) {
      return NPSPage(
        npsTitle: npsTitle,
        feedbackTitle: feedbackTitle,
        showInputPhone: showInputPhone,
        npsUnlikelyLabel: npsUnlikelyLabel,
        npsVeryLikelyLabel: npsVeryLikelyLabel,
        buttonLabel: buttonLabel,
        feedbackHintLabel: feedbackHintLabel,
        phoneHintLabel: phoneHintLabel,
      );
    },
  );
}
