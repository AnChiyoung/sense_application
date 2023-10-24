import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_bottom_sheet_submit_button.dart';
import 'package:table_calendar/table_calendar.dart';

class EventDateBottomSheet extends StatefulWidget {
  const EventDateBottomSheet({super.key});

  @override
  State<EventDateBottomSheet> createState() => _EventDateBottomSheetState();
}

class _EventDateBottomSheetState extends State<EventDateBottomSheet> {

  void onPressSubmit() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    DateTime? date = context.read<EDProvider>().date;
    if (date == null) return;

    context.read<EDProvider>().changeDate(eventId, date, true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Consumer<EDProvider>(
            builder: (context, data, child) {
          
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    const DateViewSection(),
                    SizedBox(height: 32.0.h),
                    const DateSelectSection(),
                  ],
                ),
              );
            }
          ),
          Align(alignment: Alignment.bottomCenter, child: EventBottomSheetSubmitButton(onPressed: onPressSubmit))
        ],
      ),
    );
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
    final date = context.watch<EDProvider>().date;

    return Container(
      height: 48,
      decoration: BoxDecoration(color: StaticColor.dateViewBoxColor,borderRadius: BorderRadius.circular(8.0),),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.start, 
          children: [
            Image.asset('assets/create_event/date_view_icon.png', width: 24, height: 24),
            const SizedBox(width: 8),
            Text(DateFormat('yyyy-MM-dd').format(date!), style: TextStyle(fontSize: 14, color: StaticColor.tabbarIndicatorColor, fontWeight: FontWeight.w500)),
          ],
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
  DateTime _focusedDay = DateTime.now();

  void onDaySelected(DateTime selectDay, DateTime focusedDay) {
    if(DateTime.now().isAfter(selectDay) == true) return;
    _focusedDay = focusedDay;
    context.read<EDProvider>().setDate(selectDay, true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EDProvider>(
      builder: (context, data, child) {

        return TableCalendar(
          locale: 'ko_KR',
          rowHeight: 48.0.h,
          daysOfWeekHeight: 44,
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2033, 1, 1),
          selectedDayPredicate: (day) => isSameDay(data.date, day),
          headerVisible: true,
          headerStyle: HeaderStyle(
            titleCentered: true,
            titleTextStyle: const TextStyle(color: Colors.black),
            headerPadding: EdgeInsets.only(bottom: 8.0.h),
            formatButtonVisible: false,
            leftChevronIcon: ImageIcon(const AssetImage('assets/create_event/calendar_arrow_left.png'), size: 24, color: StaticColor.calendarArrowColor),
            rightChevronIcon: ImageIcon(const AssetImage('assets/create_event/calendar_arrow_right.png'), size: 24, color: StaticColor.calendarArrowColor),
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
            defaultTextStyle: const TextStyle(color: Colors.black),
          ),
          calendarBuilders: CalendarBuilders(defaultBuilder: (context, dateTime, _) {
            return calendarCellBuilder(context, dateTime, _);
          })
        );
      }
    );
  }

  Widget calendarCellBuilder(BuildContext context, DateTime dateTime, _) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime now = DateTime.parse(dateFormat.format(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day)));
    DateTime selectDayConvert = DateTime.parse(dateFormat.format(dateTime));
    bool compareResult = now.isAfter(selectDayConvert);

    return Container(
      padding: EdgeInsets.all(3.0.r),
      child: Container(
        padding: EdgeInsets.only(top: 3.0.h, bottom: 3.0.h),
        // width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Text(dateTime.day.toString(), style: compareResult == true ? TextStyle(fontSize: 14, color: StaticColor.grey400BB) : const TextStyle(fontSize: 14, color: Colors.black),)),
      ),
    );
  }
}

