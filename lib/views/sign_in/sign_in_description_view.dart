import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class ContentDescription extends StatefulWidget {
  int? presentPage;
  int? totalPage;
  String? description;

  ContentDescription({Key? key, this.presentPage, this.totalPage, this.description}) : super(key: key);

  @override
  State<ContentDescription> createState() => _ContentDescriptionState();
}

class _ContentDescriptionState extends State<ContentDescription> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.presentPage == null ? '' : widget.presentPage.toString(), style: TextStyle(fontSize: 14, color: StaticColor.mainSoft, fontWeight: FontWeight.w600)),
            Text(widget.totalPage == null ? '' : ' /${widget.totalPage.toString()}', style: TextStyle(fontSize: 14, color: StaticColor.signinTotalPageColor, fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(height: 16),
        Text(widget.description == null ? '' : widget.description.toString(),
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 24, color: StaticColor.signinDescriptionColor, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
