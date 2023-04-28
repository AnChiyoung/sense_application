import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/sign_in/policy_screen.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';

class LogoView extends StatefulWidget {
  const LogoView({Key? key}) : super(key: key);

  @override
  State<LogoView> createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset('assets/login/temperature_logo.png', width: 197, height: 47),
      ),
    );
  }
}


class LoginFormView extends StatefulWidget {
  const LoginFormView({Key? key}) : super(key: key);

  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}

class _LoginFormViewState extends State<LoginFormView> {

  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String autoLoginImage = 'check_empty.png';
    final autoLoginState = context.watch<LoginProvider>().autoLoginState;
    autoLoginState == true ? autoLoginImage = 'check_done.png' : autoLoginImage = 'check_empty.png';

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 56),
        child: Column(
          children: [
            /// email input field
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: emailFieldController,
                decoration: InputDecoration(
                  hintText: '이메일 주소',
                  hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {print('tap!');},
              ),
            ),
            const SizedBox(height: 8),
            /// password input field
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: StaticColor.loginInputBoxColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: passwordFieldController,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Material(
              color: StaticColor.mainSoft,
              borderRadius: BorderRadius.circular(4.0),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(4.0), // inkwell effect's borderradius
                child: const SizedBox(
                  height: 50,
                  child: Center(child: Text('로그인', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600))),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<LoginProvider>().autoLoginBoxState(!autoLoginState);
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/login/$autoLoginImage', width: 20, height: 20),
                        const SizedBox(width: 8),
                        Text('자동로그인', style: TextStyle(fontSize: 12, color: StaticColor.loginTextColor03, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 80,
                    height: 20,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('비밀번호 찾기', style: TextStyle(fontSize: 12, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)))
                  )
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class KakaoLoginButton extends StatefulWidget {
  const KakaoLoginButton({Key? key}) : super(key: key);

  @override
  State<KakaoLoginButton> createState() => _KakaoLoginButtonState();
}

class _KakaoLoginButtonState extends State<KakaoLoginButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20,top: 40, bottom: 72),
        child: Material(
          color: StaticColor.loginKakaoColor,
          borderRadius: BorderRadius.circular(4.0),
          child: InkWell(
            onTap: () {
              /// 카카오 로그인 로직 삽입해야 함
              Navigator.push(context, MaterialPageRoute(builder: (_) => PolicyScreen()));
            },
            borderRadius: BorderRadius.circular(4.0), // inkwell effect's borderradius
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/kakao_simple_icon.png', width: 24, height: 24),
                  const SizedBox(width: 4),
                  Text('카카오로 로그인', style: TextStyle(fontSize: 14, color: StaticColor.loginTextColor02, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            /// text
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('아직 ', style: TextStyle(fontSize: 14, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
                    Align(
                      alignment: Alignment.center,
                      child: Text('SENSE', style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w500))),
                    Text(' 회원이 아니신가요?', style: TextStyle(fontSize: 14, color: StaticColor.loginTextColor01, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            /// sign in button
            Padding(
              padding: const EdgeInsets.only(bottom: 51),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border.all(color: StaticColor.mainSoft, width: 1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Text('회원가입', style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w500)),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
