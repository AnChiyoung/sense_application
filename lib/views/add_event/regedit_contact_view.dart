import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';

class RegeditContactHeader extends StatefulWidget {
  const RegeditContactHeader({Key? key}) : super(key: key);

  @override
  State<RegeditContactHeader> createState() => _RegeditContactHeaderState();
}

class _RegeditContactHeaderState extends State<RegeditContactHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 26.43),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                  child: Image.asset('assets/add_event/button_back.png', width: 24, height: 24)),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('새로운 연락처', style: TextStyle(fontSize: 16, color: StaticColor.contactTextColor, fontWeight: FontWeight.w500),),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 26.43),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AddEventCancelDialog();
                      });
                },
                child: Image.asset('assets/add_event/button_close.png', width: 15.01, height: 14.96),
              ),
            )
          )
        ]
      )
    );
  }
}

class RegeditContactImage extends StatefulWidget {
  const RegeditContactImage({Key? key}) : super(key: key);

  @override
  State<RegeditContactImage> createState() => _RegeditContactImageState();
}

class _RegeditContactImageState extends State<RegeditContactImage> {
  @override
  Widget build(BuildContext context) {
    File dummyFile = File('');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () async {
          PickedFile? f = await ImagePicker().getImage(source: ImageSource.gallery);
          dummyFile = File(f!.path);
        },
          // dummyFile.length() != 0 ?
          child: Container(
          width: 88,
          height: 88,
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(44.0),
            // shape: BoxShape.circle,
          ),
          child: Image.asset('assets/add_event/empty_image.png', width: 10, height: 32),
        )
      )
    );
  }
}
