import 'package:flutter/material.dart';

class OverflowText extends StatefulWidget {
  const OverflowText({
    super.key,
    required this.text,
    required this.maxLength,
  });

  final String text;
  final int maxLength;

  @override
  State<OverflowText> createState() => _OverflowTextState();
}

class _OverflowTextState extends State<OverflowText> {
  bool _isTextOverflow = false;
  bool _isMore = false;

  @override
  void initState() {
    super.initState();
    _isTextOverflow = widget.text.length > widget.maxLength;
    _isMore = !_isTextOverflow;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: _isTextOverflow && !_isMore ? 10 : null,
          overflow: _isTextOverflow && !_isMore
              ? TextOverflow.ellipsis
              : TextOverflow.visible,
        ),
        _isTextOverflow && !_isMore
            ? Container(
                margin: const EdgeInsets.only(top: 20),
                width: 80,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isMore = true;
                    });
                  },
                  child: Container(child: const Text('aa'))
                ),
              )
            : Container(),
      ],
    );
  }
}