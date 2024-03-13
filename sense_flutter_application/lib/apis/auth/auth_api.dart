import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthApi {
  Future<Map<String, dynamic>> checkEmail(String email) async {
    final response = await http.post(
      Uri.parse('https://server.dev.sens.im/api/v1/user/email/check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      return { 'status': true };
    } else {
      var parse = json.decode(utf8.decode(response.bodyBytes));
      var nonFieldError = parse['errors']['non_field_errors'];
      print(nonFieldError);
      return {'status': false, 'message': nonFieldError?.isNotEmpty ? nonFieldError[0] : parse['message'] };
    }
  }

}