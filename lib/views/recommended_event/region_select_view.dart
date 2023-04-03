import 'package:flutter/material.dart';
import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';

class RegionSelectHeaderMenu extends StatefulWidget {
  const RegionSelectHeaderMenu({Key? key}) : super(key: key);

  @override
  State<RegionSelectHeaderMenu> createState() => _RegionSelectHeaderMenuState();
}

class _RegionSelectHeaderMenuState extends State<RegionSelectHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void backCallback() {
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
