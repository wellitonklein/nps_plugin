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
  required String owner,
  required String npsTitle,
  required String feedbackTitle,
  bool showInputPhone = true,
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
        owner: owner,
        feedbackTitle: feedbackTitle,
        showInputPhone: showInputPhone,
      );
    },
  );
}
