import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/recommended_event/recommended_event_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelectHeader extends StatefulWidget {
  const DateSelectHeader({Key? key}) : super(key: key);

  @override
  State<DateSelectHeader> createState() => _DateSelectHeaderState();
}

class _DateSelectHeaderState extends State<DateSelectHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', closeCallback: closeCallback);
  }

  void backCallback() {
    /// 현재 context 가져오기 위함
    // var context;
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   context = CandyGlobalVariable.naviagatorState.currentContext;
    // });
    Navigator.of(context).pop();
    context.read<AddEventProvider>().dateSelectNextButtonReset();
    context.read<AddEventProvider>().dayViewReset();
  }

  void closeCallback() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AddEventCancelDialog();
        });
  }
}

class DateSelectTitle extends StatefulWidget {
  const DateSelectTitle({Key? key}) : super(key: key);

  @override
  State<DateSelectTitle> createState() => _DateSelectTitleState();
}

class _DateSelectTitleState extends State<DateSelectTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('날짜를\n선택해주세요',
                style: TextStyle(
                    fontSize: 24,
                    color: StaticColor.addEventTitleColor,
                    fontWeight: FontWeight.w500)),
            Container(
              width: 81,
              height: 32,
              decoration: BoxDecoration(
                color: StaticColor.categoryUnselectedColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  AddEventModel.eventDateModel = '';
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RecommendedEventScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                child: Text('건너뛰기',
                    style: TextStyle(
                        fontSize: 13,
                        color: StaticColor.addEventFontColor,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ));
  }
}

class DateViewSection extends StatefulWidget {
  const DateViewSection({Key? key}) : super(key: key);

  @override
  State<DateViewSection> createState() => _DateViewSectionState();
}

class _DateViewSectionState extends State<DateViewSection> {
  @override
  Widget build(BuildContext context) {
    final dayView = context.watch<AddEventProvider>().selectedDay;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 48),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: StaticColor.dateViewBoxColor,
          // color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset('assets/add_event/date_view_icon.png', width: 24, height: 24),
            const SizedBox(width: 8),
            Text(dayView,
                style: TextStyle(
                    fontSize: 14,
                    color: StaticColor.tabbarIndicatorColor,
                    fontWeight: FontWeight.w500)),
          ]),
        ),
      ),
    );
  }
}

class DateSelectSection extends StatefulWidget {
  const DateSelectSection({Key? key}) : super(key: key);

  @override
  State<DateSelectSection> createState() => _DateSelectSectionState();
}

class _DateSelectSectionState extends State<DateSelectSection> {
  late int selectedYear;
  late int selectedMonth;
  late int selectedDay;
  DateTime? _selectedDay;
  late DateTime _focusedDay;
  late List<String> days;

  @override
  void initState() {
    selectedYear = 0;
    selectedMonth = 0;
    selectedDay = 0;
    _selectedDay = null;
    _focusedDay = DateTime.now();
    days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TableCalendar(
          rowHeight: 44,
          daysOfWeekHeight: 45,
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2033, 1, 1),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          headerVisible: true,
          headerStyle: HeaderStyle(
            titleCentered: true,
            headerPadding: const EdgeInsets.only(left: 20, right: 20),
            formatButtonVisible: false,
            leftChevronIcon: ImageIcon(const AssetImage('assets/add_event/calendar_arrow_left.png'),
                size: 24, color: StaticColor.calendarArrowColor), // image.asset can't build
            rightChevronIcon: ImageIcon(
                const AssetImage('assets/add_event/calendar_arrow_right.png'),
                size: 24,
                color: StaticColor.calendarArrowColor),
          ),
          onDaySelected: onDaySelected,
          calendarStyle: CalendarStyle(
            todayTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
            selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
              color: StaticColor.unSelectedColor,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: StaticColor.selectDayColor,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
            return Center(
                child: Text(days[day.weekday - 1],
                    style: TextStyle(
                        fontSize: 14,
                        color: StaticColor.calendarDowColor,
                        fontWeight: FontWeight.w700)));
          })),
    );
  }

  void onDaySelected(DateTime selectDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectDay)) {
      setState(() {
        _selectedDay = selectDay;
        _focusedDay = focusedDay;
      });
    }

    selectedYear = selectDay.year;
    selectedMonth = selectDay.month;
    selectedDay = selectDay.day;
    final DateTime selectedDate = DateTime.utc(selectedYear, selectedMonth, selectedDay);
    final DateFormat viewFormatter = DateFormat('yyyy-MM-dd');
    context.read<AddEventProvider>().dayViewUpdate(viewFormatter.format(selectedDate));
    context.read<AddEventProvider>().dateSelectNextButton(true);

    AddEventModel.eventDateModel = viewFormatter.format(selectedDate);
  }
}

class DateSelectNextButton extends StatefulWidget {
  const DateSelectNextButton({Key? key}) : super(key: key);

  @override
  State<DateSelectNextButton> createState() => _DateSelectNextButtonState();
}

class _DateSelectNextButtonState extends State<DateSelectNextButton> {
  Future backButtonAction(BuildContext context) async {
    context.read<AddEventProvider>().dateSelectNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {
    final buttonEnabled = context.watch<AddEventProvider>().dateSelectButtonState;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () {
              buttonEnabled == true
                  ? Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RecommendedEventScreen()))
                  : () {};
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonEnabled == true
                    ? StaticColor.categorySelectedColor
                    : StaticColor.unSelectedColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: const [
              SizedBox(
                  height: 56,
                  child: Center(
                      child: Text('완료',
                          style: TextStyle(
                              fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
            ])),
      ),
    );
  }
}
