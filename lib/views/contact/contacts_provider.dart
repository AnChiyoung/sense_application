import 'dart:convert';
import 'dart:io' as Io;
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';

class ContactProvider with ChangeNotifier {
  static ContactModel publicEmptyObject = ContactModel(); // 객체 비교용

  /// 20230821
  bool _updateState = false;
  bool get updateState => _updateState;

  void viewUpdate(bool state) {
    _updateState = true;
    notifyListeners();
  }

  int _searchFocus = 0;
  int get searchFocus => _searchFocus;

  void searchFocusUpdate() {
    _searchFocus++;
  }

  void searchFocusInit() {
    _searchFocus = 0;
  }


  /// 수정용 variable
  int _updateCategory = 0;
  int get updateCategory => _updateCategory;
  String _updateName = '';
  String get updateName => _updateName;
  String _updatePhone = '';
  String get updatePhone => _updatePhone;
  String _updateBirthday = '';
  String get updateBirthday => _updateBirthday;
  String _updateGender = '';
  String get updateGender => _updateGender;
  String _updateImage = '';
  String get updateImage => _updateImage;

  /// 불러온 연락처 리스트
  List<ContactModel> _callContact = [];
  List<ContactModel> get callContact => _callContact;
  int _listCount = 0;
  int get listCount => _listCount;

  /// from server, 연락처 섹션 별 카운트
  List<int> _contactCount = [0, 0, 0, 0, 0];
  List<int> get contactCount => _contactCount;

  ContactModel _contactModel = publicEmptyObject;
  ContactModel get contactModel => _contactModel;

  bool? _bookmarkState;
  bool? get bookmarkState => _bookmarkState;

  bool _genderState = true;
  bool get genderState => _genderState;

  int _categoryState = 0;
  int get categoryState => _categoryState;

  XFile? _selectImage;
  XFile? get selectImage => _selectImage;

  String _base64String = '';
  String get base64String => _base64String;

  String _searchText = '';
  String get searchText => _searchText;

  void searchTextChange(String state) {
    _searchText = state;
    notifyListeners();
  }

  void isCallContact(List<ContactModel> state) {
    _callContact = state;
    notifyListeners();
  }

  void contactListLoad() async {
    _callContact = await ContactRequest().contactListRequest();
    _listCount = _callContact.length;
    // ContactTabModel tempModel = await ContactRequest().contactListRequest();
    // _callContact = tempModel.contactModelList!;
    // _listCount = tempModel.count!;
    notifyListeners();
  }

  bool _searchState = false;
  bool get searchState => _searchState;

  void isSearchState(bool state) {
    _searchState = state;
    if(state == false) {
      _searchFocus = 0;
    }
    notifyListeners();
  }

  void infoChange(bool state) async {
    // ContactTabModel tempModel = await ContactRequest().contactListRequest();
    // _callContact = tempModel.contactModelList!;
    _callContact = await ContactRequest().contactListRequest();
    _bookmarkState = state;
    notifyListeners();
  }

  void contactResponseModelChange(ContactModel model) {
    _contactModel = model;
    notifyListeners();
  }

  void infoReload(ContactModel model) async {
    // ContactTabModel tempModel = await ContactRequest().contactListRequest();
    // _callContact = tempModel.contactModelList!;
    _callContact = await ContactRequest().contactListRequest();
    _contactModel = model;
    // _contactModel = await ContactRequest().contactDetailRequest(contactId);
    notifyListeners();
  }

  void bookmarkedInitialize() {
    _bookmarkState = null;
  }

  void contactModelLoad(int contactId) async {
    _contactModel = await ContactRequest().contactDetailRequest(contactId);
    notifyListeners();
  }

  void contactModelInit() {
    _contactModel = publicEmptyObject;
    // notifyListeners();
  }

  void genderStateSet(bool state) {
    _genderState = state;
    /// non notify!!
  }

  void genderStateChange(bool state) {
    _genderState = state;
    notifyListeners();
  }

  void categoryStateSet(int state) {
    _categoryState = state;
    /// non notify!!
  }

  void categoryStateChange(int state) {
    _categoryState = state;
    notifyListeners();
  }

  void xfileStateChange(XFile? state) async {
    _selectImage = state;

    final bytes = await Io.File(state!.path).readAsBytes();
    String convertString = base64Encode(bytes);

    _updateImage = convertString;
    notifyListeners();
  }

  void xfileStateClear() {
    _selectImage = null;
    notifyListeners();
  }

  void xfileStateInit() {
    _selectImage = null;
    /// non notify!!
  }

  void updateCategoryData(int category) {
    _updateCategory = category;
    /// non notify!!
  }

  void updateNameData(String name) {
    _updateName = name;
    /// non notify!!
  }

  void updatePhoneData(String phone) {
    _updatePhone = phone;
    /// non notify!!
  }

  void updateBirthdayData(String birthday) {
    _updateBirthday = birthday;
    /// non notify!!
  }

  void updateGenderData(String gender) {
    _updateGender = gender;
    /// non notify!!
  }

  void updateImageData(String image) {
    _updateImage = image;
    /// non notify!!
  }
}