import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventMemoView extends StatefulWidget {
  const CreateEventMemoView({super.key});

  @override
  State<CreateEventMemoView> createState() => _CreateEventMemoViewState();
}

class _CreateEventMemoViewState extends State<CreateEventMemoView> {
  TextEditingController memoController = TextEditingController();
  FocusNode memoFocus = FocusNode();

  @override
  void initState() {
    memoFocus.addListener(() {
      if(memoFocus.hasFocus == false) {
        context.read<CEProvider>().titleChange(memoController.text, false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    memoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text('메모', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700), textAlign: TextAlign.start)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: TextFormField(
                controller: memoController,
                autofocus: false,
                textInputAction: TextInputAction.next,
                maxLines: 6,
                maxLength: 200,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: StaticColor.black90015),
                decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: StaticColor.grey100F6,
                    // fillColor: Colors.black,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    alignLabelWithHint: false,
                    labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                    hintText: '이벤트에 대한 메모를 기록해보세요\n(최대 200자)',
                    hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide.none,
                    )
                ),
                onChanged: (v) {
                  context.read<CEProvider>().memoChange(v, false);
                }
            ),
          ),
        )
      ],
    );
  }
}
