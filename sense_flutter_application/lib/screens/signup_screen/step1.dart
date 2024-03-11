
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/screens/layouts/login_layout.dart';
import 'package:sense_flutter_application/screens/widgets/auth/signup_policy_agreement.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/providers/auth/sign_up_provider.dart';

class Step1 extends ConsumerWidget {
  const Step1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final all = ref.watch(policyAgreementProvider).toList();
    bool canProceed() {
      return all.every((element) => !element.isRequired || (element.isRequired && element.isSelected));
    }

    return LoginLayout(
        body: SafeArea(
          child: Stack(
          children: [
            const Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: SignupPolicyAgreement(),),
            ),

            // Bottom button
            Positioned(
              bottom: 8.0,
              left: 20,
              right: 20,
              child: CustomButton(
                height: 48,
                onPressed: () {
                  if(canProceed()) {
                    GoRouter.of(context).go('/auth/signup/step2');
                  }
                },
                backgroundColor: canProceed() ? Colors.blue : Colors.grey,
                labelText: "동의하기",
                textColor: Colors.white,
              ),
            ),
          ],
        ),
        )
    );
  }
}
