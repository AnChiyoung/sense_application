import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/kakao_user_info_model.dart';
import 'package:sense_flutter_application/screens/sign_in/basic_info_screen.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_validate.dart';

class EmailHeader extends StatelessWidget {
  const EmailHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false);
  }
}

class EmailDescription extends StatelessWidget {
  const EmailDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
        child: SigninDescription(presentPage: 2, totalPage: 3, description: '로그인 정보를\n입력해 주세요')
    );
  }
}

class EmailPasswordInputField extends StatefulWidget {
  KakaoUserModel? presetInfo;
  EmailPasswordInputField({Key? key, this.presetInfo}) : super(key: key);

  @override
  State<EmailPasswordInputField> createState() => _EmailPasswordInputFieldState();
}

class _EmailPasswordInputFieldState extends State<EmailPasswordInputField> {

  late TextEditingController emailInputController;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReinputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode passwordRepeatFocusNode = FocusNode();

  bool emailState = false;
  bool passwordState = false;
  bool passwordRepeatState = false;

  KakaoUserModel? kakaoUserModel;

  @override
  void initState() {
    kakaoUserModel = widget.presetInfo;
    print('email??????? : ${kakaoUserModel?.email}');
    String email = kakaoUserModel?.email ?? '';
    emailInputController = TextEditingController(text: email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String inputPassword = '';

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Stack(
              children: [
                Consumer<SigninProvider>(
                  builder: (context, data, child) => Container(
                    height: 68,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: StaticColor.loginInputBoxColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: data.emailValidateState == true ? StaticColor.errorColor : Colors.transparent, width: 2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: emailInputController,
                    autofocus: true,
                    focusNode: emailFocusNode,
                    readOnly: kakaoUserModel?.email == null ? false : true,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.always,
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      labelText: '이메일 주소',
                      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      hintText: '이메일 주소를 입력해 주세요',
                      hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value!.length > 0 && SigninValidate().emailValidate(value!) == false) {
                        emailState = false;
                        /// validate의 렌더링이 완료되지 않은 시점에 provider로 재빌드를 시도하면 marks needs build 에러 송출. 렌더링 프레임 종료 후 실행되도록 변경
                        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                          context.read<SigninProvider>().emailValidateStateChange(true);
                        });
                        return '이메일 형식을 확인해 주세요';
                      } else {
                        value.length > 0 ? emailState = true : emailState = false;
                        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                          context.read<SigninProvider>().emailValidateStateChange(false);
                          context.read<SigninProvider>().emailPasswordButtonStateChange(emailState && passwordState && passwordRepeatState);
                        });
                        return null;
                      }
                    },
                    onFieldSubmitted: (f) {
                      FocusScope.of(context).requestFocus(passwordFocusNode);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Consumer<SigninProvider>(
                  builder: (context, data, child) => Container(
                    height: 68,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: StaticColor.loginInputBoxColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: data.passwordValidateState == true ? StaticColor.errorColor : Colors.transparent, width: 2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.always,
                    obscureText: true,
                    maxLines: 1,
                    maxLength: 16,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: '비밀번호',
                      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      hintText: '비밀번호를 입력해 주세요',
                      hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      // passwordState = false;
                      // if (value!.length > 0 && SigninValidate().passwordValidate(value) == false) {
                      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      //     context.read<SigninProvider>().passwordValidateStateChange(true);
                      //   });
                      //   return '영문 소문자, 숫자 포함 6~16글자로 입력해주세요';
                      // } else {
                      //   value.length > 0 ? passwordState = true : passwordState = false;
                      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      //     context.read<SigninProvider>().passwordValidateStateChange(false);
                      //     context.read<SigninProvider>().emailPasswordButtonStateChange(emailState && passwordState && passwordRepeatState);
                      //   });
                      //   return null;
                      // }
                    },
                    onFieldSubmitted: (f) {
                      FocusScope.of(context).requestFocus(passwordRepeatFocusNode);
                    },
                    onChanged: (value) {
                      inputPassword = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Consumer<SigninProvider>(
                  builder: (context, data, child) => Container(
                    height: 68,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: StaticColor.loginInputBoxColor,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: data.repeatPasswordValidateState == true ? StaticColor.errorColor : Colors.transparent, width: 2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: passwordReinputController,
                    focusNode: passwordRepeatFocusNode,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.always,
                    obscureText: true,
                    maxLines: 1,
                    maxLength: 16,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      counterText: '',
                      labelText: '비밀번호 확인',
                      labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      hintText: '비밀번호를 확인해 주세요',
                      hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      // if (value!.length > 0 && inputPassword != value) {
                      //   passwordRepeatState = false;
                      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      //     context.read<SigninProvider>().repeatPasswordValidateStateChange(true);
                      //   });
                      //   return '비밀번호가 일치하지 않아요';
                      // } else {
                      //   value.length > 0 ? passwordRepeatState = true : passwordRepeatState = false;
                      //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                      //     // context.read<SigninProvider>().repeatPasswordValidateStateChange(false);
                      //     // context.read<SigninProvider>().emailPasswordButtonStateChange(emailState && passwordState && passwordRepeatState);
                      //   });
                      //   return null;
                      // }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmailButton extends StatefulWidget {
  const EmailButton({Key? key}) : super(key: key);

  @override
  State<EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<EmailButton> {

  Future backButtonAction(BuildContext context) async {
    // context.read<AddEventProvider>().dateSelectNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonState = context.watch<SigninProvider>().emailPasswordButtonState;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () {
              // buttonState == true ? Navigator.push(context, MaterialPageRoute(builder: (_) => BasicInfoScreen())) : {};
              Navigator.push(context, MaterialPageRoute(builder: (_) => BasicInfoScreen()));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonState == true
                    ? StaticColor.categorySelectedColor
                    : StaticColor.unSelectedColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: const [
              SizedBox(
                  height: 56,
                  child: Center(
                      child: Text('다음',
                          style: TextStyle(
                              fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
            ])),
      ),
    );
  }
}
