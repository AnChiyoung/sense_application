import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final String iconPath;
  final double iconSize;
  final double spacing;
  final TextStyle? textStyle;
  final Color iconColor = const Color(0xFFBBBBBB);

  const TextIcon(
      {super.key,
      required this.text,
      this.iconSize = 24.0,
      this.spacing = 8.0,
      required this.iconPath,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: iconSize,
          height: iconSize,
          color: iconColor,
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle,
        ),
      ],
    );
  }
}
