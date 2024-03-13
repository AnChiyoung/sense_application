import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkMailRepositoryProvider = StateProvider<AuthApi>((ref) {
  return AuthApi();
});

final emailInputProvider = StateProvider<String>((ref) {
  return '';
});

final emailErrorProvider = StateProvider<String?>((ref) {
  return null;
});

final isEmailAvailableProvider = StateProvider<bool?>((ref) {
  return null;
});

final isObscureProvider1 = StateProvider<bool>((ref) {
  return true;
});

final isObscureProvider2 = StateProvider<bool>((ref) {
  return true;
});

final passwordInputProvider = StateProvider<String>((ref) {
  return '';
});

final confirmPasswordInputProvider = StateProvider<String>((ref) {
  return '';
});

final errorPasswordProvider = StateProvider<String?>((ref) {
  String pwd = ref.watch(passwordInputProvider);
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  
  if (pwd.isEmpty) {
    return null;
  } else if (!passwordRegex.hasMatch(pwd)) {
    return 'Please enter at least 8 characters with a combination of letters and numbers.';
  }
  else if (pwd.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  
  return null;
});

final confirmPasswordErrorProvider = StateProvider<String?>((ref) {
  String pwd = ref.watch(passwordInputProvider);
  String confirmPwd = ref.watch(confirmPasswordInputProvider);
  
  if (confirmPwd.isEmpty) {
    return null;
  } else if (pwd != confirmPwd) {
    return '비밀번호가 일치하지 않습니다';
  }
  
  return null;

});

final nameInputProvider = StateProvider<String>((ref) {
  return '';
});

final errorNameProvider = StateProvider<String?>((ref) {
  String name = ref.watch(nameInputProvider);
  RegExp regex = RegExp(r'^[가-힣]{2,7}$');
  
  if (name.isEmpty) {
    return null;
  } else if(regex.hasMatch(name)) {
    return '한글 이름을 입력해주세요';
  }
  else if (name.length < 2) {
    return '이름은 2자 이상이어야 합니다';
  }
  
  return null;
});

enum Gender {male, female}

final genderProvider = StateProvider<Gender?>((ref) {
  return;
});

final selectedGender = StateProvider<String?>((ref) {
  switch (ref.watch(genderProvider)) {
    case  Gender.male:
      return 'MALE';
    case Gender.female:
      return 'FEMALE';
    default:
      return '';
  }
});