import 'package:http/http.dart' as http;

class PhoneAuthModel {
  Future<void> phoneAuthRequest(String phoneNumber) async {
    print(phoneNumber);
    Map<String, dynamic> sendNumberModel = SendNumberModel(phoneNumber: phoneNumber.toString()).toJson();
    print(sendNumberModel.toString());
    var aa = {
      'phone': '01066300387'
    };
    var response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/user/phone/send'),
      body: aa,
      headers: {'Content-Type': 'application/json'});
    print(response);
    // if(response.statusCode == 200) {
    //   print('bb');
    //   String jsonData = response.body;
    //   print(jsonData);
    //   return true;
    // } else {
    //   print('cc');
    //   return false;
    // }
  }
}

class SendNumberModel {
  String phoneNumber;

  SendNumberModel({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'phone': phoneNumber,
  };
}

class AuthModel {
  int? id;
  String? toNumber;
  bool? isSent;
  DateTime? expired;

  AuthModel({
    this.id,
    this.toNumber,
    this.isSent,
    this.expired,
  });

  AuthModel.fromJson(dynamic json) {
    id = json['id'] ?? -1;
    toNumber = json['to_number'] ?? '';
    isSent = json['is_sent'] ?? false;
    expired = json['expired'] ?? DateTime.now();
  }
}