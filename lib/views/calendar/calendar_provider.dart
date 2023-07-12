import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider with ChangeNotifier {
  int _selectMonth = DateTime.now().month;
  int get selectMonth => _selectMonth;

  int _selectDay = DateTime.now().day;
  int get selectDay => _selectDay;

  void monthChange(int month) {
    _selectMonth = month;
    notifyListeners();
  }

  void dayChange(int day) {
    _selectDay = day;
    notifyListeners();
  }

  ScrollController _monthListController = ScrollController();
  ScrollController get monthListController => _monthListController;

  void controllerSet(ScrollController state) {
    _monthListController = state;
  }

  bool _dragDirection = false;
  bool get dragDirection => _dragDirection;

  void dragDirectionChange(bool state) {
    _dragDirection = state;
    notifyListeners();
  }
}

class CalendarBodyProvider with ChangeNotifier {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat get calendarFormat => _calendarFormat;

  void calendarFormatChange(CalendarFormat state) {
    _calendarFormat = state;
    notifyListeners();
  }
}