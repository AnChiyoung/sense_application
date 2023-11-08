import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'dart:io' as Io;

import 'package:sense_flutter_application/models/user/user_model.dart';

enum MyPagePrevRouteEnum {
  fromMyPage,
  fromFirstLogin,
}

class NewMyPageProvider with ChangeNotifier {
  UserModel _userMe = UserModel();
  UserModel get userMe => _userMe;
  String _username = '';
  String get username => _username;
  String _phone = '';
  String get phone => _phone;
  bool get phoneFieldEnabled =>
      _userMe.phone != _phone && _phone.length > 12 && _isValidAuthCode == false;
  bool _isSended = false;
  bool get isSended => _isSended;
  String _authCode = '';
  String get authCode => _authCode;
  bool _isValidAuthCode = false;
  bool get isValidAuthCode => _isValidAuthCode;
  String _phoneAuthErrorMessage = '';
  String get phoneAuthErrorMessage => _phoneAuthErrorMessage;
  bool get authCodeFieldEnabled => _authCode.length > 3 && _isValidAuthCode == false;
  String _phoneAuthSuccessMessage = '';
  String get phoneAuthSuccessMessage => _phoneAuthSuccessMessage;

  void initUserMe(UserModel value, bool notify) {
    _userMe = value;
    _username = value.username ?? '';
    _phone = value.phone ?? '';

    if (notify) notifyListeners();
  }

  void resetState() {
    _userMe = UserModel();
    _username = '';
    _phone = '';
    _isSended = false;
    _authCode = '';
    _isValidAuthCode = false;
    _phoneAuthErrorMessage = '';
    _phoneAuthSuccessMessage = '';
  }

  void updateUsername(String value) {
    // username update 치는 거
    UserRequest().patchUserMe({'username': value});
  }

  void onChangeUsername(String value, bool notify) {
    _username = value;
    // disable 풀리는 로직

    if (notify) notifyListeners();
  }

  void onChangePhone(String value, bool notify) {
    _phone = value;
    // disable 풀리는 로직

    if (notify) notifyListeners();
  }

  // 인증 번호 전송
  void sendAuthCode(String value) {
    _isSended = true;
    PhoneAuthModel().phoneAuthRequest(value);
    notifyListeners();
  }

  void onChangeAuthCode(String code, bool notify) {
    _authCode = code;

    if (notify) notifyListeners();
  }

  // 인증 번호 확인
  void checkAuthCode(String phoneNumber, int code) async {
    dynamic response = await PhoneAuthModel().authNumberCheck(phoneNumber, code);

    // 성공
    if (response == true) {
      _isValidAuthCode = true;
      resetTimer();
      _phoneAuthSuccessMessage = '인증이 완료됐습니다.';
      _phoneAuthErrorMessage = '';
    } else {
      // 실패
      _phoneAuthErrorMessage = response;
    }

    notifyListeners();
  }

  // timer variable

  String _minute = '';
  String _second = '';
  Timer? _timer;
  String get remainingText => _isValidAuthCode == true ? '' : '유효시간 $_minute:$_second';

  void startTimer() {
    int startSeconds = 180;
    _minute = '3';
    _second = '00';

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startSeconds == 0) {
          resetTimer();
          validationTimer();
        } else {
          startSeconds--;
        }

        _minute = (startSeconds.toDouble() ~/ 60.0).toString();
        _second = (startSeconds.toDouble() % 60.0).toInt() == 0
            ? '00'
            : ((startSeconds.toDouble() % 60.0).toInt() > 0 &&
                    (startSeconds.toDouble() % 60.0).toInt() < 10)
                ? '0${(startSeconds.toDouble() % 60.0).toInt()}'
                : (startSeconds.toDouble() % 60.0).toInt().toString();

        notifyListeners();
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    _minute = '';
    _second = '';
  }

  void validationTimer() {
    _phoneAuthErrorMessage = '유효시간이 만료되었어요.';
    notifyListeners();
  }
}

class MyPageProvider extends NewMyPageProvider {
  XFile? _selectImage;
  XFile? get selectImage => _selectImage;

  /// base64string
  String _updateImageString = '';
  String get updateImageString => _updateImageString;

  String _birthday = '';
  String get birthday => _birthday;

  String _loadBirthday = '';
  String get loadBirthday => _loadBirthday;

  String _email = '';
  String get email => _email;

  /// 내 정보 수정 - 성별
  final List<bool> _updateGenderState = [false, false];
  List<bool> get updateGenderState => _updateGenderState;

  bool _agree = false;
  bool get agree => _agree;

  bool _pushAlarm = false;
  bool get pushAlarm => _pushAlarm;

  bool _marketingAlarm = false;
  bool get marketingAlarm => _marketingAlarm;

  int _genderState = -1;
  int get genderState => _genderState;

  int _relationState = -1;
  int get relationState => _relationState;

  int _mbti = -1;
  int get mbti => _mbti;

  int _saveMbti = -1;
  int get saveMbti => _saveMbti;

  int _ownCar = -1;
  int get ownCar => _ownCar;

  /// 처음 불러온 정보 저장용, 저장 버튼 업데이트용
  int _loadGender = -1;
  int get loadGender => _loadGender;

  int _loadRelation = -1;
  int get loadRelation => _loadRelation;

  int _loadMbti = -1;
  int get loadMbti => _loadMbti;

  int _loadOwnCar = -1;
  int get loadOwnCar => _loadOwnCar;

  bool _basicButton = false;
  bool get basicButton => _basicButton;

  bool _moreButton = false;
  bool get moreButton => _moreButton;

  final int _loadYear = 0;
  int get loadYear => _loadYear;

  final int _loadMonth = 0;
  int get loadMonth => _loadMonth;

  final int _loadDay = 0;
  int get loadDay => _loadDay;

  int _year = 0;
  int get year => _year;

  int _month = 0;
  int get month => _month;

  int _day = 0;
  int get day => _day;

  List<FeedPreviewModel>? _postList = [];
  List<FeedPreviewModel>? get postList => _postList;

  // void initPostList(bool notify) async {
  //   _postList = await FeedRequest().likedPostListRequest();
  //   return _postList;
  // }

  MyPagePrevRouteEnum _prevRoute = MyPagePrevRouteEnum.fromMyPage;
  MyPagePrevRouteEnum get prevRoute => _prevRoute;

  void genderInit(int state) {
    _genderState = state;
    _loadGender = state;
  }

  void genderStateChange(int state) {
    _genderState = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void relationInit(int state) {
    _relationState = state;
    _loadRelation = state;
  }

  void relationStateChange(int state) {
    _relationState = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void mbtiInit(int state) {
    _mbti = state;
    _saveMbti = state;
    _loadMbti = state;
  }

  void mbtiChange(int state) {
    _mbti = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void saveMbtiChange() {
    _saveMbti = _mbti;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void ownCarInit(int state) {
    _ownCar = state;
    _loadOwnCar = state;
  }

  void ownCarChange(int state) {
    _ownCar = state;
    doesActiveButton() == true ? _moreButton = true : _moreButton = false;
    notifyListeners();
  }

  void moreButtonChange(bool state) {
    _moreButton = state;
    notifyListeners();
  }

  /// button active logic
  bool doesActiveButton() {
    return (_loadGender != _genderState) ||
        (_loadRelation != _relationState) ||
        (_loadMbti != _saveMbti) ||
        (_loadOwnCar != _ownCar);
  }

  void pushAlarmChange(bool state) {
    _pushAlarm = state;
    notifyListeners();
  }

  void marketingAlarmChange(bool state) {
    _marketingAlarm = state;
    notifyListeners();
  }

  void xfileStateChange(XFile? state) async {
    _selectImage = state;

    final bytes = await Io.File(state!.path).readAsBytes();
    String convertString = base64Encode(bytes);

    _updateImageString = convertString;

    // if(doesActiveBasicButton() == true) {
    //   _basicButton = true;
    // } else {
    //   _basicButton = false;
    // }
    notifyListeners();
  }

  void phoneStateChange(String phone, bool notify) {
    _phone = phone;
    if (notify == true) notifyListeners();
  }

  void birthdayInit(String birthday) {
    if (birthday == '') return;
    _loadBirthday = birthday;
    _birthday = birthday;
    List<String> result = birthday.split('-');
    _year = int.parse(result.elementAt(0));
    _month = int.parse(result.elementAt(1));
    _day = int.parse(result.elementAt(2));
  }

  void birthdayStateChange(String birthday) {
    _birthday = birthday;
    _loadBirthday = birthday;
    // if(doesActiveBasicButton() == true) {
    //   _basicButton = true;
    //   notifyListeners();
    // } else {
    //   _basicButton = false;
    //   notifyListeners();
    // }
  }

  void emailStateChange(String email) {
    _email = email;
    notifyListeners();
  }

  // void genderStateChange(List<bool> state) {
  //   _updateGenderState = state;
  //   notifyListeners();
  // }

  void withdrawalAgreeChange(bool state) {
    _agree = state;
    notifyListeners();
  }

  void basicButtonChange(bool state) {
    _basicButton = state;
    notifyListeners();
  }

  void doesActiveBasicButton() {
    if (_selectImage != null || _loadBirthday != _birthday) {
      _basicButton = true;
      notifyListeners();
    }
  }

  void updateInfoInit() {
    _updateImageString = '';
    _selectImage = null;
    _phone = '';
    _birthday = '';
    _basicButton = false;
    _genderState = -1;
    _relationState = -1;
    _mbti = -1;
    _ownCar = -1;
    _moreButton = false;
  }

  void setPostList(List<FeedPreviewModel> postList, bool notify) {
    _postList = postList;
    if (notify) notifyListeners();
  }

  void setPrevRoute(MyPagePrevRouteEnum value, bool notify) {
    _prevRoute = value;
    if (notify) notifyListeners();
  }
}
