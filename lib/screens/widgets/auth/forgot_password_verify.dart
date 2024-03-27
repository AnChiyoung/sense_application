import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
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
  final String phone;
  final String code;
  final bool isCodeVerified;

  VerifiCationFields({required this.phone, required this.code, required this.isCodeVerified});

  factory VerifiCationFields.fromJson(Map<String, dynamic> json) {
    return VerifiCationFields(
      phone: json['phone'],
      code: json['code'],
      isCodeVerified: json['isCodeVerified']
    );
  }
}
class ForgotPasswordVerify extends StatefulWidget {

  final Function(VerifiCationFields) onChanged;

  
  const ForgotPasswordVerify({super.key, required this.onChanged});
  
  @override
  State<ForgotPasswordVerify> createState() => _ForgotPasswordVerifyState();
}

class _ForgotPasswordVerifyState extends State<ForgotPasswordVerify> {

  
  String code = '';
  String errorMessages = '';
  String phone = '';
  String expirationTime = '';
  bool isVerification = false;
  bool isCodeVerified = false;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
     super.setState(fn);
     widget.onChanged(VerifiCationFields(phone: phone, code: code, isCodeVerified: isCodeVerified));
  }

  @override
  Widget build(BuildContext context) {
    int screenWidth =  MediaQuery.of(context).size.width.toInt(); 
    var onChanged = debounce<String>((String value) {
        setState(() {
          errorMessages = PhoneValidator.validate(value) ?? '';
          phone = value;
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InputTextField(
                    height: 40,
                    label: '연락처',
                    onChanged: (String value) {
                      onChanged(value);
                    },
                    placeholder: '010-1234-5678',
                    mask: [phoneMask],
                    errorMessage: errorMessages,
                    append: SizedBox(
                      width: 97,
                      child: CustomButton(
                        labelText: phone.isNotEmpty && errorMessages.isEmpty ? '재발송' : '인증받기',
                        backgroundColor: phone.isNotEmpty && errorMessages.isEmpty ? const Color(0XFF555555) : const Color(0XFFBBBBBB),
                        textColor: Colors.white,
                        onPressed: () async {
                          AuthApi().sendCode(phone).then((value) {
                            setState(() {
                              expirationTime = value['data']['expired'];
                              isVerification = true;
                            });
                          }).catchError((error) {
                            print(error);
                          });
                        },
                      )
                    ),
                  )

                ),

              ],
            ),
            if (isVerification)
                Column(
                  children: [
                    const SizedBox(height: 24),
                    InputTextField(
                      height: 40,
                      label: '인증번호',
                      onChanged: (String value) {
                        setState(() {
                          code = value;
                        });
                      },
                      suffixIcon: isCodeVerified 
                        ? const Icon(Icons.done, color: Colors.green, size: 20,) 
                        : CountDownTimer(endTime: expirationTime),
                      placeholder: '',
                      errorMessage: '',
                      append: SizedBox(
                        width: 97,
                        child: CustomButton(
                          labelText: '확인',
                          backgroundColor: code.isNotEmpty ? const Color(0XFF555555) : const Color(0XFFBBBBBB),
                          textColor: Colors.white,
                          onPressed: () async {
                            AuthApi().verifyCode(phone, code).then((value) {
                              if (value['code'] == 200 || true) {
                                setState(() {
                                isCodeVerified = true;
                                CustomToast.successToast(context, value['message'], bottom: MediaQuery.of(context).size.height * 0.12);
                              });
                              } else {
                                CustomToast.errorToast(context, value['message'], bottom: MediaQuery.of(context).size.height * 0.12);
                              }
                              
                            }).catchError((error) {
                              print(error);
                            });
                          },
                        )
                      ),
                    )
                  ],
                )
          ],
        ),
      );
  }
}