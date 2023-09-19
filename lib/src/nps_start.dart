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

Future<NPSOutput> npsStart(
  BuildContext context, {
  required Text npsTitle,
  String? feedbackTitle,
  bool showInputPhone = true,
  String? npsUnlikelyLabel,
  String? npsVeryLikelyLabel,
  String? buttonLabel,
  String? feedbackHintLabel,
  String? phoneHintLabel,
}) async {
  final isDesktop = MediaQuery.sizeOf(context).width > 800;

  final response = await showModalBottomSheet<NPSOutput>(
    context: context,
    useSafeArea: true,
    isDismissible: false,
    backgroundColor: Theme.of(context).cardColor,
    enableDrag: false,
    constraints: BoxConstraints(
      maxHeight: isDesktop ? 200 : 300,
    ),
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

  if (response == null) return (nps: -1, message: '', phone: '');
  return response;
}
