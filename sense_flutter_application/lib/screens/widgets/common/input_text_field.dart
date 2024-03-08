import 'package:flutter/material.dart';
import '../../../utils/color_scheme.dart';

class InputTextField extends StatelessWidget {
  final String label;
  final Function(String) onChanged;
  final bool isObscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String placeholder;
  final String ?errorMessage;
  final double height;
  final FormFieldValidator<String>? validator;

  const InputTextField({
    super.key, 
    required this.label,
    required this.onChanged,
    required this.controller,
    this.placeholder = '',
    this.isObscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMessage,
    this.validator,
    this.height = 40,
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
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              // TextFormField Container
              Container(
                height: height,
                padding: const EdgeInsets.only(left: 16, right: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(
                    color: (errorMessage != null ? errorColor[10]! : Colors.transparent),
                    width: 1,
                  ),
                ),
                // Input Text Field
                child: TextFormField(
                  controller: controller,
                  obscureText: isObscure,
                  obscuringCharacter: '●',
                  onChanged: onChanged,
                  validator: validator,
                  decoration: InputDecoration.collapsed(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: placeholder,
                    filled: false,
                    
                  ),
                )
              ),
            ],
          ),
        ),
        if(errorMessage != null) Container(
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