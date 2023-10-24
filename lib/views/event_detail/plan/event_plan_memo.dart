import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';

class EventPlanMemo extends StatefulWidget {
  const EventPlanMemo({super.key});

  @override
  State<EventPlanMemo> createState() => _EventPlanMemoState();
}

class _EventPlanMemoState extends State<EventPlanMemo> {
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void changeEventMemo() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    context.read<EDProvider>().changeEventMemo(eventId, editingController.text, true);
  }

  @override
  void initState() {
    editingController.text = context.read<EDProvider>().eventModel.description ?? '';
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        changeEventMemo();
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    EventModel eventModel = context.read<EDProvider>().eventModel;
    bool isMine = eventModel.eventHost?.id == PresentUserInfo.id;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('메모', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700, height: 1.4)),
        SizedBox(width: 8.0.w),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: editingController,
            autofocus: false,
            readOnly: isMine ? false : true,
            textInputAction: TextInputAction.done,
            maxLines: 6,
            maxLength: 200,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.4),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: StaticColor.loginInputBoxColor,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
              alignLabelWithHint: false,
              hintText: '이벤트에 대한 메모를 기록해 보세요(최대 200자)',
              hintStyle: TextStyle(color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
                borderSide: BorderSide.none,
              ),
            ),
            onEditingComplete: changeEventMemo,
          ),
        ),
      ],
    );
  }
}