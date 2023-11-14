
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';

class EventPlanTitle extends StatefulWidget {
  const EventPlanTitle({ super.key });

  @override
  State<EventPlanTitle> createState() => _EventPlanTitleState();
}

class _EventPlanTitleState extends State<EventPlanTitle> {
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void changeEventTitle() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    context.read<EDProvider>().changeEventTitle(eventId, editingController.text, true);
  }

  @override
  void initState() {
    editingController.text = context.read<EDProvider>().eventModel.eventTitle ?? '';
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        changeEventTitle();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EventModel eventModel = context.read<EDProvider>().eventModel;
    bool isMine = eventModel.eventHost?.id == PresentUserInfo.id;

    return TextFormField(
      controller: editingController,
      autofocus: false,
      readOnly: isMine ? false : true,
      textInputAction: TextInputAction.done,
      maxLines: 1,
      maxLength: 20,
      focusNode: focusNode,
      textAlignVertical: TextAlignVertical.bottom,
      style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: StaticColor.loginInputBoxColor,
        isDense: true,
        alignLabelWithHint: false,
        hintText: '변경할 이벤트 이름을 입력해주세요.',
        hintStyle: TextStyle(color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 13.0.h, horizontal: 16.0.w),
      ),
      onEditingComplete: changeEventTitle,
    );
  }
}
