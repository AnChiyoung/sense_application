

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PostTopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Function callBack;

  PostTopNavBar({super.key, required this.callBack});
  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 10),
      child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox.fromSize(size: const Size.square(40), child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: IconButton(onPressed: () {
                    context.goNamed('screen1');
                  }, icon: const Icon(Icons.arrow_back), color: const Color.fromARGB(255, 9, 105, 239), iconSize: 30)
                )),
                // const Padding(padding: EdgeInsets.only(left: 20), child: Text('Hello User!'))
              ]
            ),
            IconButton(onPressed: () {
              callBack();
            }, icon: const Icon(Icons.bookmark_add_outlined), color: Color.fromARGB(255, 9, 105, 239), iconSize: 30,)
          ],
        ),
    );
      
        @override
        // TODO: implement preferredSize
        Size get preferredSize => const Size.fromHeight(60);
}