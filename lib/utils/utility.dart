import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utility {
  // static void formatPhoneNumber(TextEditingController controller, String value) {
  //   String numericString = value.replaceAll(RegExp(r'[^0-9]'), '');

  //   String formattedString = numericString.replaceAllMapped(
  //     RegExp(r'^(\d{2,3})(\d{3,4})(\d{4})$'),
  //     (Match match) {
  //       return '${match[1]}-${match[2]}-${match[3]}';
  //     },
  //   );

  //   // Set the text of the controller and ensure the cursor is at the end of the text.
  //   controller.value = TextEditingValue(
  //     text: formattedString,
  //     selection: TextSelection.collapsed(offset: formattedString.length),
  //   );
  // }
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

class DatePicker extends StatelessWidget {
  final VoidCallback? onPressed;
  final DateTime? initialDateTime;
  final void Function(DateTime)? onDateTimeChanged;
  const DatePicker({super.key, this.onPressed, this.initialDateTime, this.onDateTimeChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onPressed,
                child: const Text('확인'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  initialDateTime: initialDateTime ?? DateTime.now(),
                  onDateTimeChanged: onDateTimeChanged ?? (date) {},
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
