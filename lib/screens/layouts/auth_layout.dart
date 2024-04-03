import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';
import 'package:go_router/go_router.dart';

class AuthLayout extends StatelessWidget {

  final String ?title;
  final Widget body;
  final Widget ?floating;
  final Widget ?bottomNavigationBar;
  
  const AuthLayout({super.key, required this.body, this.title, this.floating, this.bottomNavigationBar});
  
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor[50],
        highlightColor: const Color.fromRGBO(200, 200, 200, 1),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor[50]
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            color: Color.fromRGBO(187, 187, 187, 1),
          ),
        )
      ),
      home: 
        Scaffold(
          appBar:
            AppBar(
              leading:
                IconButton(
                  icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/caret-left.svg'),
                  onPressed: () {
                    if (GoRouter.of(context).canPop()) {
                      GoRouter.of(context).pop();
                    } else {
                      GoRouter.of(context).go('/home');
                    }
                  }
                ),
              shape: const Border(
                bottom: BorderSide(
                  width:1,
                  color: Color(0xFFEEEEEE)
                )
              ),
            ),
          body: 
            GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: body,
            ),
          bottomNavigationBar: bottomNavigationBar,
        ),
    );
  }
}