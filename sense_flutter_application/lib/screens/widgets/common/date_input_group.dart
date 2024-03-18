// ignore_for_file: no_leading_underscores_for_local_identifiers

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
  final String ?initialValue;

  const DateInputGroup({
    super.key,
    required this.label,
    required this.onChanged,
    this.errorMessage,
    this.initialValue,
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
  late String dateOfBirth = '';
  
  // late String ?date = null;

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      dateOfBirth = widget.initialValue ?? '';
    }

    List dateOfBirthSplit = (dateOfBirth.isEmpty ? '---' : dateOfBirth).split('-');
    String _year = dateOfBirthSplit.elementAt(0);
    String _month = dateOfBirthSplit.elementAt(1);
    String _day = dateOfBirthSplit.elementAt(2);


    

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
                        initialValue: _year,
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
                        initialValue: _month,
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
                        initialValue: _day,
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

class DateInput extends StatefulWidget {

  final List<TextInputFormatter> mask;
  final String label;
  final ValueChanged<String> onChanged;
  final bool hasError;
  final String ?initialValue;
  

  const DateInput({
    super.key, 
    required this.label,
    required this.onChanged,
    required this.mask,
    this.initialValue,
    this.hasError = false
  });

  @override
  State<DateInput> createState() => _DateInput();
}

class _DateInput extends State<DateInput> {

  @override
  void dispose() {
    // TODO: implement dispose
    print(widget.initialValue);
    super.dispose();
  }

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
            color: (widget.hasError ? errorColor[10]! : Colors.transparent),
            width: 1,
          ),
        ),
        child: 
          TextFormField(
            inputFormatters: widget.mask,
            initialValue: widget.initialValue,
            decoration: InputDecoration.collapsed(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: widget.label,
              filled: false,
              hintStyle: const TextStyle(color: Color(0XFFBBBBBB)),
            ),
            onChanged: widget.onChanged,
          ),
      );
  }
}