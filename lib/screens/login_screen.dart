import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../utils/color_scheme.dart';
import 'layouts/auth_layout.dart';
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

    return 
      AuthLayout(
        body:
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
    );
  }
}