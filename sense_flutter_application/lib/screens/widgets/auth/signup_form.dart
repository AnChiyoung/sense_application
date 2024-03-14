import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sense_flutter_application/screens/widgets/common/count_down_timer.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
// import 'package:sense_flutter_application/screens/widgets/common/date_input_group.dart';
import 'package:sense_flutter_application/screens/widgets/common/input_text_field.dart';
// import 'package:sense_flutter_application/providers/auth/register_provider.dart';
// import 'package:sense_flutter_application/utils/color_scheme.dart';
// import 'package:sense_flutter_application/utils/utils.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  
  TextEditingController emailController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        padding: const EdgeInsets.only(bottom: 48),
        constraints: BoxConstraints(
          maxWidth: screenWidth > 780 ? 500 : 375,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            InputTextField(
              height: 40,
              label: '이메일 주소',
              controller: emailController,
              onChanged: (String value) {
                
              },
              placeholder: 'sens@runners.im',
              suffixIcon: IconButton(
                onPressed: () {
                  // 
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 20
                )
              ),
              append:
                CustomButton(
                  labelText: '중복확인',
                  backgroundColor: const Color(0XFFBBBBBB),
                  textColor: Colors.white,
                  onPressed: () async {

                  },
                )
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '비밀번호',
              onChanged: (String value) {
                
              },
              isObscure: true,
              placeholder: '비밀번호를 입력해주세요텍스트',
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {
                  
                },
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '비밀번호 확인',
              onChanged: (String value) {

              },
              isObscure: true,
              placeholder: '비밀번호를 입력해주세요텍스트',
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {

                },
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      );
  }
}

