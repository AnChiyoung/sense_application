import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/utils/utils.dart';

final authRepositoryProvider = StateProvider<AuthApi>((ref) {
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
  RegExp regex = RegExp(r'^[\uAC00-\uD7AF]+$');
  
  if (name.isEmpty) {
    return null;
  } else if(!regex.hasMatch(name)) {
    return '김텍스트이름은 한글로 2자 이상 8자 미만으로 입력해 주세요';
  }
  else if (name.length < 2) {
    return '이름은 한글로 2자 이상 입력해주세요.';
  } else if (name.length > 8) {
    return '영문과 숫자를 조합하여 최대 8자까지 입력해주세요.';
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

final dateOfBirthProvider = StateProvider<String>((ref) {
  return '';
});

final phoneInputProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
bool isSendCodeProvider(ref) {
  return ref.watch(expirationTimeProvider).state.isNotEmpty;
}

final expirationTimeProvider = StateProvider<String>((ref) {
  return '';
});

final codeInputProvider = StateProvider<String>((ref) {
  return '';
});

final isCodeVerifiedProvider = StateProvider<bool>((ref) {
  return false;
});

final codeInputError = StateProvider<String>((ref) => '');

final withNoErrorsMessagesProvider = StateProvider<bool>((ref) {
  var errors = [
    ref.watch(emailErrorProvider),
    ref.watch(errorPasswordProvider),
    ref.watch(confirmPasswordErrorProvider),
    ref.watch(codeInputError),
    ref.watch(dateOfBirthProvider),
    ref.watch(errorNameProvider),
    dateValidator(ref.watch(dateOfBirthProvider)),
  ];


  return errors.every((element) {
    print('element => $element');
    return element?.isEmpty ?? false;
  });
});

final isSignupProvider = StateProvider<bool>((ref) {
  return [
    ref.watch(emailInputProvider),
    ref.watch(passwordInputProvider),
    ref.watch(confirmPasswordInputProvider),
    ref.watch(nameInputProvider),
    ref.watch(dateOfBirthProvider),
    ref.watch(phoneInputProvider),
    ref.watch(codeInputProvider),
  ].every((element) => element.isNotEmpty);
});