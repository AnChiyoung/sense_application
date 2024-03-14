import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class DateInputGroup extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final TextStyle labelStyle;
  final String ?errorMessage;
  final double height;

  const DateInputGroup({
    super.key,
    required this.label,
    required this.onChanged,
    this.errorMessage,
    this.labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Color(0XFF555555),
    ),
    this.height = 40,
  });
  
  @override
  State<DateInputGroup> createState() => _DateInputGroupState();
}

class _DateInputGroupState extends State<DateInputGroup> {
  late String year = '';
  late String month = '';
  late String day = '';
  // late String ?date = null;

  @override
  Widget build(BuildContext context) {

    widget.onChanged('$year-$month-$day');

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8),
          width: double.infinity,
          child: Text(
            widget.label,
            textAlign: TextAlign.start,
            style: widget.labelStyle,
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
                      DateInput(
                        label: 'YYYY',
                        onChanged: (String value) {
                          setState(() {
                            year = value;
                          });
                        },
                        mask: [yearMask],
                        hasError: (widget.errorMessage != null && (widget.errorMessage ?? '').isNotEmpty),
                    )
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: 
                      DateInput(
                        label: 'MM',
                        onChanged: (String value) {
                          setState(() {
                            month = value;
                          });
                        },
                        mask: [monthMask],
                        hasError: (widget.errorMessage != null && (widget.errorMessage ?? '').isNotEmpty),
                    )
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: 
                      DateInput(
                        label: 'DD',
                        onChanged: (String value) {
                          setState(() {
                            day = value;
                          });
                        },
                        mask: [dayMask],
                        hasError: (widget.errorMessage != null && (widget.errorMessage ?? '').isNotEmpty),
                    )
                  )
                ],
              ),
              if (widget.errorMessage != null && (widget.errorMessage ?? '').isNotEmpty)
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.errorMessage!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class DateInput extends StatelessWidget {

  final List<TextInputFormatter> mask;
  final String label;
  final ValueChanged<String> onChanged;
  final bool hasError;
  

  const DateInput({
    super.key, 
    required this.label,
    required this.onChanged,
    required this.mask,
    this.hasError = false
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 40,
        padding: const EdgeInsets.only(left: 16, right: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0XFFF6F6F6),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(
            color: (hasError ? errorColor[10]! : Colors.transparent),
            width: 1,
          ),
        ),
        child: 
          TextFormField(
            inputFormatters: mask,
            decoration: InputDecoration.collapsed(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: label,
              filled: false,
              hintStyle: const TextStyle(color: Color(0XFFBBBBBB)),
            ),
            onChanged: onChanged,
          ),
      );
  }
}