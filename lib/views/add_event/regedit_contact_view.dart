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
    return SizedBox(
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
    File? profileImage;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        onPressed: () async {
          var f = await ImagePicker().pickImage(source: ImageSource.gallery);
          profileImage = File(f!.path);
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(88, 88),
          shape: const CircleBorder(),
          backgroundColor: StaticColor.categoryUnselectedColor,
          elevation: 0.0
        ),
        child: profileImage == null ? Image.asset('assets/add_event/empty_image.png', width: 32, height: 32) : Image.file(profileImage),
      ),
    );
  }
}

class RegeditContactBaseInfo extends StatefulWidget {
  const RegeditContactBaseInfo({Key? key}) : super(key: key);

  @override
  State<RegeditContactBaseInfo> createState() => _RegeditContactBaseInfoState();
}

class _RegeditContactBaseInfoState extends State<RegeditContactBaseInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text('기본정보', style: TextStyle(fontSize: 16, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w700))),
          const SizedBox(height: 8),
          TextFormField(

          )
        ],
      ),
    );
  }
}
