import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';

class ContactProvider with ChangeNotifier {
  /// 불러온 연락처 리스트
  List<ContactModel> _callContact = [];
  List<ContactModel> get callContact => _callContact;

  /// from server, 연락처 섹션 별 카운트
  List<int> _contactCount = [0, 0, 0, 0, 0];
  List<int> get contactCount => _contactCount;

  ContactModel _contactModel = ContactModel();
  ContactModel get contactModel => _contactModel;

  bool? _bookmarkState;
  bool? get bookmarkState => _bookmarkState;

  void isCallContact(List<ContactModel> state) {
    _callContact = state;
    notifyListeners();
  }

  bool _searchState = false;
  bool get searchState => _searchState;

  void isSearchState(bool state) {
    _searchState = state;
    notifyListeners();
  }

  void infoChange(bool state) async {
    _callContact = await ContactRequest().contactListRequest();
    _bookmarkState = state;
    notifyListeners();
  }

  void bookmarkedInitialize() {
    _bookmarkState = null;
  }
}