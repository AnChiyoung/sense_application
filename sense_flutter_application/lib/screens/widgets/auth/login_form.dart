import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/screens/widgets/common/clickable_text.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_checkbox.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import '../common/input_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "";
  String password = "";
  bool isAutoLogin = false;


// Check for the email format
  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return null;
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    
    return emailRegex.hasMatch(email) ? null : '올바른 이메일 주소를 입력해 주세요';
  }

// Check if email and password are valid or filled
  bool isButtonEnabled() {
    return emailValidator(email) == null && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt();

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth > 780 ? 500 : double.infinity,
      ),
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        children: [
          InputTextField(
            label: '이메일',
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            controller: emailController,
            placeholder: '이메일을 입력해 주세요텍스트',
            errorMessage: emailValidator(email),
          ),

          const SizedBox(height: 24),

          InputTextField(
            label: '비밀번호',
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            controller: passwordController,
            placeholder: '비밀번호를 입력해 주세요텍스트',
            isObscure: true,
          ),

          const SizedBox(height: 12),
          // Auto Login & ForgotPassword Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomCheckbox(
                label: '자동로그인',
                isChecked: isAutoLogin,
                onChanged: () {
                  setState(() {
                    isAutoLogin = !isAutoLogin;
                  });
                }
              ),
              ClickableText(
                text: '비밀번호 찾기',
                onTap: () {
                  print('FORGOT PASSWORD CLICKED');
                }
              ),
            ],
          ),

          // Buttons
          const SizedBox(
            height: 48
          ),
          CustomButton(
            height: 48,
            backgroundColor: isButtonEnabled() ? primaryColor[50]! : const Color.fromRGBO(187, 187, 187, 1),
            labelText: '로그인',
            textColor: Colors.white,
            fontSize: 14,
          ),
          const SizedBox(
            height: 16
          ),
          CustomButton(
            height: 48,
            backgroundColor: const Color.fromRGBO(254, 229, 0, 1),
            labelText: '카카오로 시작하기',
            prefixIcon: SvgPicture.asset('lib/assets/images/svg/kakaotalk.svg', width: 20, height: 20),
            textColor: Colors.black,
            fontSize: 14,
          ),
          const SizedBox(
            height: 16
          ),
          Center(

            child: ClickableText(text: '이메일로 회원가입', onTap: () {},)
          )
        ],
      ),
    );
  }
}