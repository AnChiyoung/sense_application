import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/screens/widgets/auth/validator/password_validator.dart';
import 'package:sense_flutter_application/screens/widgets/common/count_down_timer.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_button.dart';
import 'package:sense_flutter_application/screens/widgets/common/custom_toast.dart';
import 'package:sense_flutter_application/screens/widgets/common/date_input_group.dart';
import 'package:sense_flutter_application/screens/widgets/common/input_text_field.dart';
import 'package:sense_flutter_application/providers/auth/register_provider.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:sense_flutter_application/utils/utils.dart';
import './validator/index.dart';


class VerifiCationFields  {
  final String password;
  final String passwordConfirm;

  VerifiCationFields({required this.password, required this.passwordConfirm});

  factory VerifiCationFields.fromJson(Map<String, dynamic> json) {
    return VerifiCationFields(
      password: json['password'],
      passwordConfirm: json['passwordConfirm'],
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {

  final Function(VerifiCationFields) onChanged;

  
  const ForgotPasswordForm({super.key, required this.onChanged});
  
  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  
  String password = '';
  String passwordConfirm = '';
  String errorMessages = '';
  String confirmErrorMessage = '';
  bool isPasswordObscure = true;
  bool isPassworConfirmdObscure = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
     super.setState(fn);
     widget.onChanged(VerifiCationFields(password: password, passwordConfirm: passwordConfirm));
  }

  String confirmPasswordValidate() {
    return passwordConfirm != password ? '새 비밀번호가 일치하지 않습니다' : '';
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt(); 
    var onChangedPassword = debounce<String>((String value) {
        setState(() {
          password = value;
          errorMessages = PasswordValidator.validate(value) ?? '';
          confirmErrorMessage = passwordConfirm.isEmpty ? '' : confirmPasswordValidate();
        });
      }, const Duration(milliseconds: 500));
    var onChangedConfirmPassword = debounce<String>((String value) {
        setState(() {
          passwordConfirm = value;
          confirmErrorMessage = confirmPasswordValidate();
        });
      }, const Duration(milliseconds: 500));

    return 
      Container(
        padding: const EdgeInsets.only(bottom: 20, left: 0, right: 0, top: 0),
        constraints: BoxConstraints(
          maxWidth: screenWidth > 768 ?  500 : double.infinity,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            // Password Field
            InputTextField(
              height: 40,
              label: '비밀번호',
              onChanged: (String value) {
                onChangedPassword(value);
              },
              // isObscure: isPasswordObscure,
              placeholder: '비밀번호를 입력해주세요',
              suffixIcon: IconButton(
                icon: isPasswordObscure ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {
                  setState(() { isPasswordObscure = !isPasswordObscure; });
                },
                padding: EdgeInsets.zero,
              ),
              errorMessage: errorMessages,
            ),
            const SizedBox(height: 16),

            // Confirm Password Field
            InputTextField(
              height: 40,
              label: '비밀번호 확인',
              onChanged: (String value) {
                onChangedConfirmPassword(value);
              },
              // isObscure: isPassworConfirmdObscure,
              placeholder: '비밀번호를 확인해 주세요',
              suffixIcon: IconButton(
                icon: isPassworConfirmdObscure ? const Icon(Icons.visibility_off_outlined) : const Icon(Icons.visibility_outlined),
                color: const Color(0XFFBBBBBB),
                onPressed: () {
                  setState(() { isPassworConfirmdObscure = !isPassworConfirmdObscure; });
                },
                padding: EdgeInsets.zero,
              ),
              errorMessage: confirmErrorMessage
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
  }
}