import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';
import 'feedback/feedback.dart';
import 'title_widget.dart';

class FeedbackFormWidget extends StatefulWidget {
  final VoidCallback previusPage;
  final VoidCallback sendNPS;
  final void Function(String value) onChangeFeedback;
  final void Function(String value) onChangePhone;
  final bool showInputPhone;
  final String? feedbackTitle;
  final String? buttonLabel;
  final String? feedbackHintLabel;
  final String? phoneHintLabel;

  const FeedbackFormWidget({
    super.key,
    this.feedbackTitle,
    required this.previusPage,
    required this.sendNPS,
    required this.onChangeFeedback,
    required this.onChangePhone,
    this.showInputPhone = true,
    this.buttonLabel,
    this.feedbackHintLabel,
    this.phoneHintLabel,
  });

  @override
  State<FeedbackFormWidget> createState() => _FeedbackFormWidgetState();
}

class _FeedbackFormWidgetState extends State<FeedbackFormWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TitleWidget(previusPage: widget.previusPage),
                  if (widget.feedbackTitle != null) ...[
                    SubtitleFeedbackWidget(feedbackTitle: widget.feedbackTitle),
                  ],
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1024),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: isDesktop
                          ? _DesktopFormWidget(
                              feedbackHintLabel: widget.feedbackHintLabel,
                              onChangeFeedback: widget.onChangeFeedback,
                              phoneHintLabel: widget.phoneHintLabel,
                              onChangePhone: widget.onChangePhone,
                              formKey: formKey,
                              showInputPhone: widget.showInputPhone,
                              sendNPS: widget.sendNPS,
                              buttonLabel: widget.buttonLabel,
                            )
                          : _MobileFormWidget(
                              feedbackHintLabel: widget.feedbackHintLabel,
                              onChangeFeedback: widget.onChangeFeedback,
                              phoneHintLabel: widget.phoneHintLabel,
                              onChangePhone: widget.onChangePhone,
                              formKey: formKey,
                              showInputPhone: widget.showInputPhone,
                              sendNPS: widget.sendNPS,
                              buttonLabel: widget.buttonLabel,
                            ),
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

class _DesktopFormWidget extends StatelessWidget {
  final String? feedbackHintLabel;
  final void Function(String) onChangeFeedback;
  final String? phoneHintLabel;
  final void Function(String) onChangePhone;
  final GlobalKey<FormState> formKey;
  final bool showInputPhone;
  final void Function() sendNPS;
  final String? buttonLabel;

  const _DesktopFormWidget({
    required this.feedbackHintLabel,
    required this.onChangeFeedback,
    required this.phoneHintLabel,
    required this.onChangePhone,
    required this.formKey,
    required this.showInputPhone,
    required this.sendNPS,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _FeedbackFieldWidget(
            feedbackHintLabel: feedbackHintLabel,
            onChangeFeedback: onChangeFeedback,
          ),
        ),
        const SizedBox(width: 15),
        if (showInputPhone) ...[
          Expanded(
            child: _PhoneFieldWidget(
              phoneHintLabel: phoneHintLabel,
              onChangePhone: onChangePhone,
            ),
          ),
          const SizedBox(width: 15),
        ],
        Expanded(
          child: _SendButtonWidget(
            formKey: formKey,
            buttonLabel: buttonLabel,
            sendNPS: sendNPS,
            showInputPhone: showInputPhone,
          ),
        ),
      ],
    );
  }
}

class _MobileFormWidget extends StatelessWidget {
  final String? feedbackHintLabel;
  final void Function(String) onChangeFeedback;
  final String? phoneHintLabel;
  final void Function(String) onChangePhone;
  final GlobalKey<FormState> formKey;
  final bool showInputPhone;
  final void Function() sendNPS;
  final String? buttonLabel;

  const _MobileFormWidget({
    required this.feedbackHintLabel,
    required this.onChangeFeedback,
    required this.phoneHintLabel,
    required this.onChangePhone,
    required this.formKey,
    required this.showInputPhone,
    required this.sendNPS,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FeedbackFieldWidget(
          feedbackHintLabel: feedbackHintLabel,
          onChangeFeedback: onChangeFeedback,
        ),
        if (showInputPhone) ...[
          const SizedBox(height: 5),
          _PhoneFieldWidget(
            phoneHintLabel: phoneHintLabel,
            onChangePhone: onChangePhone,
          ),
        ],
        const SizedBox(height: 15),
        _SendButtonWidget(
          formKey: formKey,
          buttonLabel: buttonLabel,
          sendNPS: sendNPS,
          showInputPhone: showInputPhone,
        ),
      ],
    );
  }
}

class _FeedbackFieldWidget extends StatelessWidget {
  final String? feedbackHintLabel;
  final void Function(String) onChangeFeedback;

  const _FeedbackFieldWidget({
    required this.feedbackHintLabel,
    required this.onChangeFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        hintText: feedbackHintLabel ??
            '(Optional) Leave feedback on what we can improve',
        counter: const SizedBox.shrink(),
      ),
      onChanged: onChangeFeedback,
      maxLines: 2,
      maxLength: 80,
    );
  }
}

class _PhoneFieldWidget extends StatelessWidget {
  final String? phoneHintLabel;
  final void Function(String) onChangePhone;

  const _PhoneFieldWidget({
    required this.phoneHintLabel,
    required this.onChangePhone,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        filled: true,
        hintText: phoneHintLabel ?? '(Optional) Phone',
      ),
      autovalidateMode: AutovalidateMode.always,
      onChanged: (value) {
        onChangePhone(
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
    );
  }
}

class _SendButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool showInputPhone;
  final void Function() sendNPS;
  final String? buttonLabel;

  const _SendButtonWidget({
    required this.formKey,
    required this.showInputPhone,
    required this.sendNPS,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (showInputPhone && !formKey.currentState!.validate()) {
          return;
        }
        sendNPS();
      },
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(
          Size.fromHeight(50),
        ),
      ),
      child: Text(buttonLabel ?? 'To send'),
    );
  }
}
