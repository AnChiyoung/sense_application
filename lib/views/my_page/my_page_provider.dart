import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/models/feed/feed_model.dart';
import 'package:sense_flutter_application/models/preference/preference_model.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'dart:io' as Io;

import 'package:sense_flutter_application/models/user/user_model.dart';

enum MyPagePrevRouteEnum {
  fromMyPage,
  fromFirstLogin,
}

mixin MyPagePreference on ChangeNotifier {
  UserPreferenceListItemModel? _foodPreference;
  UserPreferenceListItemModel? get foodPreference => _foodPreference;
  UserPreferenceListItemModel? _lodgingPreference;
  UserPreferenceListItemModel? get lodgingPreference => _lodgingPreference;
  UserPreferenceListItemModel? _travelPreference;
  UserPreferenceListItemModel? get travelPreference => _travelPreference;

  void initUserPreferenceList(
      {required List<UserPreferenceListItemModel> preferenceList, bool notify = false}) {
    _foodPreference =
        preferenceList.where((item) => item.type == EnumPreferenceType.food).firstOrNull;
    _lodgingPreference =
        preferenceList.where((item) => item.type == EnumPreferenceType.lodging).firstOrNull;
    _travelPreference =
        preferenceList.where((item) => item.type == EnumPreferenceType.travel).firstOrNull;

    if (notify) notifyListeners();
  }
}

class NewMyPageProvider with ChangeNotifier, MyPagePreference {
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
  int? _year;
  int? get year => _year;
  int? _month;
  int? get month => _month;
  int? _day;
  int? get day => _day;

  void initUserMe(UserModel userModel, bool notify) {
    _userMe = userModel;
    _username = userModel.username ?? '';
    _phone = userModel.phone ?? '';

    if (userModel.birthday != null) {
      List<String> result = (userModel.birthday ?? '').split('-');
      _year = int.parse(result.elementAt(0));
      _month = int.parse(result.elementAt(1));
      _day = int.parse(result.elementAt(2));
    }

    if (notify) notifyListeners();
  }

  void resetState() {
    // _userMe = UserModel();
    _username = '';
    _phone = '';
    _isSended = false;
    _authCode = '';
    _isValidAuthCode = false;
    _phoneAuthErrorMessage = '';
    _phoneAuthSuccessMessage = '';
    _year = null;
    _month = null;
    _day = null;
  }

  void onChangeUsername(String value, bool notify) {
    _username = value;

    if (notify) notifyListeners();
  }

  void onChangePhone(String value, bool notify) {
    _phone = value;

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
    resetTimer();
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

  void onChangeYear(String value, bool notify) {
    if (value != '') {
      _year = int.parse(value);
    } else {
      _year = null;
    }
    if (notify) notifyListeners();
  }

  void onChangeMonth(String value, bool notify) {
    if (value != '') {
      _month = int.parse(value);
    } else {
      _month = null;
    }
    if (notify) notifyListeners();
  }

  void onChangeDay(String value, bool notify) {
    if (value != '') {
      _day = int.parse(value);
    } else {
      _day = null;
    }
    if (notify) notifyListeners();
  }

  bool saveButtonDisabled() {
    // 변동 여부 있는지 & validation 통과 했는지
    if (_username == '') return true;
    if (_phone == '') return true;
    if (_phone != userMe.phone && _isValidAuthCode == false) return true;

    // 원래 생일이 없었는데 생일을 입력했을 때
    if (userMe.birthday == null) {
      if ((_year == null && _month == null && _day == null) ||
          (_year != null && _month != null && _day != null)) {
        return true;
      }
    }

    // 기존의 값과 일치할 때
    if (userMe.username == _username && userMe.phone == _phone) {
      if (userMe.birthday == null) {
        if (_year == null && _month == null && _day == null) {
          return true;
        }
      } else {
        List<String> result = userMe.birthday!.split('-');
        if (result.length > 2 &&
            _year == int.parse(result.elementAt(0)) &&
            _month == int.parse(result.elementAt(1)) &&
            _day == int.parse(result.elementAt(2))) {
          return true;
        }
      }
    }

    return false;
  }

  Future<bool> updateUserMe() async {
    Map<String, dynamic> body = {};

    if (_username != userMe.username) {
      body['username'] = _username;
    }

    if (_phone != userMe.phone) {
      body['phone'] = _phone;
    }

    if (_year != null && _month != null && _day != null) {
      body['birthday'] = '$_year-$_month-$_day';
    }

    return await UserRequest().patchUserMe(body);
  }
}

class MyPageProvider extends NewMyPageProvider {
  XFile? _selectImage;
  XFile? get selectImage => _selectImage;

  /// base64string
  String _updateImageString = '';
  String get updateImageString => _updateImageString;

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
    if (_selectImage != null) {
      _basicButton = true;
      notifyListeners();
    }
  }

  void updateInfoInit() {
    _updateImageString = '';
    _selectImage = null;
    _phone = '';
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

// class Field {
//   String name;
//   bool isChanged;
//   bool isSavable;

//   Field({
//     required this.name,
//     this.isChanged = false,
//     this.isSavable = false,
//   });
// }

// List<Field> list = [
//   Field(name: 'username'),
//   Field(name: 'phone'),
//   Field(name: 'birth'),
// ];

// Map<String, String> prevValue = {
//   'username': 'a',
//   'phone': '010-0000-0000',
//   'birth': '1900-00-00',
// };

// String usernameValue = '';
// String phoneValue = '010-0000-0000';
// bool isPhoneAuth = true;
// String birthValue = '1900-00-00';

// List<Field> validateList = [...list];

// Field? findTarget(String name) {
//   return validateList.firstWhere((item) => name == item.name, orElse: () => Field(name: ''));
// }

// void changeState(String name, {bool? isChanged, bool? isSavable}) {
//   final index = validateList.indexWhere((item) => item.name == name);
//   if (index != -1) {
//     final field = validateList[index];
//     validateList[index] = Field(
//       name: name,
//       isChanged: isChanged ?? field.isChanged,
//       isSavable: isSavable ?? field.isSavable,
//     );
//   }
// }

// bool validate() {
//   if (usernameValue != prevValue['username']) {
//     changeState('username', isChanged: true);
//   }

//   if (usernameValue.isEmpty) {
//     changeState('username', isSavable: false);
//   }

//   if (phoneValue.isNotEmpty && phoneValue != prevValue['phone']) {
//     changeState('phone', isChanged: true);
//   }

//   if (isPhoneAuth) {
//     changeState('phone', isSavable: true);
//   }

//   if (birthValue != prevValue['birth']) {
//     changeState('birth', isChanged: true);
//   }

//   if (birthValue.isNotEmpty) {
//     changeState('birth', isSavable: true);
//   }

//   print(validateList);
//   return validateList.where((field) => field.isChanged).every((field) => field.isSavable);
// }

// void main() {
//   print(validate());
// }
