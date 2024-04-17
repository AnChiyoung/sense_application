import 'package:flutter/material.dart';

class TextArea extends StatefulWidget {
  final Null Function(String) onChanged;
  const TextArea({super.key, required this.onChanged});

  @override
  State<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends State<TextArea> {
  final TextEditingController _textEditingController = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacterLimit = 90;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateCharacterCount(String value) {
    widget.onChanged(value);
    setState(() {
      _characterCount = value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          height: 89,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  onChanged: _updateCharacterCount,
                  maxLength: _maxCharacterLimit,
                  maxLines: null,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Color(0xFFBBBBBB), fontSize: 14),
                      hintText: '댓글을 작성해 주세요',
                      border: InputBorder.none,
                      counterText: ''),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  text: '$_characterCount',
                  style: const TextStyle(
                    color: Color(0xFF151515),
                  ),
                  children: [
                    TextSpan(
                        text: '/$_maxCharacterLimit',
                        style: const TextStyle(
                          color: Color(0xFFBBBBBB),
                        ))
                  ],
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ])
      ],
    );
  }
}
