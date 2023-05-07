import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiver/async.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/sign_in/phone_auth_model.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';

class PhoneAuthHeader extends StatelessWidget {
  const PhoneAuthHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SigninHeader(backButton: true, title: '', closeButton: false);
  }
}

class PhoneAuthDescription extends StatelessWidget {
  const PhoneAuthDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 41, bottom: 25),
        child: SigninDescription(description: '인증번호 4자리를\n입력해 주세요')
    );
  }
}

class PhoneAuthInputField extends StatefulWidget {
  String phoneNumber;
  PhoneAuthInputField({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneAuthInputField> createState() => _PhoneAuthInputFieldState();
}

class _PhoneAuthInputFieldState extends State<PhoneAuthInputField> {

  TextEditingController authNumberController = TextEditingController();
  FocusNode authNumberFocusNode = FocusNode();


  // String countText = '유효시간 3:00';
  String minute = '';
  String second = '';
  String remainText = '';

  void startTimer() {
    int _start = 180;
    int _current = 180;

    CountdownTimer countDownTimer = CountdownTimer(
      Duration(seconds: _start),
      Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      _current = _start - duration.elapsed.inSeconds;
      minute = (_current.toDouble() / 60.0).toInt().toString();
      second = (_current.toDouble() % 60.0).toInt() == 0
          ? '00'
          : ((_current.toDouble() % 60.0).toInt() > 0 && (_current.toDouble() % 60.0).toInt() < 10) ? '0' + (_current.toDouble() % 60.0).toInt().toString() : (_current.toDouble() % 60.0).toInt().toString();
      remainText = '유효시간 ' + minute + ':' + second;
      print('minute: $minute / second : $second');
      /// when time tick finish
      if(_current == 0) {
        context.read<SigninProvider>().timeValidateChange(true);
      } else {
        context.read<SigninProvider>().timerStateChange(true);
      }
    });
    sub.onDone(() {
      sub.cancel();
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PhoneAuthModel().phoneAuthRequest(widget.phoneNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if(snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Consumer<SigninProvider>(
                    builder: (context, data, child) => Container(
                        height: 68,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: StaticColor.loginInputBoxColor,
                          // color: Colors.red,s
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: data.timeValidate == true ? StaticColor.errorColor : Colors.transparent, width: 2),
                        ),
                      ),
                  ),
                  Consumer<SigninProvider>(
                    builder: (context, data, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: authNumberController,
                        autofocus: true,
                        focusNode: authNumberFocusNode,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.always,
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: '인증번호',
                          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          hintText: '인증번호를 입력하세요',
                          hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          alignLabelWithHint: true,
                          errorText: null,
                        ),
                        validator: (value) {

                        },
                      ),
                    ),
                  ),
                  Consumer<SigninProvider>(
                    builder: (context, data, child) => Align(
                      alignment: Alignment.bottomRight,
                      child: Text(remainText, style: TextStyle(color: data.timeValidate == true ? StaticColor.errorColor : Colors.black))
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}
