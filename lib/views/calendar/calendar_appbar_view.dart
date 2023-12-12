import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';

class CalendarAppBar extends StatefulWidget {
  const CalendarAppBar({super.key});

  @override
  State<CalendarAppBar> createState() => _CalendarAppBarState();
}

class _CalendarAppBarState extends State<CalendarAppBar> {
  List<String> monthList = [];
  String selectMonth = '';

  void monthListCreate() {
    for (int i = 1; i < 13; i++) {
      monthList.add('$i월');
    }
    selectMonth = monthList.elementAt(1);
  }

  @override
  void initState() {
    monthListCreate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Consumer<CalendarProvider>(
                  builder: (context, data, child) {
                    return Tooltip(
                      message: '길게 누를 경우, 연도와 월을 선택할 수 있습니다.',
                      child: GestureDetector(
                        onTap: () {
                          // year, month select
                          showMonthPicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year, 1),
                            lastDate: DateTime(DateTime.now().year + 5, 12),
                            initialDate: DateTime(data.selectYear, data.selectMonth),
                            roundedCornersRadius: 18.0,
                            yearFirst: true,
                            backgroundColor: Colors.white,
                            headerColor: StaticColor.mainSoft,
                            headerTextColor: Colors.white,
                            selectedMonthBackgroundColor: StaticColor.mainSoft,
                            selectedMonthTextColor: Colors.white,
                            animationMilliseconds: 100,
                            hideHeaderRow: true,
                            unselectedMonthTextColor: StaticColor.grey60077,
                            dismissible: true,
                            cancelWidget: Text('취소', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.errorColor)),
                            // locale: const Locale('kr'),
                          ).then((value) {
                            if(value == null) {

                            } else {
                              context.read<CalendarProvider>().yearAndMonthChange(value);
                            }

                          });
                        },
                        child: Row(
                          children: [
                            Text('${data.selectYear}년 ${data.selectMonth}월', style: TextStyle(fontSize: 20.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w600)),
                            const SizedBox(width: 8),
                            Image.asset('assets/calendar/select_month_dropdown_button.png', width: 7.21, height: 4.6),
                          ],
                        )),
                    );
                  },
              ),
            ],),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: '오늘 일자로 이동합니다',
                  child: Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25.0),
                        onTap: () {
                          context.read<CalendarProvider>().yearAndMonthChange(DateTime.now());
                        },
                        child: SizedBox(
                          width: 24.0.w,
                          height: 24.0.h,
                          child: Center(child: Image.asset('assets/calendar/action_blank.png', color: Colors.black, width: 24, height: 24)),
                        ),
                      ),
                    ),
                  ),
                ),
                // Tooltip(
                //   message: '검색',
                //   child: Material(
                //     color: Colors.transparent,
                //     child: SizedBox(
                //       width: 40.w,
                //       height: 40.h,
                //       child: InkWell(
                //         borderRadius: BorderRadius.circular(25.0),
                //         onTap: () {
                //           Navigator.push(context, MaterialPageRoute(builder: (_) => CalendarSearchScreen()));
                //         },
                //         child: SizedBox(
                //           width: 24.0.w,
                //           height: 24.0.h,
                //           child: Center(child: Container(
                //             width: 24,
                //             height: 24,
                //             child: Image.asset('assets/calendar/action_search.png', color: Colors.black, width: 24, height: 24),
                //           )),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 16),
                // Tooltip(
                //   message: '알람',
                //   child: GestureDetector(
                //       child: Container(
                //         width: 24,
                //         height: 24,
                //         child: Image.asset('assets/calendar/action_bell.png', color: Colors.black, width: 24, height: 24),
                //       ),
                //       onTap: () {
                //         showDialog(
                //             context: context,
                //             //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                //             barrierDismissible: false,
                //             builder: (BuildContext context) {
                //               return const ServiceGuideDialog();
                //             });
                //         print('tap the alarm');}
                //   ),
                // ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
