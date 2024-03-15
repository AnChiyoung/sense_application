
// Check for the email format
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

Function debounce<T>(Function(T) callback, Duration duration) {
  Timer? timer;

  void debounceCallback(T args) {
    timer?.cancel();
    timer = Timer(duration, () {
      callback(args);
    });
  }

  return debounceCallback;
}

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return null;
  }

  final emailRegex = RegExp(r'^(?!.*\.\.)(?!^\.)[a-zA-Z0-9._%+-]+(?<!-)(?<!\.)\@[a-zA-Z0-9.-]+(?<!\.)\.[a-zA-Z]{2,}$');
  
  return emailRegex.hasMatch(email) ? null : '올바른 이메일 주소를 입력해 주세요';
}

String? dateValidator(String? date) {
  if (date == null || date.isEmpty) {
    return '';
  }

  final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  if (!dateRegex.hasMatch(date)) {
    return '올바른 날짜 형식을 입력해 주세요 (YYYY-MM-DD)';
  }

  final parts = date.split('-');
  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);

  if (year == null || month == null || day == null) {
    return '올바른 날짜 형식을 입력해 주세요 (YYYY-MM-DD)';
  }

  final now = DateTime.now();
  if (year > now.year) {
    return '년도는 현재 년도보다 클 수 없습니다';
  }

  if (month < 1 || month > 12) {
    return '월은 1부터 12 사이여야 합니다';
  }

  if (day < 1 || day > 31) {
    return '일은 1부터 31 사이여야 합니다';
  }

  // Check the number of days in the month
  final daysInMonth = DateTime(year, month + 1, 0).day;
  if (day > daysInMonth) {
    return '올바른 날짜 형식을 입력해 주세요';
  }

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return null;
  }

  final phoneRegex = RegExp(r'^\d{3}-\d{4}-\d{4}$');
  return phoneRegex.hasMatch(phone) ? null : '올바른 전화번호 형식을 입력해 주세요 (010-1234-5678)';
}

void showSnackBar(BuildContext context, String message, {IconData icon = Icons.done, Color? iconColor, Function? onDismissed}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor ?? primaryColor[50], // Assuming primaryColor[50] is similar
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          message,
          style: TextStyle(
            color: primaryColor[50], // Assuming primaryColor[50] is similar
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((reason) {
    if (reason == SnackBarClosedReason.action) {
      // 
    } else {
      // 
    }

    if (onDismissed != null) {
      onDismissed();
    }
  });
}


final phoneMask = MaskTextInputFormatter(
  mask: '###-####-####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
); 

final yearMask = MaskTextInputFormatter(
  mask: '####', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
); 

final monthMask = MaskTextInputFormatter(
  mask: '##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
); 

final dayMask = MaskTextInputFormatter(
  mask: '##', 
  filter: { "#": RegExp(r'[0-9]') },
  type: MaskAutoCompletionType.lazy
); 