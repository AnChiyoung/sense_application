

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sense_flutter_application/service/auth_service.dart';
import 'package:sense_flutter_application/utils/color_scheme.dart';

class TopNavBar extends StatefulWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});
  
  State<TopNavBar> createState() => _TopNavBarState(); 
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}

class _TopNavBarState extends State<TopNavBar> {

  bool isAuthenticated = false;

 @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    authService.removeTokens();
    authService.getAccessToken().then((value) {
      setState(() {
        isAuthenticated = value != null;
      });
    });

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFEEEEEE)
          )
        )
      
      ),
      child: 
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: SafeArea(child: 
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('lib/assets/images/logo.svg', height: 32),
                isAuthenticated ? Row(children: [
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/search.svg', color: const Color(0XFF333333),)),
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/bell.svg', color: const Color(0XFF333333),)),
                ],)
                : Text('로그인', style: TextStyle(color: primaryColor[50]),),
              ],
            )),
        ),
    );
  }
}