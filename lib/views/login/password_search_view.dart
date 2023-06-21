import 'package:flutter/material.dart';
import 'package:multi_masked_formatter/multi_masked_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_validate.dart';

class PasswordSearchInfoInputHeader extends StatefulWidget {
  const PasswordSearchInfoInputHeader({Key? key}) : super(key: key);

  @override
  State<PasswordSearchInfoInputHeader> createState() => _PasswordSearchInfoInputHeaderState();
}

class _PasswordSearchInfoInputHeaderState extends State<PasswordSearchInfoInputHeader> {
  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false, backButtonCallback: backButtonCallback);
  }

  void backButtonCallback() {
    Navigator.of(context).pop();
  }
}

class PasswordSearchInfoInputDescription extends StatelessWidget {
  const PasswordSearchInfoInputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
        child: SigninDescription(description: '비밀번호를\n잊으셨나요?')
    );
  }
}


class PasswordSearchInfoInputField extends StatefulWidget {
  const PasswordSearchInfoInputField({Key? key}) : super(key: key);

  @override
  State<PasswordSearchInfoInputField> createState() => _PasswordSearchInfoInputFieldState();
}

class _PasswordSearchInfoInputFieldState extends State<PasswordSearchInfoInputField> {

  TextEditingController emailInputController = TextEditingController();
  TextEditingController phoneNumberInputController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  bool emailState = false;
  bool phoneNumberState = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextFormField(
              controller: emailInputController,
              autofocus: true,
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.always,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                alignLabelWithHint: false,
                labelText: '이메일 주소',
                labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                hintText: '이메일 주소를 입력해 주세요',
                hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              validator: (value) {
                if(value!.isNotEmpty) {
                  if(SigninValidate().emailValidate(value!) == false) {
                    emailState = false;
                    return '이메일 형식을 확인해 주세요';
                  } else {
                    emailState = true;
                    return null;
                  }
                } else {
                  emailState = false;
                  return null;
                }
              },
              onChanged: (_) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  emailState && phoneNumberState == true
                      ? context.read<LoginProvider>().passwordSearchButtonStateChange(true, phoneNumberInputController.text.replaceAll('-', ''))
                      : context.read<LoginProvider>().passwordSearchButtonStateChange(false);
                });
              }
          ),
          const SizedBox(height: 8),
          TextFormField(
              controller: phoneNumberInputController,
              focusNode: phoneNumberFocusNode,
              inputFormatters: [
                MultiMaskedTextInputFormatter(masks: ['xxx-xxxx-xxxx', 'xxx-xxx-xxxx'], separator: '-')
              ],
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.always,
              maxLines: 1,
              maxLength: 16,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                errorBorder: OutlineInputBorder(borderSide: BorderSide(color: StaticColor.errorColor, width: 1)),
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                alignLabelWithHint: false,
                counterText: '',
                labelText: '연락처',
                labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                hintText: '000-0000-0000',
                hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              validator: (value) {
              },
              onChanged: (value) {
                if(value.length > 12) {
                  phoneNumberState = true;
                } else {
                  phoneNumberState = false;
                }

                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  emailState && phoneNumberState == true
                      ? context.read<LoginProvider>().passwordSearchButtonStateChange(true)
                      : context.read<LoginProvider>().passwordSearchButtonStateChange(false);
                });
              }
          ),
        ],
      ),
    );
  }
}


class PasswordSearchInfoInputButton extends StatefulWidget {
  const PasswordSearchInfoInputButton({Key? key}) : super(key: key);

  @override
  State<PasswordSearchInfoInputButton> createState() => _PasswordSearchInfoInputButtonState();
}

class _PasswordSearchInfoInputButtonState extends State<PasswordSearchInfoInputButton> {

  Future backButtonAction(BuildContext context) async {
    // context.read<AddEventProvider>().dateSelectNextButtonReset();
  }

  @override
  Widget build(BuildContext context) {

    final buttonState = context.watch<LoginProvider>().passwordSearchButtonState;
    final phoneNumber = context.watch<LoginProvider>().authPhoneNumber;

    return WillPopScope(
      onWillPop: () async {
        await backButtonAction(context);
        return true;
      },
      child: SizedBox(
        width: double.infinity,
        height: 76,
        child: ElevatedButton(
            onPressed: () async {
              // buttonState == true ? Navigator.push(context, MaterialPageRoute(builder: (_) => BasicInfoScreen())) : {};

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonState == true
                    ? StaticColor.categorySelectedColor
                    : StaticColor.unSelectedColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 56,
                      child: Center(
                          child: Text('다음',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                      ),
                  ),
                ],
            ),
        ),
      ),
    );
  }
}
