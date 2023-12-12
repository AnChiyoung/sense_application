import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
// import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class EventDetailDrawerDeleteDialog extends StatefulWidget {
  const EventDetailDrawerDeleteDialog({super.key});

  @override
  State<EventDetailDrawerDeleteDialog> createState() => _EventDetailDrawerDeleteDialogState();
}

class _EventDetailDrawerDeleteDialogState extends State<EventDetailDrawerDeleteDialog> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 10.0.h, bottom: 10.0.h),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Column(
        children: [
          Text('이벤트를 삭제 하시겠습니까?', style: TextStyle(fontSize: 18.sp, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
          SizedBox(height: 8.0.h,),
          Text('삭제된 이벤트는 복구되지 않습니다.', style: TextStyle(fontSize: 14.sp, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w500)),
        ],
      ),
      content: Padding(
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 28.0.h, bottom: 18.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 32.0.h,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, elevation: 0.0),
                  child: Text('계속하기', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            SizedBox(
                width: 8.0.h,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 32.h,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
                    if (eventId < 0) return;
                    
                    bool result = await context.read<EDProvider>().deleteEvent(eventId, false);
                    if (context.mounted && result) {
                      context.read<EDProvider>().clearEventModal(false);
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen(initPage: 3)));
                    }

                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: Text('확인', style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: null,
    );
  }
}
