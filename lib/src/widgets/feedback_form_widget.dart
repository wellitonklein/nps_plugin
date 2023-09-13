import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';
import 'feedback/feedback.dart';
import 'title_widget.dart';

class FeedbackFormWidget extends StatefulWidget {
  final String feedbackTitle;
  final VoidCallback previusPage;
  final VoidCallback sendNPS;
  final void Function(String value) onChangeFeedback;
  final void Function(String value) onChangePhone;
  final bool showInputPhone;
  final String? buttonLabel;
  final String? feedbackHintLabel;

  const FeedbackFormWidget({
    super.key,
    required this.feedbackTitle,
    required this.previusPage,
    required this.sendNPS,
    required this.onChangeFeedback,
    required this.onChangePhone,
    this.showInputPhone = true,
    this.buttonLabel,
    this.feedbackHintLabel,
  });

  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          TitleWidget(previusPage: widget.previusPage),
          SubtitleFeedbackWidget(feedbackTitle: widget.feedbackTitle),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1024,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: widget.feedbackHintLabel ??
                            '(Optional) Leave feedback on what we can improve',
                        border: const OutlineInputBorder(),
                        counter: const SizedBox.shrink(),
                        filled: true,
                      ),
                      onChanged: widget.onChangeFeedback,
                      maxLines: 2,
                      maxLength: 80,
                    ),
                  ),
                  const SizedBox(width: 15),
                  if (widget.showInputPhone) ...[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          hintText: '(Opcional)',
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) {
                          widget.onChangePhone(
                            value.replaceAll(RegExp(r'[^0-9]'), ''),
                          );
                        },
                        validator: (value) {
                          final newValue = value?.replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );
                          if (newValue == null) return null;
                          if (newValue.isEmpty) return null;
                          if (newValue.length < 10) {
                            return 'Telefone inválido';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneInputFormatter(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        if (widget.showInputPhone &&
                            !formKey.currentState!.validate()) {
                          return;
                        }
                        widget.sendNPS();
                      },
                      style: const ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(
                          Size.fromHeight(50),
                        ),
                      ),
                      child: Text(widget.buttonLabel ?? 'To send'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
