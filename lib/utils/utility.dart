import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// singleton
class Utils {
  static final Utils _instance = Utils._internal();
  Utils._internal();
  factory Utils() => _instance;

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

  String toQueryString(Map<String, dynamic>? params) {
    if (params == null || params.isEmpty) return '';

    var queryString = StringBuffer();

    // 첫 번째 쿼리 파라미터 앞에 '?'를 붙이기 위한 플래그
    bool isFirstParameter = true;

    params.forEach((key, value) {
      // 리스트는 'key=value1&key=value2'의 형식으로 변환
      if (value is List) {
        for (var listItem in value) {
          queryString.write(isFirstParameter ? '?' : '&');
          queryString.write('$key=${Uri.encodeComponent(listItem.toString())}');
          isFirstParameter = false;
        }
      } else {
        // 단일 값은 'key=value'의 형식으로 변환
        queryString.write(isFirstParameter ? '?' : '&');
        queryString.write('$key=${Uri.encodeComponent(value.toString())}');
        isFirstParameter = false;
      }
    });

    return queryString.toString();
  }

  // dynamic httpRequest(
  //   String url, {
  //   Map<String, dynamic>? params,
  //   Map<String, String>? headers,
  //   String? method,
  //   dynamic body,
  // }) async {
  //   final response = await http.request(
  //     url,
  //     method: method ?? 'GET',
  //     headers: headers ?? {},
  //     body: body,
  //   );

  //   if (response.statusCode == 200) {
  //     try {
  //       final dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
  //       return body;
  //     } catch (e) {
  //       return null;
  //     }
  //   } else {
  //     throw Exception('Failed to load preference taste spicy list');
  //   }
  // }

  List<T> addOrRemoveList<T>(List<T> list, T item) {
    List<T> ret = [...list];
    if (list.contains(item)) {
      ret.remove(item);
    } else {
      ret.add(item);
    }
    return ret;
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

class console {
  static void log(dynamic message) {
    print('oozy $message');
  }
}
