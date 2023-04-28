import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class SigninDescription extends StatefulWidget {
  int? presentPage = 1;
  int? totalPage = 1;
  String? description = '';

  SigninDescription({Key? key, this.presentPage, this.totalPage, this.description}) : super(key: key);

  @override
  State<SigninDescription> createState() => _SigninDescriptionState();
}

class _SigninDescriptionState extends State<SigninDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.presentPage.toString(), style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w600)),
            Text(' /${widget.totalPage.toString()}', style: TextStyle(fontSize: 14, color: StaticColor.signinTotalPageColor, fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(height: 16),
        Text(widget.description.toString(), style: TextStyle(fontSize: 24, color: StaticColor.signinDescriptionColor, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
