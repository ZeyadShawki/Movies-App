import 'package:flutter/services.dart';

class SentenceCaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

    if (text.isNotEmpty) {
      // Keep the first letter uppercase, but do not force lowercase on the rest
      String formattedText = text[0].toUpperCase() + text.substring(1);

      return TextEditingValue(
        text: formattedText,
        selection: newValue.selection.copyWith(
          baseOffset: formattedText.length,
          extentOffset: formattedText.length,
        ),
      );
    }

    return newValue;
  }
}
