
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/layouts/auth_layout.dart';
import 'package:sense_flutter_application/screens/widgets/auth/forgot_password_form.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_modal.dart';

class PasswordChangeStep2 extends StatefulWidget {
  const PasswordChangeStep2({super.key});
  
  @override
  State<PasswordChangeStep2> createState() => _PasswordChangeStep2State();

  
}

class _PasswordChangeStep2State extends State<PasswordChangeStep2> {

  String password = '';
  String passwordConfirm = '';

  @override
  Widget build(BuildContext context) {

    bool canProceed() {
      return password.isNotEmpty && passwordConfirm.isNotEmpty && password == passwordConfirm;
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
                              color: Color(0XFFE0E0E0)
                            )
                          ),
                          SizedBox(width: 16),
                          Text(
                            '02 비밀번호 변경',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0XFF777777)
                            )
                          )
                        ],
                      )
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: ForgotPasswordForm(
                        onChanged: (VerifiCationFields value) { 
                          setState(() {
                            password = value.password;
                            passwordConfirm = value.passwordConfirm;
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
                            CustomModal.showModal(
                              context,
                              title: '비밀번호가 변경되었어요',
                              message: '비밀번호가 정상적으로 변경되었어요.'
                              '변경된 비밀번호로 로그인을 시도해 주세요!',
                              buttonLabel: '확인',
                            );
                          }
                        },
                        backgroundColor: canProceed() ? Colors.blue : Colors.grey,
                        labelText: "비밀번호 재설정",
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