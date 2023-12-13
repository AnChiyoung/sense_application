import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/utils/utility.dart';

class EditProfileProvider with ChangeNotifier {
  UserModel _userMe = UserModel();
  UserModel get userMe => _userMe;

  String _profileImageUrl = '';
  String get profileImageUrl => _profileImageUrl;

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

  EnumUserGender? _gender;
  EnumUserGender? get gender => _gender;

  int? _year;
  int? get year => _year;
  int? _month;
  int? get month => _month;
  int? _day;
  int? get day => _day;

  EnumUserRelationshipStatus? _relationshipStatus;
  EnumUserRelationshipStatus? get relationshipStatus => _relationshipStatus;

  String? _mbti;
  String? get mbti => _mbti;

  bool? _isOwnCar;
  bool? get isOwnCar => _isOwnCar;

  void initScreen(UserModel userModel, {bool notify = true}) {
    _userMe = userModel;
    _profileImageUrl = userModel.profileImageString ?? '';
    _username = userModel.username ?? '';
    _phone = userModel.phone ?? '';
    _gender = userModel.gender == null
        ? null
        : EnumUserGender.values.firstWhere((element) => element.value == userModel.gender);
    if (userModel.birthday != null) {
      List<String> result = (userModel.birthday ?? '').split('-');
      _year = int.parse(result.elementAt(0));
      _month = int.parse(result.elementAt(1));
      _day = int.parse(result.elementAt(2));
    }
    _relationshipStatus = userModel.relationshipStatus == null
        ? null
        : EnumUserRelationshipStatus.values
            .firstWhere((element) => element.value == userModel.relationshipStatus);
    _mbti = userModel.mbti;
    _isOwnCar = userModel.isOwnCar;

    // ValidationField v1 = ValidationField<String>(
    //   'profileImageUrl',
    //   originValue: _profileImageUrl,
    //   validate: [
    //     (value) => value.isNotEmpty,
    //   ],
    // );
    // ValidationField v2 = ValidationField<String>(
    //   'username',
    //   originValue: _username,
    //   validate: [
    //     (value) => value.isNotEmpty,
    //   ],
    // );
    // ValidationField v3 = ValidationField<String>(
    //   'phone',
    //   originValue: _phone,
    //   validate: [
    //     (value) => value.isNotEmpty,
    //     (value) => value != userMe.phone && _isValidAuthCode == false,
    //   ],
    // );
    // ValidationField v4 = ValidationField<EnumUserGender>(
    //   'gender',
    //   originValue: _gender,
    // );
    // ValidationField v5 = ValidationField<String>(
    //   'birthday',
    //   originValue: userModel.birthday,
    //   validate: [],
    // );
    // ValidationField v6 = ValidationField<EnumUserRelationshipStatus>(
    //   'relationshipStatus',
    //   originValue: _relationshipStatus,
    // );
    // ValidationField v7 = ValidationField<String>(
    //   'mbti',
    //   originValue: _mbti,
    // );
    // ValidationField v8 = ValidationField<bool>(
    //   'isOwnCar',
    //   originValue: _isOwnCar,
    // );
    // validationFields.addAll([v1, v2, v3, v4, v5, v6, v7, v8]);
    if (notify) notifyListeners();
  }

  void resetState() {
    _profileImageUrl = '';
    _username = '';
    _phone = '';
    _isSended = false;
    _authCode = '';
    _isValidAuthCode = false;
    _phoneAuthErrorMessage = '';
    _phoneAuthSuccessMessage = '';
    _gender = null;
    _year = null;
    _month = null;
    _day = null;
    _relationshipStatus = null;
    _mbti = null;
    _isOwnCar = null;
  }

  void onChangeProfileImageUrl(String value, bool notify) {
    _profileImageUrl = value;
    if (notify) notifyListeners();
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

  void onChangeGender(EnumUserGender gender, bool notify) {
    _gender = gender;
    if (notify) notifyListeners();
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

  void onChangeRelationshipStatus(EnumUserRelationshipStatus relationshipStatus, bool notify) {
    _relationshipStatus = relationshipStatus;
    if (notify) notifyListeners();
  }

  void onChangeMbti(String? mbti, bool notify) {
    _mbti = mbti;
    if (notify) notifyListeners();
  }

  void onChangeOwnCar(bool isOwnCar, bool notify) {
    _isOwnCar = isOwnCar;
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

    // _profileImageUrl
    // _gender
    // _relationshipStatus
    // _mbti
    // _isOwnCar

    // 기존의 값과 일치할 때
    if (userMe.username == _username &&
        userMe.phone == _phone &&
        userMe.profileImageString == _profileImageUrl &&
        ((userMe.birthday == null && _year == null && _month == null && _day == null) ||
            (userMe.birthday!.split('-').map((e) => int.parse(e)).join('-') ==
                '$_year-$_month-$_day')) &&
        (userMe.gender == null && _gender == null || userMe.gender == _gender!.value) &&
        (userMe.relationshipStatus == null && _relationshipStatus == null ||
            userMe.relationshipStatus == _relationshipStatus!.value) &&
        userMe.mbti == _mbti &&
        userMe.isOwnCar == _isOwnCar) {
      return true;
    }

    return false;
  }

  Future<bool> updateUserMe() async {
    Map<String, dynamic> body = {};

    if (_profileImageUrl != userMe.profileImageString) {
      body['profile_image'] = _profileImageUrl;
    }

    if (_username != userMe.username) {
      body['username'] = _username;
    }

    if (_phone != userMe.phone) {
      body['phone'] = _phone;
    }

    if (_year != null && _month != null && _day != null) {
      body['birthday'] = '$_year-$_month-$_day';
    }

    if (_gender != null) {
      body['gender'] = _gender!.value;
    }

    if (_relationshipStatus != null) {
      body['relationship_status'] = _relationshipStatus!.value;
    }

    if (_mbti != null) {
      body['mbti'] = _mbti;
    }

    if (_isOwnCar != null) {
      body['is_own_car'] = _isOwnCar;
    }

    return await UserRequest().patchUserMe(body);
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
