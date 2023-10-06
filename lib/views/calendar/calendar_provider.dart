import 'package:flutter/cupertino.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarProvider with ChangeNotifier {
  int _selectYear = DateTime.now().year;
  int get selectYear => _selectYear;

  int _selectMonth = DateTime.now().month;
  int get selectMonth => _selectMonth;

  int _selectDay = DateTime.now().day;
  int get selectDay => _selectDay;

  DateTime _selectDate = DateTime.now();
  DateTime get selectDate => _selectDate;

  void yearChange(int year) {
    _selectYear = year;
    notifyListeners();
  }

  void monthChange(int month) {
    _selectMonth = month;
    notifyListeners();
  }

  void dayChange(int day) {
    _selectDay = day;
    notifyListeners();
  }

  void yearAndMonthChange(DateTime dateTime) {
    _selectDate = dateTime;
    _selectYear = dateTime.year;
    _selectMonth = dateTime.month;
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

  void calendarFormatChange(CalendarFormat state, bool notify) {
    _calendarFormat = state;
    if(notify == true) {
      notifyListeners();
    } else {}
  }

  List<Map<String, List<EventModel>>> _monthEventMap = [];
  List<Map<String, List<EventModel>>> get monthEventMap => _monthEventMap;

  void eventModelCollectionChange(List<Map<String, List<EventModel>>> state, bool notify) {
    _monthEventMap = state;
    if(notify == true) {
      notifyListeners();
    } else {}
  }
}