class PasswordValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    String pwd = value;
    RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
    
    if (pwd.isEmpty) {
      return null;
    } else if (!passwordRegex.hasMatch(pwd)) {
      return '문자와 숫자를 조합하여 8자 이상 입력해주세요.';
    }
    else if (pwd.length < 8) {
      return '비밀번호는 8자 이상이어야 합니다.';
    }
    
    return null;
  }
}