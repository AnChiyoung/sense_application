import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class AnimatedElevatedButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onPressed;
  final Color? defaultColor;
  final Color? activeColor;

  const AnimatedElevatedButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.onPressed,
    this.defaultColor,
    this.activeColor,
  });

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;
  late Color defaultColor;
  late Color activeColor;

  @override
  void initState() {
    super.initState();
    defaultColor = widget.defaultColor ?? StaticColor.grey300E0;
    activeColor = widget.activeColor ?? StaticColor.mainSoft;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _backgroundColor = ColorTween(
      begin: defaultColor,
      end: activeColor,
    ).animate(_controller);

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedElevatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: _backgroundColor.value,
          ),
          onPressed: widget.onPressed,
          child: Text(widget.text),
        );
      },
    );
  }
}
