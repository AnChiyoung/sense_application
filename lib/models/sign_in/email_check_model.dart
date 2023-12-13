import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/api/api_path.dart';

class EmailCheckRequest {
  Future<bool> emailCheckRequest(String checkEmail) async {
    Map<String, dynamic> emailCheckModel = {
      "email": checkEmail,
    };

    final response = await http.post(
      Uri.parse('${ApiUrl.releaseUrl}/user/email/check'),
      body: emailCheckModel,
    );

    if (response.statusCode == 400) {
      print('code 400');
      return true;
    } else {
      print('code non 400');
      return false;
    }
  }
}
