class PhoneValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final phoneRegex = RegExp(r'^\d{3}-\d{4}-\d{4}$');
    return phoneRegex.hasMatch(value) ? null : '올바른 전화번호 형식을 입력해 주세요 (010-1234-5678)';
  }
}