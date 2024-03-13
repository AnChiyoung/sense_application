import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/input_text_field.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';

class RegisterForm extends ConsumerWidget {

  final TextEditingController emailController = TextEditingController();
  final String emailError = "";

  RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt();
    String email = ref.watch(emailInputProvider);
    String ?emailError = ref.watch(emailErrorProvider);
    bool ?isEmailAvailable = ref.watch(isEmailAvailableProvider);
    Gender ?gender = ref.watch(genderProvider);

    // Debouncer
    var onChange = debounce<String>((String value) {
      ref.read(emailInputProvider.notifier).state = value;
      ref.read(emailErrorProvider.notifier).state = '';
      ref.read(isEmailAvailableProvider.notifier).state = null;
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
                      controller: emailController,
                      onChanged: (String value) {
                        onChange(value);
                      },
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
                            var mailResponse = await ref.read(checkMailRepositoryProvider).checkEmail(email);

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

              },
              isObscure: false,
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
                    mask: [yearMask],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputTextField(
                    label: '',
                    onChanged: (String value) {

                    },
                    placeholder: 'MM',
                    mask: [monthMask],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InputTextField(
                    label: '',
                    onChanged: (String value) {

                    },
                    placeholder: 'DD',
                    mask: [dayMask],
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

              },
              placeholder: '010-1234-5678',
              mask: [phoneMask],
              append: SizedBox(
                width: 97,
                child: CustomButton(
                  labelText: '인증받기',
                  backgroundColor: const Color(0XFF555555),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ),
            ),
            const SizedBox(height: 24),
            InputTextField(
              height: 40,
              label: '인증번호',
              onChanged: (String value) {

              },
              placeholder: '',
              append: SizedBox(
                width: 97,
                child: CustomButton(
                  labelText: '확인',
                  backgroundColor: const Color(0XFF555555),
                  textColor: Colors.white,
                  onPressed: () {},
                )
              ),
            )
          ],
        )
      );
  }
}

