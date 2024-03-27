import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatefulWidget {
  final String ?label;
  final String checkedIconPath;
  final String uncheckedIconPath;
  final bool isChecked;
  final VoidCallback? onChanged;
  final Widget ?child;

  const CustomCheckbox({
    super.key,
    this.label = '',
    required this.isChecked,
    required this.onChanged,
    this.child,
    this.checkedIconPath = 'lib/assets/images/icons/svg/circle-checked_filled.svg',
    this.uncheckedIconPath = 'lib/assets/images/icons/svg/circle_checked.svg',
  });

  @override
  State<CustomCheckbox>createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: widget.onChanged,
        child: SizedBox(
          height: 35,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(widget.isChecked ? widget.checkedIconPath : widget.uncheckedIconPath, width: 24, height: 24),
              const SizedBox(width: 8),
              
              widget.child != null ? widget.child! : Text(
                widget.label!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0XFF555555),
                  fontWeight: FontWeight.w400
                )
              ),
            ],
          ),
        ),
      );
  }
}