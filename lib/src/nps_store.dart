import 'package:flutter/material.dart';

class NpsStore extends ChangeNotifier {
  late final PageController pageController;

  late int _nps;
  late String _feedback;
  late String _phone;

  NpsStore() {
    pageController = PageController();
    _nps = -1;
    _feedback = '';
    _phone = '';
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int get currentNPS => _nps;
  String get feedback => _feedback;
  String get phone => _phone;

  void jumpToNextPage(int newNPS) {
    _nps = newNPS;
    notifyListeners();
    if (newNPS < 0) return;
    pageController.jumpToPage(1);
  }

  void jumpToPreviusPage() {
    pageController.jumpToPage(0);
  }

  void feedbackChanged(String value) {
    _feedback = value;
  }

  void phoneChanged(String value) {
    _phone = value;
  }

  @override
  String toString() {
    return 'NpsSotre(nps: $_nps, feedback: $_feedback, phone: $_phone)';
  }
}
