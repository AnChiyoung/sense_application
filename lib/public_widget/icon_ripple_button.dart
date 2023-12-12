import 'package:flutter/material.dart';

class IconRippleButton extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;
  final double padding;
  final VoidCallback? onPressed;

  const IconRippleButton({
    super.key,
    required this.icon,
    this.color,
    this.size = 16,
    this.padding = 4,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular((size * 0.5) + padding),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            icon,
            color: color,
            size: size,
          ),
        ),
      ),
    );
  }
}
