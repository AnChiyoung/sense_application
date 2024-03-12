
// Check for the email format
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return null;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    
    return emailRegex.hasMatch(email) ? null : '올바른 이메일 주소를 입력해 주세요';
  }