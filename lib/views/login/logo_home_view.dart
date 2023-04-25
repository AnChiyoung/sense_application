import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoImageView extends StatefulWidget {

  @override
  // ignore: library_private_types_in_public_api
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoImageView> {

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width ,
      child:  Padding(
        padding: EdgeInsets.only(bottom: 40, left:80, right: 80), //apply padding to some sides only
        child: Image.asset('assets/login/temperature_logo.png', ),
      ),
    );
  }
}
