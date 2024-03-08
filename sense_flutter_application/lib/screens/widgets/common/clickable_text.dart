import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  const ClickableText({
    super.key,
    this.onTap,
    required this.text,
    this.fontSize = 14,
    this.textColor = const Color(0XFFBBBBBB),
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: SizedBox(
        height: 35,
        child: Align(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0XFF555555),
                  width: 0.5,
                ),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}