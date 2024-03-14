import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/common/count_down_timer.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/date_input_group.dart';
import 'package:sense_flutter_application/screens/widgets/common/input_text_field.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class RegisterForm extends ConsumerWidget {

  final String emailError = "";

  RegisterForm({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt();
    String email = ref.watch(emailInputProvider);
    String ?emailError = ref.watch(emailErrorProvider);
    bool ?isEmailAvailable = ref.watch(isEmailAvailableProvider);
    String phone = ref.watch(phoneInputProvider);
    Gender ?gender = ref.watch(genderProvider);
    bool isCodeVerified = ref.watch(isCodeVerifiedProvider);

    // Debouncer
    var onEmailChange = debounce<String>((String value) {
      ref.read(emailInputProvider.notifier).state = value;
      ref.read(emailErrorProvider.notifier).state = '';
      ref.read(isEmailAvailableProvider.notifier).state = null;
    }, const Duration(milliseconds: 500));

    var onBirthDateChange = debounce<String>((String value) {
      ref.read(dateOfBirthProvider.notifier).state = value;
    }, const Duration(milliseconds: 500));

    var onPhoneNumberChange = debounce<String>((String value) {
      ref.read(phoneInputProvider.notifier).state = value;
      ref.read(isCodeVerifiedProvider.notifier).state = false;
      ref.read(expirationTimeProvider.notifier).state = '';
      ref.read(codeInputProvider.notifier).state = '';
    }, const Duration(milliseconds: 500));

    var onCodeInputChange = debounce<String>((String value) {
      ref.read(codeInputProvider.notifier).state = value;
      ref.read(codeInputError.notifier).state = '';
    }, const Duration(milliseconds: 500));

    var onNameInputChange = debounce<String>((String value) {
      ref.read(nameInputProvider.notifier).state = value;
    }, const Duration(milliseconds: 500));
    
    return 
      Container(
        padding: const EdgeInsets.only(bottom: 48),
        constraints: BoxConstraints(
          maxWidth: screenWidth > 780 ? 500 : 375,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: 
                    InputTextField(
                      height: 40,
                      label: '이메일 주소',
                      onChanged: (String value) {
                        onEmailChange(value);
                      },
                      initialValue: 'adem@gmail.coms',
                      placeholder: 'sens@runners.im',
                      errorMessage: emailValidator(email) ?? emailError,
                      suffixIcon: IconButton(
                        onPressed: () {
                          if((isEmailAvailable ?? false) == false) return;
                          showSnackBar(context, '이미 사용중인 이메일입니다.');
                        },
                        icon: Icon(
                          Icons.done,
                          color: (isEmailAvailable ?? false ? Colors.green : Colors.transparent),
                          size: 20
                        )
                      ),
                      append:
                        CustomButton(
                          labelText: '중복확인',
                          backgroundColor: email.isNotEmpty && emailValidator(email)?.isEmpty != false && emailError?.isEmpty != false ? const Color(0XFF555555) : const Color(0XFFBBBBBB),
                          textColor: Colors.white,
                          onPressed: () async {
                            var mailResponse = await ref.read(authRepositoryProvider).checkEmail(email);

                            if (mailResponse['status']) {
                              ref.read(emailErrorProvider.notifier).state = '';
                              ref.read(isEmailAvailableProvider.notifier).state = true;
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
                ref.read(passwordInputProvider.notifier).state = value;
              },
              isObscure: ref.watch(isObscureProvider1),
              placeholder: '비밀번호를 입력해주세요텍스트',
              suffixIcon: IconButton(
                icon: ref.watch(isObscureProvider1) ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {
                  ref.read(isObscureProvider1.notifier).state = !ref.read(isObscureProvider1);
                },
                padding: EdgeInsets.zero,
              ),
              errorMessage: ref.watch(errorPasswordProvider),
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '비밀번호 확인',
              onChanged: (String value) {
                ref.read(confirmPasswordInputProvider.notifier).state = value;
              },
              isObscure: ref.watch(isObscureProvider2),
              placeholder: '비밀번호를 입력해주세요텍스트',
              suffixIcon: IconButton(
                icon: ref.watch(isObscureProvider2) ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {
                  ref.read(isObscureProvider2.notifier).state = !ref.read(isObscureProvider2);
                },
                padding: EdgeInsets.zero,
              ),
              errorMessage: ref.watch(confirmPasswordErrorProvider),
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '이름',
              onChanged: (String value) {
                onNameInputChange(value);
              },
              isObscure: false,
              placeholder: '김센스',
              errorMessage: ref.watch(errorNameProvider),
            ),
            const SizedBox(height: 16),
            DateInputGroup(
              label: '생년월일',
              onChanged: (String value) {
                if (value != '--') {
                  onBirthDateChange(value);
                }
              },
              errorMessage: dateValidator(ref.watch(dateOfBirthProvider)),
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
                    backgroundColor: gender == Gender.male ? primaryColor[50]! : const Color(0XFFBBBBBB),
                    textColor: const Color(0XFFFFFFFF),
                    onPressed: () {
                      ref.read(genderProvider.notifier).state = Gender.male;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomButton(
                    labelText: '남성',
                    backgroundColor: gender == Gender.female ? primaryColor[50]! : const Color(0XFFBBBBBB),
                    textColor: const Color(0XFFFFFFFF),
                    onPressed: () {
                      ref.read(genderProvider.notifier).state = Gender.female;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            InputTextField(
              height: 40,
              label: '연락처',
              onChanged: (String value) {
                onPhoneNumberChange(value);
              },
              placeholder: '010-1234-5678',
              mask: [phoneMask],
              errorMessage: phoneValidator(phone),
              append: SizedBox(
                width: 97,
                child: CustomButton(
                  labelText: '인증받기',
                  backgroundColor: (phoneValidator(phone)?.isEmpty ?? true && (phone.isNotEmpty) && !isCodeVerified) ? const Color(0XFF555555) : const Color(0XFFBBBBBB),
                  textColor: Colors.white,
                  onPressed: () async {
                    if (isCodeVerified) return;
                    ref.read(expirationTimeProvider.notifier).state = '';
                    var response = await ref.watch(authRepositoryProvider)
                                    .sendCode(phone);
                    if (response['code'] == 200) {
                      ref.read(expirationTimeProvider.notifier).state = response['data']['expired'];
                    }
                  },
                )
              ),
            ),
            if (ref.watch(expirationTimeProvider).isNotEmpty || isCodeVerified)
                Column(
                  children: [
                    const SizedBox(height: 24),
                    InputTextField(
                      height: 40,
                      label: '인증번호',
                      onChanged: (String value) {
                        onCodeInputChange(value);
                      },
                      suffixIcon: isCodeVerified 
                        ? const Icon(Icons.done, color: Colors.green, size: 20,) 
                        : CountDownTimer(endTime: ref.watch(expirationTimeProvider)),
                      placeholder: '',
                      errorMessage: ref.watch(codeInputError),
                      append: SizedBox(
                        width: 97,
                        child: CustomButton(
                          labelText: '확인',
                          backgroundColor: ref.watch(codeInputProvider).isNotEmpty ? const Color(0XFF555555) : const Color(0XFFBBBBBB),
                          textColor: Colors.white,
                          onPressed: () async {
                            if (isCodeVerified) return;

                             var response = await ref.watch(authRepositoryProvider)
                              .verifyCode(phone, ref.watch(codeInputProvider));
                            
                            bool isValid = response['code'] == 200;

                            if (isValid) {
                              ref.read(isCodeVerifiedProvider.notifier).state = isValid;
                              ref.read(expirationTimeProvider.notifier).state = '';
                            } else {
                              ref.read(codeInputError.notifier).state = '인증번호가 일치하지 않습니다.';
                            }
                          },
                        )
                      ),
                    )
                  ],
                )
          ],
        )
      );
  }
}

