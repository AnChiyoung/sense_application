import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/color_scheme.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool isObscure;
  final Widget  ?prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController ?controller;
  final String placeholder;
  final String ?errorMessage;
  final double height;
  final FormFieldValidator<String>? validator;
  final TextStyle labelStyle;
  final Widget ?append;
  final List<TextInputFormatter> ?mask;
  final String ?initialValue;

  const InputTextField({
    super.key, 
    required this.label,
    required this.onChanged,
    this.controller,
    this.placeholder = '',
    this.isObscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMessage = '',
    this.initialValue,
    this.mask,
    this.validator,
    this.append,
    this.height = 40,
    this.labelStyle = 
      const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0XFF555555),
      ),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          width: double.infinity,
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: labelStyle,
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              // TextFormField Container
              Row(
                children: [
                  Expanded(
                    child: 
                      Container(
                        height: height,
                        padding: const EdgeInsets.only(left: 16, right: 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0XFFF6F6F6),
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(
                            color: (errorMessage != null && (errorMessage ?? '').isNotEmpty ? errorColor[10]! : Colors.transparent),
                            width: 1,
                          ),
                        ),
                        // Input Text Field
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                TextFormField(
                                  initialValue: initialValue,
                                  controller: controller,
                                  obscureText: isObscure,
                                  obscuringCharacter: '●',
                                  onChanged: onChanged,
                                  validator: validator,
                                  inputFormatters: mask,
                                  decoration: InputDecoration.collapsed(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    hintText: placeholder,
                                    filled: false,
                                    hintStyle: const TextStyle(color: Color(0XFFBBBBBB)),
                                  ),
                                )
                            ),
                            if (suffixIcon != null) suffixIcon!,
                          ]
                        )
                      ),
                  ),
                  if (append != null) const SizedBox(width: 8), 
                  if (append != null) append!,
                ],
              )
            ],
          ),
        ),
        if((errorMessage ?? '').isNotEmpty) Container(
          padding: const EdgeInsets.only(top: 4),
          alignment: Alignment.centerLeft,
          child: Text(
            '$errorMessage',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: errorColor[10],
              fontSize: 12,
            ),
          )
        )
      ],
    );
  }
}