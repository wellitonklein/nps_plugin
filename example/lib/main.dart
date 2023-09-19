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
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
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
            final npsTitle = Text.rich(
              TextSpan(
                text: 'So far, how likely are you to recommend ',
                children: [
                  TextSpan(
                    text: 'NPS Plugin',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const TextSpan(text: ' to a friend?'),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 2,
            );

            final (:nps, :message, :phone) = await npsStart(
              context,
              npsTitle: npsTitle,
              showInputPhone: true,
            );

            log('NPS: $nps, Message: $message, Phone: $phone');
          },
        ),
      ),
    );
  }
}
