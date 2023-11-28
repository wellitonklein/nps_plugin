import 'package:flutter/material.dart';

import 'nps_store.dart';
import 'widgets/widgets.dart';

class NPSPage extends StatefulWidget {
  final Text npsTitle;
  final bool showInputPhone;
  final String? feedbackTitle;
  final String? npsUnlikelyLabel;
  final String? npsVeryLikelyLabel;
  final String? buttonLabel;
  final String? feedbackHintLabel;
  final String? phoneHintLabel;

  const NPSPage({
    super.key,
    this.feedbackTitle,
    required this.npsTitle,
    this.showInputPhone = true,
    this.npsUnlikelyLabel,
    this.npsVeryLikelyLabel,
    this.buttonLabel,
    this.feedbackHintLabel,
    this.phoneHintLabel,
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

  bool isConfirmationDialogOpen = false;

  Future<void> showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: const Text(
              'Your opinion is very important! If you wish, share your comment and your phone number, as this will help us improve our services and strengthen our partnership. We sincerely thank you for your contribution!',
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                store.jumpToNextPage(store.currentNPS);
                isConfirmationDialogOpen = true;
              },
              child: const Text('Leave Comment'),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(
                  (
                    nps: store.currentNPS,
                    message: store.feedback,
                    phone: store.phone,
                  ),
                );
                Navigator.of(context).pop(
                  (
                    nps: store.currentNPS,
                    message: store.feedback,
                    phone: store.phone,
                  ),
                );
                isConfirmationDialogOpen = false;
              },
              child: const Text('To close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, snapshot) {
        void sendNPS() {
          bool isCommentEmpty = store.feedback.trim().isEmpty;
          bool isPhoneEmpty = store.phone.trim().isEmpty;

          if (isCommentEmpty &&
              isPhoneEmpty &&
              ((store.currentNPS >= 0 && store.currentNPS <= 3) ||
                  (store.currentNPS >= 9 && store.currentNPS <= 10))) {
            showConfirmationDialog();
          } else {
            Navigator.of(context).pop(
              (
                nps: store.currentNPS,
                message: store.feedback,
                phone: store.phone,
              ),
            );
          }
        }

        return PageView(
          controller: store.pageController,
          children: [
            NPSFormWidget(
              currentNPS: store.currentNPS,
              nextPageWithNPS: store.jumpToNextPage,
              npsTitle: widget.npsTitle,
              npsUnlikelyLabel: widget.npsUnlikelyLabel,
              npsVeryLikelyLabel: widget.npsVeryLikelyLabel,
            ),
            FeedbackFormWidget(
              showInputPhone: widget.showInputPhone,
              feedbackTitle: widget.feedbackTitle,
              previusPage: store.jumpToPreviusPage,
              sendNPS: sendNPS,
              onChangeFeedback: store.feedbackChanged,
              onChangePhone: store.phoneChanged,
              buttonLabel: widget.buttonLabel,
              feedbackHintLabel: widget.feedbackHintLabel,
              phoneHintLabel: widget.phoneHintLabel,
            ),
          ],
        );
      },
    );
  }
}
