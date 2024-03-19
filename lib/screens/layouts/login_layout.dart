import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginLayout extends ConsumerWidget {

  final String ?title;
  final Widget body;
  final Widget ?floating;
  final Widget ?bottomNavigationBar;
  
  const LoginLayout({super.key, required this.body, this.title, this.floating, this.bottomNavigationBar});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return Scaffold(
      appBar: AppBar(
          // leading: SvgPicture.asset('lib/assets/images/icons/logo.svg'),
          // leadingWidth: 100,
          automaticallyImplyLeading: true,
          shape: const Border(
            bottom: BorderSide(
              width:1,
              color: Color(0xFFEEEEEE)
            )
          ),
        ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
