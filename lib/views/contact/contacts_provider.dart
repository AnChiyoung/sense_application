import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _callContact = [];
  List<Contact> get callContact => _callContact;

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