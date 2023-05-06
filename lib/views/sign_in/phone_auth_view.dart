import 'package:flutter/material.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';

class PhoneAuthHeader extends StatelessWidget {
  const PhoneAuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false);
  }
}

class PhoneAuthDescription extends StatelessWidget {
  const PhoneAuthDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
        child: SigninDescription(description: '인증번호 4자리를\n입력해 주세요')
    );
  }
}

class PhoneAuthInputField extends StatefulWidget {
  String phoneNumber;
  PhoneAuthInputField({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneAuthInputField> createState() => _PhoneAuthInputFieldState();
}

class _PhoneAuthInputFieldState extends State<PhoneAuthInputField> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PhoneAuthModel().phoneAuthRequest(widget.phoneNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container();
      }
    );
  }
}
