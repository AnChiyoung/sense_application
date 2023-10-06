import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet({super.key});

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  @override
  Widget build(BuildContext context) {

    final safeAreaTopPadding = context.read<CEProvider>().safeAreaTopPadding;
    final safeAreaBottomPadding = context.read<CEProvider>().safeAreaBottomPadding;

    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - safeAreaTopPadding - 60, /// 마지막 60은 header widget height
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Stack(
            children: [
              Column(
                children: [
                  DateHeader(),
                  DateTitle(),
                  SizedBox(height: 24.0.h),
                  DateViewSection(),
                  DateSelectSection(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DateSubmitButton(),
              )
            ]
        )
    );
  }
}

class DateHeader extends StatelessWidget {
  const DateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class DateTitle extends StatelessWidget {
  const DateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("이벤트 일자", style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
  }
}

class DateSubmitButton extends StatefulWidget {
  const DateSubmitButton({super.key});

  @override
  State<DateSubmitButton> createState() => _DateSubmitButtonState();
}

class _DateSubmitButtonState extends State<DateSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            dateListener();
          },
          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              ]
          )
      ),
    );
  }

  void dateListener() async {
    context.read<CEProvider>().dateSave();
    Navigator.pop(context);
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
    final dayView = context.watch<CEProvider>().selectDate;

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
            Image.asset('assets/create_event/date_view_icon.png', width: 24, height: 24),
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
  DateTime? _focusedDay;
  late List<String> days;

  @override
  void initState() {
    selectedYear = 0;
    selectedMonth = 0;
    selectedDay = 0;
    _selectedDay = DateTime.parse(context.read<CEProvider>().selectDate);
    _focusedDay = DateTime.now();
    days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TableCalendar(
          locale: 'ko_KR',
          rowHeight: 44,
          daysOfWeekHeight: 45,
          focusedDay: _focusedDay!,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2033, 1, 1),
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          headerVisible: true,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.black),
            headerPadding: const EdgeInsets.only(left: 20, right: 20),
            formatButtonVisible: false,
            leftChevronIcon: ImageIcon(const AssetImage('assets/create_event/calendar_arrow_left.png'),
                size: 24, color: StaticColor.calendarArrowColor), // image.asset can't build
            rightChevronIcon: ImageIcon(
                const AssetImage('assets/create_event/calendar_arrow_right.png'),
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
            defaultTextStyle: TextStyle(color: Colors.black),
          ),
          calendarBuilders: CalendarBuilders(defaultBuilder: (context, dateTime, _) {
            return CalendarCellBuilder(context, dateTime, _);
          })
        // calendarBuilders: CalendarBuilders(dowBuilder: (context, day) {
        //   return Center(
        //       child: Text(days[day.weekday - 1],
        //           style: TextStyle(
        //               fontSize: 14,
        //               color: StaticColor.calendarDowColor,
        //               fontWeight: FontWeight.w700)));
        // })
      ),
    );
  }

  Widget CalendarCellBuilder(BuildContext context, DateTime dateTime, _) {
    /// non stuff

    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime now = DateTime.parse(dateFormat.format(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day)));
    DateTime selectDayConvert = DateTime.parse(dateFormat.format(dateTime));
    bool compareResult = now.isAfter(selectDayConvert);

    return Container(
      padding: EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.only(top: 3, bottom: 3),
        // width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Align(
            alignment: Alignment.center,
            child: Text(dateTime.day.toString(), style: compareResult == true ? TextStyle(fontSize: 14, color: StaticColor.grey400BB) : const TextStyle(fontSize: 14, color: Colors.black),)),
      ),
    );
  }

  void onDaySelected(DateTime selectDay, DateTime focusedDay) {
    final DateFormat viewFormatter = DateFormat('yyyy-MM-dd');

    DateTime now = DateTime.parse(viewFormatter.format(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day)));
    DateTime selectDayConvert = DateTime.parse(viewFormatter.format(selectDay));

    /// sprint3 description => 과거일 때 이벤트 날짜 추가 행위 x
    /// 과거일 때 => 아무동작 안함
    if(now.isAfter(selectDayConvert) == true) {
      /// nothing!!
    } else {
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
      /// 위에 재정의 후 주석처리 2023.07.19.
      // final DateFormat viewFormatter = DateFormat('yyyy-MM-dd');
      // context.read<AddEventProvider>().dayViewUpdate(viewFormatter.format(selectedDate));
      // context.read<AddEventProvider>().dateSelectNextButton(true);

      // AddEventModel.dateModel = DateTime.utc(selectedYear, selectedMonth, selectedDay).toString();
      // print()
      context.read<CEProvider>().selectDateChange(DateTime.utc(selectedYear, selectedMonth, selectedDay).toString(), true);
      // context.read<CreateEventImproveProvider>().dateStateChange(DateTime.utc(selectedYear, selectedMonth, selectedDay).toString());
    }
  }
}