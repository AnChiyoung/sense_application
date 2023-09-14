import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/calendar/calendar_event_list.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleBottomSheet extends StatefulWidget {
  double? bodyHeight;
  ScheduleBottomSheet({Key? key, this.bodyHeight}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {

  bool dragDirection = false;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        int sensitivity = 5;
        if(details.delta.dy > sensitivity) {
          print('down!!');
          dragDirection = false;
        } else if(details.delta.dy < -sensitivity) {
          print('up!!');
          dragDirection = true;
        }
        context.read<CalendarProvider>().dragDirectionChange(dragDirection);
      },
      child: Consumer<CalendarProvider>(
        builder: (context, data, child) {

          bool dragState = data.dragDirection;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // curve: Curves.decelerate,
            curve: Curves.fastOutSlowIn,
            height: dragState ? (widget.bodyHeight! - 320.0) : 300,
            decoration: BoxDecoration(
              border: Border.all(color: StaticColor.bottomSheetExternalLineColor, width: 1),
              /// bottom sheet ui header
              // borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              color: Colors.white,
            ),
            onEnd: () {
              dragDirection ? context.read<CalendarBodyProvider>().calendarFormatChange(CalendarFormat.week) : context.read<CalendarBodyProvider>().calendarFormatChange(CalendarFormat.month);
            },
            /// bottom sheet screen area
            child: child,
          );
        },
        child: Column(
          children: [
            /// event header + event header menu => event list area
            EventList(),
          ],
        ),
      )
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../../constants/public_color.dart';
// import 'calendar_body_view.dart';
// import 'calendar_utils.dart';
//
// class ScheduleBottomSheet extends StatefulWidget {
//   int month;
//   ScheduleBottomSheet({Key? key, required this.month}) : super(key: key);
//
//   @override
//   State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
// }
//
// class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
//
//   late double _height;
//
//   final double _lowLimit = 50;
//   final double _highLimit = 700;
//   final double _weekHeight = 540;
//   final double _upThresh = 100;
//   final double _boundary = 200;
//   final double _downThresh = 500;
//
//   // 100 -> 600, 550 -> 100 으로 애니메이션이 진행 될 때,
//   // 드래그로 인한 _height의 변화 방지
//   bool _longAnimation = false;
//   bool isWeekAction = false;
//   int whatAction = 0;
//
//   // data area
//   Map<String, List<Event>> temperatureEvent = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _height = _lowLimit;
//     for(int i = 0; i < sampleEvent.length; i++) {
//       if(sampleEvent.keys.elementAt(i).year.toString() == DUMMY.currentYear.toString()) {
//         if(sampleEvent.keys.elementAt(i).month.toString() == DUMMY.currentMonth.toString()) {
//           temperatureEvent![sampleEvent.keys.elementAt(i).day.toString()] = sampleEvent![sampleEvent.keys.elementAt(i)] ?? [];
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//         bottom: 0.0,
//         child: GestureDetector(
//             onVerticalDragUpdate: ((details) {
//
//               // delta: y축의 변화량, 우리가 보기에 위로 움직이면 양의 값, 아래로 움직이면 음의 값
//               double? delta = details.primaryDelta;
//               if (delta != null) {
//
//                 /// Long Animation이 진행 되고 있을 때는 드래그로 높이 변화 방지,
//                 /// 그리고 low limit 보다 작을 때 delta가 양수,
//                 /// High limit 보다 크거나 같을 때 delta가 음수이면 드래그로 높이 변화 방지
//                 if (_longAnimation ||
//                     (_height <= _lowLimit && delta > 0) ||
//                     (_height >= _highLimit && delta < 0)) return;
//                 setState(() {
//                   /// 600으로 높이 설정
//                   if (_upThresh <= _height && _height <= _boundary) {
//                     _height = _weekHeight;
//
//                     _longAnimation = true;
//                     whatAction = 1;
//                   }
//                   else if (_boundary <= _height && _height <= _highLimit) {
//                     _height = _highLimit;
//                     _longAnimation = true;
//                     whatAction = 2;
//                   }
//                   /// 100으로 높이 설정
//                   else if (_boundary <= _height && _height <= _downThresh) {
//                     _height = _lowLimit;
//                     context.read<PageProvider>().pageChangeBuilder(false, CalendarFormat.month);
//                     _longAnimation = true;
//                   }
//                   /// 기본 작동
//                   else {
//                     _height -= delta;
//                   }
//                 });
//               }
//             }),
//             child: AnimatedContainer(
//               onEnd: () {
//                 if (_longAnimation) {
//                   setState(() {
//                     _longAnimation = false;
//                   });
//                 }
//                 if(whatAction == 1) {
//                   context.read<PageProvider>().pageChangeBuilder(false, CalendarFormat.week);
//                   whatAction = 0;
//                 } else if(whatAction == 2) {
//                   context.read<PageProvider>().pageChangeBuilder(true, CalendarFormat.month);
//                   whatAction = 0;
//                 }
//               },
//               duration: const Duration(milliseconds: 200),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
//                 border: Border.all(
//                   width: 1,
//                   color: StaticColor.bottomSheetHeaderMain,
//                 ),
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: _height,
//               child: Column(
//                 children: [
//                   SizedBox(
//                     width: double.infinity,
//                     height: 40,
//                     child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: Image.asset('assets/calendar/modal_bottom_sheet_headerline.png', width: 81, height: 4)))),
//                   SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text('${widget.month}월', style: TextStyle(fontSize: 20, color: StaticColor.selectMonthColor, fontWeight: FontWeight.w600),),),
//                     ),
//                   ),
//                   // ListView.builder(
//                   //   itemCount: temperatureEvent.length + 1,
//                   //   itemBuilder: (BuildContext context, int index) {
//                   //     return Container(
//                   //       height: 30,
//                   //     );
//                   //   }
//                   // )
//                 ],
//               ),
//             )));
//   }
// }
