import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/color_scheme.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ri.dart';
import './layouts/login_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  bool isAutoLogin = false;

  final pageControl = PageController(
    initialPage: 1
  );

  bool emailValidator(String email) {
    // Use a regular expression to validate the email format
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }


  @override
  Widget build(BuildContext context) {

    final int screenWidth =  MediaQuery.of(context).size.width.toInt();

    return MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor[50],
          highlightColor: primaryColor[50],
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primaryColor[50]
          ),
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Color.fromRGBO(187, 187, 187, 1),
            ),

          )
        ),
        home: LoginLayout(
          body: 
            SingleChildScrollView(
              controller: pageControl,
              scrollDirection: Axis.vertical,
              child: Column(children: [
                const SizedBox(height: 40),
                // Login Label
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 48),
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      )
                    ),
                  ),
                ),

                // Login Form
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth > 780 ? 500 : double.infinity,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        children: [

                          // Email TextField
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            width: double.infinity,
                            child: const Text(
                              '이메일',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                // Placeholder
                                labelText: '이메일을 입력해 주세요',
                                fillColor: Color.fromRGBO(246, 246, 246, 1),
                                filled: true,
                              ),
                            ),
                          ),


                          // Password TextField
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.only(bottom: 8),
                            width: double.infinity,
                            child: const Text(
                              '비밀번호',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: _controller,
                              obscureText: true,
                              obscuringCharacter: '●',
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                // Placeholder
                                labelText: '비밀번호를 입력해 주세요텍스트',
                                fillColor: Color.fromRGBO(246, 246, 246, 1),
                                filled: true,
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          // Stay Signed In Check box
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: () {
                                    setState(() {
                                      isAutoLogin = !isAutoLogin;
                                    });
                                  },
                                  child: SizedBox(
                                    height: 35,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset('lib/assets/images/svg/${(isAutoLogin ? 'circle-checked_filled.svg' : 'circle_checked.svg')}', width: 20, height: 20),
                                        const SizedBox(width: 8),
                                        const Text('자동로그인', style: TextStyle(fontSize: 14, color: Color(0XFF555555), fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.0),
                                  onTap: () {

                                  },

                                  // Forgot Password
                                  child: SizedBox(
                                    height: 35,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                        child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0XFF555555),
                                              width: 0.5
                                            )
                                          )
                                        ),
                                        child: const Text(
                                          '비밀번호 찾기',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0XFFBBBBBB),
                                            fontWeight: FontWeight.w500,
                                          )
                                        )
                                    ),
                                      ),
                                  )
                                ),
                              )
                            ],
                          ),

                          // Login Button
                          const SizedBox(height: 48),
                          SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                //Event
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFF56A4FF),
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Text(
                                '로그인',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ),

                          // Kakao Login Button
                          Container(
                            padding: const EdgeInsets.only(top: 16),
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () {
                                //Event
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFFEE500),
                                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Iconify(Ri.kakao_talk_fill, size: 24),
                                  SizedBox(width: 4),
                                  Text(
                                    '카카오로 시작하기',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ]
                              ),
                            )
                          ),

                          const SizedBox(height: 16),

                          // Signup by emial
                          InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {

                            },
                            child: SizedBox(
                              height: 40,
                              child: Align(
                                  child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0XFF555555),
                                        width: 0.5
                                      )
                                    )
                                  ),
                                  child: const Text(
                                    '이메일로 회원가입',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0XFFBBBBBB),
                                      fontWeight: FontWeight.w400,
                                    )
                                  )
                              ),
                                ),
                            )
                          ),
                        ]
                      )
                    ),
                  ),
                )
              ],
            )
            )
        ),
    );
  }
}