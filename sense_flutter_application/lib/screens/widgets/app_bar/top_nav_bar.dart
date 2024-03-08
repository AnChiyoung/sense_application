

import 'package:flutter/material.dart';

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
                  child: const Image(image: NetworkImage('https://randomuser.me/api/portraits/men/2.jpg'))
                )),
                const Padding(padding: EdgeInsets.only(left: 20), child: Text('Hello User!'))
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