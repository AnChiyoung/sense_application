

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});
  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
      child: SafeArea(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox.fromSize(size: const Size.square(40), child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset('lib/assets/images/icons/logo.svg', width: 40)
                )),
                // const Padding(padding: EdgeInsets.only(left: 20), child: Text('Hello User!'))
              ]
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        )),
    );
      
        @override
        // TODO: implement preferredSize
        Size get preferredSize => const Size.fromHeight(60);
}