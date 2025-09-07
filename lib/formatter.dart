import 'package:flutter/services.dart';

class CustomPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return textManipulation(
      oldValue: oldValue,
      newValue: newValue,
      textInputFormatter: FilteringTextInputFormatter.digitsOnly,
      formatPattern: stringEditor,
    );
  }
}

typedef Editor = String Function(String line);

String stringEditor(String stringToEdit) {
  int leftEdge = 0;
  StringBuffer buffer = StringBuffer();
  for (int i = 0; i <= stringToEdit.length; i++) {
    buffer.write(stringToEdit.substring(leftEdge, i));
    if (i == stringToEdit.length) break;
    if (i == 0) {
      buffer.write('(');
    }
    if (i == 3) {
      buffer.write(') ');
    }
    if (i == 6) {
      buffer.write('-');
    }
    leftEdge = i;
  }
  return buffer.toString();
}

TextEditingValue textManipulation({
  required TextEditingValue oldValue,
  required TextEditingValue newValue,
  required TextInputFormatter textInputFormatter,
  required Editor formatPattern,
}) {
  newValue = textInputFormatter.formatEditUpdate(oldValue, newValue);

  final newText = formatPattern(newValue.text);

  int cursorPosition = newText.length;

  return newValue.copyWith(
    text: newText,
    selection: TextSelection.collapsed(offset: cursorPosition),
  );
}
