import 'package:flutter/material.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
import 'package:sense_flutter_application/screens/add_event/date_select_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_view.dart';

class ShareEventHeader extends StatefulWidget {
  const ShareEventHeader({Key? key}) : super(key: key);

  @override
  State<ShareEventHeader> createState() => _ShareEventHeaderState();
}

class _ShareEventHeaderState extends State<ShareEventHeader> {
  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', closeCallback: closeCallback);
  }

  void backCallback() {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegeditContactScreen()));
    Navigator.of(context).pop();
  }

  void closeCallback() {
    showDialog(
        context: context,
        //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const AddEventCancelDialog();
        });
  }
}

class ShareEventContent extends StatefulWidget {
  const ShareEventContent({Key? key}) : super(key: key);

  @override
  State<ShareEventContent> createState() => _ShareEventContentState();
}

class _ShareEventContentState extends State<ShareEventContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('이벤트를\n공유할까요?', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500)),
            Container(
              width: 81,
              height: 32,
              decoration: BoxDecoration(
                color: StaticColor.categoryUnselectedColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DateSelectScreen()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                child: Text('건너뛰기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        )
    );
  }
}

