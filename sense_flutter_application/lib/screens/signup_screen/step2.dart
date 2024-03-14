
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/layouts/login_layout.dart';
import 'package:sense_flutter_application/screens/widgets/auth/signup_form.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';

class Step2 extends ConsumerWidget {
  const Step2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool canProceed() {
      print('withNoErrorsMessagesProvider');
      print(ref.watch(withNoErrorsMessagesProvider));
      return ref.watch(isSignupProvider) && ref.watch(withNoErrorsMessagesProvider);
    }

    return LoginLayout(
        body: SafeArea(
          child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
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
              margin: const EdgeInsets.only(bottom: 24, left: 20, right: 20,),
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

            const Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SignupForm(),
              ),
            ),

            // Bottom button
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: 
                CustomButton(
                  height: 48,
                  onPressed: () {
                    if(canProceed()) {
                      GoRouter.of(context).go('/auth/signup/step2');
                    }
                  },
                  backgroundColor: canProceed() ? Colors.blue : Colors.grey,
                  labelText: "동의하기",
                  textColor: Colors.white,
                )
            )
          ],
        ),
        )
    );
  }
}
