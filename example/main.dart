import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nps_plugin/nps_plugin.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NPS Plugin',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          child: const Text('Show NPS'),
          onPressed: () async {
            final response = await npsStart(
              context,
              npsTitle: 'So far, how likely are you to recommend the ',
              owner: 'Flutter',
              feedbackTitle: 'Leave your feedback',
              showInputPhone: false,
            );
            if (response == null) return;
            log(response.toString());
          },
        ),
      ),
    );
  }
}
