import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/feed/report_model.dart';
import 'package:sense_flutter_application/public_widget/report_finish.dart';

class ReportDialog extends StatefulWidget {
  int? index;
  ReportDialog({Key? key, this.index}) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {

  int selectReportIndex = 0;
  List<bool> selectType = [false, false, false, false, false];
  TextEditingController reportDescription = TextEditingController();

  void dialogCallback() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.all(0.0),
      contentPadding: const EdgeInsets.all(0.0),
      content: Builder(
        builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text('신고하기', style: TextStyle(fontSize: 16, color: StaticColor.black90015, fontWeight: FontWeight.w500))
                ),
                Container(
                    height: 1,
                    color: StaticColor.grey300E0
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('사유를 선택해주세요', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 0;
                            selectType[0] = !selectType[0];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[0] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('욕설/비방', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 1;
                            selectType[1] = !selectType[1];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[1] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('홍보/불법광고', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 2;
                            selectType[2] = !selectType[2];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[2] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('음란물/선정적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 3;
                            selectType[3] = !selectType[3];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[3] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('정치적인 게시물', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectReportIndex = 4;
                            selectType[4] = !selectType[4];
                          });
                        },
                        child: Row(
                          children: [
                            selectType[4] == false ? Image.asset('assets/feed/report_checkbox_empty.png', width: 20, height: 20) : Image.asset('assets/feed/report_checkbox_fill.png', width: 20, height: 20),
                            const SizedBox(width: 8),
                            Text('기타', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('상세내용을 입력하세요', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: TextFormField(
                          autofocus: false,
                          maxLength: 90,
                          controller: reportDescription,
                          textInputAction: TextInputAction.next,
                          maxLines: 100,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: '내용을 입력해 주세요',
                            hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: StaticColor.textFormFieldFillColor,
                            alignLabelWithHint: true,
                            errorText: null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)), elevation: 0.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 40, child: Center(child: Text('취소하기', style: TextStyle(fontSize: 14, color: StaticColor.grey70055, fontWeight: FontWeight.w700)))),
                                      ]
                                  )
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    List<int> sendReportIndex = [];
                                    bool reportRequestResult = false;
                                    selectType.contains(true) == true ?
                                    {
                                      List.generate(selectType.length, (index) => selectType.elementAt(index) == true ? sendReportIndex.add(index) : {}),
                                      reportRequestResult = await ReportRequest().reportRequest(sendReportIndex, reportDescription.text ?? '', widget.index!),
                                      if(reportRequestResult == true) {
                                        Navigator.of(context).pop(),
                                        showDialog(
                                            context: context,
                                            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return ReportFinish(reportRequest: true);
                                            }
                                        ),
                                      }
                                      else {
                                        Navigator.of(context).pop(),
                                        showDialog(
                                            context: context,
                                            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return ReportFinish(reportRequest: false);
                                            }
                                        ),
                                      }
                                    } : {};
                                    print(sendReportIndex);
                                    // Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(backgroundColor: selectType.contains(true) == true ? StaticColor.mainSoft : StaticColor.grey400BB, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)), elevation: 0.0),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 40, child: Center(child: Text('신고하기', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)))),
                                      ]
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}