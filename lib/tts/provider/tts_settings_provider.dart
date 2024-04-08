import 'package:flutter/material.dart';

class TtsSettingsProvider with ChangeNotifier {
  String _readingRange = 'all';
  String _voiceType = 'male';
  String _selectedText = '';

  String get readingRange => _readingRange;
  String get voiceType => _voiceType;
  String get selectedText => _selectedText;

  void setReadingRange(String range) {
    _readingRange = range;
    notifyListeners();
  }

  void setVoiceType(String type) {
    _voiceType = type;
    notifyListeners();
  }

  void setSelectedText(String text) {
    _selectedText = text;
    notifyListeners();
  }
}