import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../utils/color_scheme.dart';
import './layouts/login_layout.dart';
import './widgets/auth/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final pageControl = PageController(
    initialPage: 1
  );

  @override
  Widget build(BuildContext context) {

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
      home: LoginLayout(body:
              SingleChildScrollView(
                controller: pageControl,
                scrollDirection: Axis.vertical,
                child: const Column(
                  children: [
                    SizedBox(height: 40),
                    Center(
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
                    LoginForm()
                  ],
              )
            )
      ),
    );
  }
}