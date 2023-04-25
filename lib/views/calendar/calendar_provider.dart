import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider with ChangeNotifier {
  int _selectMonth = DateTime.now().month;
  int get selectMonth => _selectMonth;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat get calendarFormat => _calendarFormat;

  void monthChange(int month) {
    _selectMonth = month;
    notifyListeners();
  }

  void calendarFormatChange(CalendarFormat state) {
    _calendarFormat = state;
    notifyListeners();
  }
}