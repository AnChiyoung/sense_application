import 'package:flutter/material.dart';
import 'package:sense_flutter_application/apis/post/post_api.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class CommentTextArea extends StatefulWidget {
  final Null Function(String) onSend;
  final Function? onCancel;
  final bool cancelButton;
  const CommentTextArea(
      {super.key, required this.onSend, this.onCancel, this.cancelButton = false});

  @override
  State<CommentTextArea> createState() => _CommentTextAreaState();
}

class _CommentTextAreaState extends State<CommentTextArea> {
  final TextEditingController _textEditingController = TextEditingController();
  int _characterCount = 0;
  final int _maxCharacterLimit = 2000;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _updateCharacterCount(String value) {
    setState(() {
      _characterCount = value.length;
    });
  }

  void _sendComment() {
    String comment = _textEditingController.text;
    widget.onSend(comment);
    setState(() {
      _textEditingController.clear();
      _characterCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(12),
            height: 136,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 72,
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$_characterCount/$_maxCharacterLimit',
                        style: const TextStyle(color: Color(0xffBBBBBB), fontSize: 14),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (widget.cancelButton)
                        CustomButton(
                            onPressed: () {
                              widget.onCancel?.call();
                            },
                            height: 32,
                            backgroundColor: const Color(0xFFF6F6F6),
                            textColor: const Color(0xFF555555),
                            labelText: '취소'),
                      const SizedBox(width: 8),
                      CustomButton(
                          onPressed: () {
                            if (_characterCount > 0) _sendComment();
                          },
                          height: 32,
                          backgroundColor: _characterCount > 0
                              ? primaryColor[50] ?? Colors.black
                              : const Color(0xFFBBBBBB),
                          textColor: Colors.white,
                          labelText: '등록'),
                    ])
              ],
            )),
      ],
    );
  }
}
