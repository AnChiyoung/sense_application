import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/service/auth_service.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'layouts/main_layout.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isLogin = false;
  Map<String, dynamic> user = {};

  void loginScreen(value) {
    GoRouter.of(context).go('/login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthService.getRefreshToken().then((value) {
      if (value != null) {
        setState(() {
          isLogin = true;
        });
      }
    });

    AuthService().getUserDetails().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('ttt');
    print(user);

    return MainLayout(
      title: 'My Page',
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (isLogin) {
              AuthService().removeTokens().then(loginScreen);
            } else {
              loginScreen(null);
            }
          },
          child: Text(isLogin ? 'Logout' : 'Login',
              style: TextStyle(fontSize: 20, color: primaryColor[50])),
        ),
      ),
    );
  }
}
