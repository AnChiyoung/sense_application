import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/models/login/login_provider.dart';

class SignUpHeaderVeiw extends StatefulWidget with PreferredSizeWidget{
    const SignUpHeaderVeiw({super.key, required this.step});
    final String step;

    @override
  _SignUpHeaderVeiw createState() => _SignUpHeaderVeiw();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SignUpHeaderVeiw extends State<SignUpHeaderVeiw> {
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            color: Color.fromRGBO(181, 192, 210, 1),
            iconSize: 36,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // actions: [
          //   Container(
          //       padding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
          //       child: Text(
          //         "${context.watch<StepProvider>().step} / 8",
          //         style: const TextStyle(
          //           color: Color.fromRGBO(181, 192, 210, 1),
          //           fontFamily: 'Pretendard',
          //           fontWeight: FontWeight.w600,
          //           fontSize: 20,
          //           letterSpacing: -0.38,
          //         ),
          //       ))
          // ]
          );
  }
}
