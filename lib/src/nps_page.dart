import 'package:flutter/material.dart';

import 'nps_store.dart';
import 'widgets/widgets.dart';

class NPSPage extends StatefulWidget {
  final String owner;
  final String npsTitle;
  final String feedbackTitle;
  final bool showInputPhone;

  const NPSPage({
    super.key,
    required this.owner,
    required this.feedbackTitle,
    required this.npsTitle,
    this.showInputPhone = true,
  });

  @override
  State<NPSPage> createState() => _NPSPageState();
}

class _NPSPageState extends State<NPSPage> {
  late final NpsStore store;

  @override
  void initState() {
    store = NpsStore();
    super.initState();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, snapshot) {
        void sendNPS() {
          Navigator.of(context).pop(
            (
              nps: store.currentNPS,
              message: store.feedback,
              phone: store.phone,
            ),
          );
        }

        return PageView(
          controller: store.pageController,
          children: [
            NPSFormWidget(
              currentNPS: store.currentNPS,
              nextPageWithNPS: store.jumpToNextPage,
              owner: widget.owner,
              npsTitle: widget.npsTitle,
            ),
            FeedbackFormWidget(
              showInputPhone: widget.showInputPhone,
              feedbackTitle: widget.feedbackTitle,
              previusPage: store.jumpToPreviusPage,
              sendNPS: sendNPS,
              onChangeFeedback: store.feedbackChanged,
              onChangePhone: store.phoneChanged,
            ),
          ],
        );
      },
    );
  }
}