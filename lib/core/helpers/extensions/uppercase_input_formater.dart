import 'package:flutter/services.dart';

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text.toLowerCase();
    return TextEditingValue(
      text: toTitleCase(newText),
      selection: newValue.selection,
    );
  }

  String toTitleCase(String text) {
    final List<String> words = text.split(' ');

    final List<String> capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word;
      }
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).toList();

    return capitalizedWords.join(' ');
  }
}
