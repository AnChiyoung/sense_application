import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  /// 불러온 연락처 리스트
  List<Contact> _callContact = [];
  List<Contact> get callContact => _callContact;

  /// from server, 연락처 섹션 별 카운트
  List<int> _contactCount = [0, 0, 0, 0, 0];
  List<int> get contactCount => _contactCount;

  void isCallContact(List<Contact> state) {
    _callContact = state;
    notifyListeners();
  }

  bool _searchState = false;
  bool get searchState => _searchState;

  void isSearchState(bool state) {
    _searchState = state;
    notifyListeners();
  }
}