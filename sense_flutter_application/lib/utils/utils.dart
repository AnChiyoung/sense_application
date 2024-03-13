
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

void showSnackBar(BuildContext context, String message, {IconData icon = Icons.done, Color ?iconColor}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor ?? primaryColor[50],
            size: 20
          ),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(
              color: primaryColor[50],
              fontSize: 14,
              fontWeight: FontWeight.w700
            )
          )
        ],
      ),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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