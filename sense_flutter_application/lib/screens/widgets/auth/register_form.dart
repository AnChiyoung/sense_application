import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/input_text_field.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';
import 'package:sense_flutter_application/utils/regex.dart';

class RegisterForm extends ConsumerWidget {

  final TextEditingController emailController = TextEditingController();
  final String emailError = "";

  RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt();
    String email = ref.watch(emailInputProvider);
    String ?emailError = ref.watch(emailErrorProvider);

    print('emailValidator(email) ?? ${emailValidator(email) ?? emailError}');
    
    return 
      Container(
        padding: const EdgeInsets.only(bottom: 48),
        constraints: BoxConstraints(
          maxWidth: screenWidth > 780 ? 500 : 375,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: 
                    InputTextField(
                      height: 40,
                      label: '이메일 주소',
                      controller: emailController,
                      onChanged: (String value) {
                        ref.read(emailInputProvider.notifier).state = value;
                      },
                      placeholder: 'sens@runners.im',
                      errorMessage: emailValidator(email) ?? emailError,
                      append: 
                        CustomButton(
                          labelText: '중복확인',
                          backgroundColor: const Color(0XFF555555),
                          textColor: Colors.white,
                          onPressed: () async {
                            var mailResponse = await ref.read(checkMailRepositoryProvider).checkEmail(email);

                            if (mailResponse['status']) {
                              ref.read(emailErrorProvider.notifier).state = '';
                            } else {
                              ref.read(emailErrorProvider.notifier).state = mailResponse['message'];
                            }
                          },
                        )
                    )
                ),
              ],
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '비밀번호',
              onChanged: (String value) {

              },
              isObscure: true,
              placeholder: '비밀번호를 입력해주세요텍스트',
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '비밀번호 확인',
              onChanged: (String value) {

              },
              isObscure: true,
              placeholder: '비밀번호를 입력해주세요텍스트',
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '이름',
              onChanged: (String value) {

              },
              isObscure: true,
              placeholder: '김센스',
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InputTextField(
                    label: '생년월일',
                    onChanged: (String value) {

                    },
                    placeholder: 'YYYY',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputTextField(
                    label: '',
                    onChanged: (String value) {

                    },
                    placeholder: 'MM',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputTextField(
                    label: '',
                    onChanged: (String value) {

                    },
                    placeholder: 'DD',
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: const Text('성별'),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    labelText: '여성',
                    backgroundColor: const Color(0XFFBBBBBB),
                    textColor: const Color(0XFFFFFFFF),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomButton(
                    labelText: '남성',
                    backgroundColor: const Color(0XFFBBBBBB),
                    textColor: const Color(0XFFFFFFFF),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: 
                    InputTextField(
                      height: 40,
                      label: '연락처',
                      onChanged: (String value) {

                      },
                      placeholder: '010-1234-5678',
                    )
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 97,
                  child: CustomButton(
                    labelText: '인증받기',
                    backgroundColor: const Color(0XFF555555),
                    textColor: Colors.white,
                    onPressed: () {},
                  )
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: 
                    InputTextField(
                      height: 40,
                      label: '인증번호',
                      onChanged: (String value) {

                      },
                      placeholder: '',
                    )
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 97,
                  child: CustomButton(
                    labelText: '확인',
                    backgroundColor: const Color(0XFF555555),
                    textColor: Colors.white,
                    onPressed: () {},
                  )
                )
              ],
            ),
          ],
        )
      );
  }
}

