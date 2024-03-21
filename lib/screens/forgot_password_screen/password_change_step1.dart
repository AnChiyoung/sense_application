
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/models/policy_agreement.dart';
import 'package:sense_flutter_application/screens/layouts/auth_layout.dart';
import 'package:sense_flutter_application/screens/widgets/auth/forgot_password_form.dart';
import 'package:sense_flutter_application/screens/widgets/auth/signup_policy_agreement.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/providers/auth/policy_provider.dart';
import 'package:sense_flutter_application/screens/widgets/common/policy_content.dart';

class PasswordChangeStep1 extends StatefulWidget {
  const PasswordChangeStep1({super.key});
  
  @override
  State<PasswordChangeStep1> createState() => _PasswordChangeStep1State();

  
}

class _PasswordChangeStep1State extends State<PasswordChangeStep1> {

  bool isCodeVerified = false;

  @override
  Widget build(BuildContext context) {

    bool canProceed() {
      return isCodeVerified;
    }

    return 
      AuthLayout(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: 
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    margin: const EdgeInsets.only(bottom: 24),
                    child: 
                      const Text(
                        '비밀번호를 잊으셨나요?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        )
                      )
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 0, bottom: 0),
                    margin: const EdgeInsets.only(bottom: 20, left: 0, right: 0,),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0XFFE0E0E0),
                          width: 1
                        )
                      )
                    ),
                    child: 
                      const Row(
                        children: [
                          Text(
                            '01 핸드폰 인증',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFF777777)
                            )
                          ),
                          SizedBox(width: 16),
                          Text(
                            '02 비밀번호 변경',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFFE0E0E0)
                            )
                          )
                        ],
                      )
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 0, right: 0),
                      child: ForgotPasswordForm(setValue: (bool value) { 
                          print('isCodeVerified');
                          setState(() {
                            isCodeVerified = value;
                          });
                       },),
                    ),
                  ),

                  // Bottom button
                  Container(
                    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                    child: 
                      CustomButton(
                        height: 48,
                        onPressed: () {
                          if(canProceed()) {
                          }
                        },
                        backgroundColor: canProceed() ? Colors.blue : Colors.grey,
                        labelText: "동의하기",
                        textColor: Colors.white,
                      )
                  ),
                ],
              ),
          )
        )
    );
  }
}