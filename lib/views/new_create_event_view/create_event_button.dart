import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/public_widget/event_create_fail_dialog.dart';
import 'package:sense_flutter_application/screens/event_info/event_info_screen.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventButton extends StatefulWidget {
  const CreateEventButton({super.key});

  @override
  State<CreateEventButton> createState() => _CreateEventButtonState();
}

class _CreateEventButtonState extends State<CreateEventButton> {

  bool enabledButton = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<CEProvider>(
        builder: (context, data, child) {

          bool buttonState = false;
          if(data.title.isNotEmpty && data.date.isNotEmpty && data.category != -1) {
            buttonState = true;
          } else {
            buttonState = false;
          }

          return SizedBox(
            width: double.infinity,
            height: 70.h,
            child: ElevatedButton(
                onPressed: () async {
                  // if(buttonState == true) {
                  //   await EventRequest().eventCreateRequest(context).then((value) {
                  //     if(value == true) {
                  //       // context.read<CEProvider>().createEventClear();
                  //       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => EventInfoScreen()), (route) => false);
                  //     } else {
                  //     }
                  //   });
                  // } else {
                  // }
                },
                style: ElevatedButton.styleFrom(backgroundColor: buttonState == false ? StaticColor.grey400BB : StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 56.0.h, child: Center(child: Text('완료', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
                    ]
                )
            ),
          );
        }
    );
  }

  /// 제목만 입력되면 이벤트 생성 가능
  // bool buttonCallbackActiveState() {
  //   return context.read<CreateEventProvider>().title != '';
  //   // && context.read<CreateEventProvider>().category != -1
  //   // && context.read<CreateEventProvider>().target != -1
  //   // && context.read<CreateEventProvider>().date != '';
  //   // && context.read<CreateEventProvider>().memo != ''
  // }
}
