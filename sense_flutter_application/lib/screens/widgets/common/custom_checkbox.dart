import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatefulWidget {
  final String label;
  final String checkedIconPath;
  final String uncheckedIconPath;
  final bool isChecked;
  final VoidCallback? onChanged;

  const CustomCheckbox({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
    this.checkedIconPath = 'lib/assets/images/svg/circle-checked_filled.svg',
    this.uncheckedIconPath = 'lib/assets/images/svg/circle_checked.svg',
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
              SvgPicture.asset(widget.isChecked ? widget.checkedIconPath : widget.uncheckedIconPath, width: 20, height: 20),
              const SizedBox(width: 8),
              Text(
                widget.label,
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