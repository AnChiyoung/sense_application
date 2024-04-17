import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/apis/comment/comment_api.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_checkbox.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_modal.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/screens/widgets/common/text_area.dart';
import 'package:sense_flutter_application/service/api_service.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class ReportModal extends StatefulWidget {
  final Color backgroundColor;
  final Border border;
  final double radius;
  final String commentId;

  final Function(bool) callback;

  const ReportModal({
    super.key,
    this.backgroundColor = Colors.white,
    this.border = const Border(),
    this.radius = 0,
    required this.commentId,
    required this.callback,
  });

  @override
  State<ReportModal> createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  List<dynamic> choices = [];
  bool isLoad = true;
  bool isReporting = false;
  String description = '';

  @override
  void initState() {
    super.initState();

    ApiService.get('report-choices').then((value) {
      var parse = json.decode(utf8.decode(value.bodyBytes));
      parse['data'].toList().forEach((element) {
        setState(() {
          choices.add({'label': element['title'], 'value': element['id'], 'selected': false});
        });
      });
      setState(() {
        isLoad = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: List.of([
                    const BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.14),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    )
                  ]),
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.radius),
                  border: widget.border),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    child: Text(
                      // Modal Title
                      '신고하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF151515),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          // Modal Sub Title
                          '사유를 선택하세요',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),

                        if (isLoad)
                          Center(
                            child: CircularProgressIndicator(
                              color: primaryColor[50],
                            ),
                          ),

                        // List of choices
                        for (var choice in choices)
                          CustomCheckbox(
                            isChecked: choice['selected'],
                            onChanged: () {
                              setState(() {
                                choice['selected'] = !choice['selected'];
                              });
                            },
                            label: choice['label'],
                          ),

                        const SizedBox(height: 16),
                        // Text Area
                        const Text(
                          // Modal Sub Title
                          '상세내용을 입력하세요',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextArea(onChanged: (value) {
                          setState(() {
                            description = value;
                          });
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child:
                                  // Modal Button Label
                                  CustomButton(
                                backgroundColor: const Color(0XFF555555),
                                textColor: const Color(0XFFFFFFFF),
                                labelText: '취소하기',
                                onPressed: () {
                                  widget.callback(false);
                                },
                              )),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                              height: 40,
                              width: double.infinity,
                              child:
                                  // Modal Button Label
                                  CustomButton(
                                backgroundColor: primaryColor[50] ?? Colors.transparent,
                                textColor: Colors.white,
                                labelText: '신고하기',
                                onPressed: () {
                                  if (isReporting) return;
                                  if (choices.where((element) => element['selected']).isNotEmpty) {
                                    setState(() {
                                      isReporting = true;
                                    });
                                    CommentApi().report(widget.commentId, {
                                      'report_choice_ids': choices
                                          .where((element) => element['selected'])
                                          .map((e) => e['value'])
                                          .toList(),
                                      'description': description,
                                    }).then((value) {
                                      widget.callback(true);
                                    }).onError((error, stackTrace) {
                                      setState(() {
                                        isReporting = false;
                                        CustomToast.errorToast(
                                            context, 'Something went wrong. Please try again.',
                                            bottom: MediaQuery.of(context).size.height * 0.1);
                                      });
                                    });
                                  } else {
                                    CustomToast.errorToast(
                                        context, 'Please select a choices to report.',
                                        bottom: MediaQuery.of(context).size.height * 0.1);
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
