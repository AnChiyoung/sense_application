import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utility {
  static void formatPhoneNumber(TextEditingController controller, String value) {
    String numericString = value.replaceAll(RegExp(r'[^0-9]'), '');

    String formattedString = numericString.replaceAllMapped(
      RegExp(r'^(\d{2,3})(\d{3,4})(\d{4})$'),
      (Match match) {
        return '${match[1]}-${match[2]}-${match[3]}';
      },
    );

    // Set the text of the controller and ensure the cursor is at the end of the text.
    controller.value = TextEditingValue(
      text: formattedString,
      selection: TextSelection.collapsed(offset: formattedString.length),
    );
  }
}

class KoreanPhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 13) return oldValue;

    String numericString = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String formattedString = numericString.replaceAllMapped(
      RegExp(r'^(\d{2,3})(\d{3,4})(\d{4})$'),
      (Match match) {
        return '${match[1]}-${match[2]}-${match[3]}';
      },
    );

    if (formattedString.length > 13) {
      formattedString = formattedString.substring(0, 13);
    }

    return formattedString.isNotEmpty
        ? newValue.copyWith(
            text: formattedString,
            selection: TextSelection.collapsed(offset: formattedString.length),
          )
        : newValue;
  }
}
