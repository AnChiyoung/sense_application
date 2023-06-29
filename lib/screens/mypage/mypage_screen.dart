import 'package:flutter/material.dart';
import 'package:sense_flutter_application/main.dart';
import 'package:sense_flutter_application/models/login/login_home_model.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({Key? key}) : super(key: key);

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: TextButton(
          onPressed: () {
            kakaoLogout();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyApp()));
          },
          child: const Text(
            'LogOut',
            style: TextStyle(
              color: Color.fromRGBO(193, 193, 193, 1),
              fontSize: 14,
            ),
          ),
        )
    );
  }
}
