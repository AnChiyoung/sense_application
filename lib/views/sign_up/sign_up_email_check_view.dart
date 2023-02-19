import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/login/login_provider.dart';
import 'package:sense_flutter_application/views/sign_up/sign_up_header_view.dart';

import '../../screens/login/contact/contact_main_screen.dart';

class LoginEmailVeiw extends StatefulWidget {
  @override
  _LoginEmailVeiw createState() => _LoginEmailVeiw();
}

class _LoginEmailVeiw extends State<LoginEmailVeiw> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SignUpHeaderVeiw(step: '5 / 8'),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 40, 14, 0),
                    child: Row(children: [
                      Text("${context.watch<StepProvider>().step} ",
                          style: const TextStyle(
                            color: Color(0xff3E97FF),
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          )),
                      Text("/ 6",
                          style: const TextStyle(
                            color: Color(0xffB5C0D2),
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          )),
                    ]),
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 0, 24),
                      child: Text(
                        '자주 사용하시는\n이메일을 입력해주세요.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(52, 54, 62, 1),
                          height: 1.4,
                          letterSpacing: -0.38,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    // width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color.fromRGBO(248, 249, 252, 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                color: Color.fromRGBO(80, 84, 95, 1),
                                fontSize: 16,
                                height: 1.6),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              labelText: '이메일 주소',
                              labelStyle: const TextStyle(
                                  color: Color.fromRGBO(121, 121, 121, 1),
                                  fontSize: 12,
                                  height: 8),
                              hintText: '정확하게 입력해 주세요',
                              hintStyle: const TextStyle(
                                color: Color.fromRGBO(181, 192, 210, 1),
                                fontSize: 16,
                              ),
                            ),
                            onSubmitted: (value) {}),
                        Container(
                            padding: const EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                '계정을 복구 하고 알림을 받을 때 사용됩니다.',
                                style: const TextStyle(
                                  color: Color.fromRGBO(193, 193, 193, 1),
                                  fontSize: 14,
                                ),
                              ),
                            )),
                        Container(
                            padding: const EdgeInsets.fromLTRB(10, 400, 10, 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor:
                                    Color.fromRGBO(62, 151, 255, 1),
                              ),
                              onPressed: () {
                                
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContactMainVeiw()));
                              },
                              child: const Text('다음'),
                            ))
                      ],
                    ),
                  ),
                ])));
  }
}
