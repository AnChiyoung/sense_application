
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/models/user.dart';
import 'package:sense_flutter_application/screens/layouts/login_layout.dart';
import 'package:sense_flutter_application/screens/widgets/auth/register_form.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class Step2 extends ConsumerWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    bool canProceed() {
      return ref.watch(isSignupProvider) && ref.watch(withNoErrorsMessagesProvider);
    }

    void fillErrors() {
      if (ref.watch(emailInputProvider) == '') {
        ref.read(emailErrorProvider.notifier).state = '이메일을 입력해주세요';
      } 
      
      if(ref.watch(isEmailAvailableProvider) == null || ref.watch(isEmailAvailableProvider) == false) {
        ref.read(emailErrorProvider.notifier).state = '이메일이 확인되지 않았습니다.';
      }

      if (ref.watch(selectedGender).isEmpty) {
        ref.read(genderErrorProvider.notifier).state = '성별을 선택해 주세요';
      }

      if(ref.watch(passwordInputProvider) == '') {
        ref.read(passwordErrorProvider.notifier).state = '비밀번호는 필수입니다';
      }

      if (ref.watch(nameInputProvider) == '') {
        ref.read(nameErrorProvider.notifier).state = '이름은 필수입니다';
      }

      if (ref.watch(dateOfBirthProvider) == '') {
        ref.read(dateOfBirthErrorProvider.notifier).state = '생년월일은 필수입니다';
      }

      if (ref.watch(phoneInputProvider) == '') {
        ref.read(phoneErrorProvider.notifier).state = '휴대폰 번호는 필수입니다';
      }

      if(ref.watch(isCodeVerifiedProvider) == false) {
        ref.read(codeInputErrorProvider.notifier).state = '코드가 확인되지 않았습니다.';
      }
    }

    return LoginLayout(
        body: SafeArea(
          child:
            Container (
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
                          '회원가입',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          )
                        )
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 0, bottom: 8),
                      margin: const EdgeInsets.only(bottom: 24, left: 0, right: 0,),
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
                              '01  약관동의',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0XFFE0E0E0)
                              )
                            ),
                            SizedBox(width: 16),
                            Text(
                              '02 개인정보 입력',
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
                        child: RegisterForm(),
                      ),
                    ),

                    // Bottom button
                    Container(
                      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                      child: 
                        CustomButton(
                          height: 48,
                          onPressed: () async {
                            if(canProceed()) {
                                var response = await ref.watch(authRepositoryProvider).register(
                                  User(
                                    email: ref.watch(emailInputProvider) ?? '', 
                                    birthday: ref.watch(dateOfBirthProvider) ?? '',
                                    phone: ref.watch(phoneInputProvider) ?? '',
                                    gender: ref.watch(selectedGender) ?? '',
                                    password: ref.watch(passwordInputProvider) ?? '',
                                  )
                                );

                                if (response['code'] == 200) {
                                  showSnackBar(context, '성공적으로 등록되었습니다!', onDismissed: () {
                                    GoRouter.of(context).go('/login');
                                  
                                  });
                                }
                            } else {
                              fillErrors();
                            }
                          },
                          backgroundColor: canProceed() ? Colors.blue : Colors.grey,
                          labelText: "동의하기",
                          textColor: Colors.white,
                        )
                    )
                  ],
                )
            )
        )
    );
  }
}
