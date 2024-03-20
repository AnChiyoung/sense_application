

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});
  @override
  Widget build(BuildContext context) =>
    Container(
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
          child: SafeArea(child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('lib/assets/images/icons/logo.svg', height: 32),
                Row(children: [
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/search.svg', color: const Color(0XFF333333),)),
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/bell.svg', color: const Color(0XFF333333),)),
                  IconButton(onPressed: () {}, icon: SvgPicture.asset('lib/assets/images/icons/svg/top_bar/user.svg', color: const Color(0XFF333333),))
                ],)
              ],
            )),
        ),
    );
      
        @override
        // TODO: implement preferredSize
        Size get preferredSize => const Size.fromHeight(60);
}