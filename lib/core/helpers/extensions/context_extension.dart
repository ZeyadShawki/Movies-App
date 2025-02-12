import 'package:flutter/cupertino.dart';

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild!.context == null);
  }

  void closeKeyboard() => FocusScope.of(this).requestFocus(FocusNode());
}
