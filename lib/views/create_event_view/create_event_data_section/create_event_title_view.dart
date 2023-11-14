import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventTitleView extends StatefulWidget {
  const CreateEventTitleView({super.key});

  @override
  State<CreateEventTitleView> createState() => _CreateEventTitleViewState();
}

class _CreateEventTitleViewState extends State<CreateEventTitleView> {

  TextEditingController titleController = TextEditingController();
  FocusNode titleFocus = FocusNode();

  @override
  void initState() {
    titleFocus.addListener(() {
      if(titleFocus.hasFocus == false) {
        context.read<CEProvider>().titleChange(titleController.text, false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    titleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Text('제목', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: TextFormField(
                controller: titleController,
                autofocus: false,
                focusNode: titleFocus,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                maxLength: 20,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(color: StaticColor.black90015),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: StaticColor.loginInputBoxColor,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  alignLabelWithHint: false,
                  labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                  hintText: "ex.금요미식회 정기모임",
                  hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (v) {
                  context.read<CEProvider>().titleChange(v, false);
                  v.isEmpty ? context.read<CEProvider>().createButtonStateChange(false) : context.read<CEProvider>().createButtonStateChange(true);
                }
            ),
          ),
        )
      ],
    );
  }
}