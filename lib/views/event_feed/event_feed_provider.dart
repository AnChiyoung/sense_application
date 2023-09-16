import 'package:flutter/cupertino.dart';

class EventFeedProvider with ChangeNotifier {
  String _totalButton = 'visit_count';
  String get totalButton => _totalButton;

  void totalButtonChange(String state) {
    _totalButton = state;
    notifyListeners();
  }

  String _recommendButton = 'visit_count';
  String get recommendButton => _recommendButton;

  void recommendButtonChange(String state) {
    _recommendButton = state;
    notifyListeners();
  }
}