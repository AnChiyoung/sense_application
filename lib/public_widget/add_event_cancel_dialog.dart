import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/add_event_model.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';

class AddEventCancelDialog extends StatefulWidget {
  const AddEventCancelDialog({Key? key}) : super(key: key);

  @override
  State<AddEventCancelDialog> createState() => _AddEventCancelDialogState();
}

class _AddEventCancelDialogState extends State<AddEventCancelDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 10.0.h, bottom: 10.0.h),
      contentPadding: EdgeInsets.zero,
      // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
      //Dialog Main Title
      title: Column(
        children: [
          Text('이벤트 생성을 취소할까요?', style: TextStyle(fontSize: 18.sp, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 8
          ),
          Text('지금 취소하면 처음부터 다시 해야해요', style: TextStyle(fontSize: 14.sp, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w500)),
        ],
      ),
      //
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
                    // context.read<AddEventProvider>().nextButtonReset();
                    // // 연락처 프로바이더 삽입
                    // context.read<AddEventProvider>().dateSelectNextButtonReset();
                    // context.read<AddEventProvider>().dayViewReset();
                    // context.read<RecommendedEventProvider>().nextButtonReset();
                    // context.read<RecommendedEventProvider>().priceNextButtonReset();
                    // context.read<RecommendedEventProvider>().regionNextButtonReset();
                    // context.read<RecommendedEventProvider>().memoNextButtonStateReset();
                    // context.read<RecommendedEventProvider>().regionSelectStateChange(-1);
                    //
                    // AddEventModel.eventTypeModel = '';
                    // AddEventModel.userModel.clear();
                    // AddEventModel.shareUserModel.clear();
                    // AddEventModel.dateModel = '';
                    // AddEventModel.recommendedModel.clear();
                    // AddEventModel.costModel = '';
                    // AddEventModel.regionModel.clear();
                    // AddEventModel.memoModel = '';

                    // /// route.isFirst는 native splash를 포함하지 않음
                    // /// route name 쓰지 않고 화면 스택 정리
                    // Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, elevation: 0.0),
                  child: Text('취소하기', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            const SizedBox(
              width: 8
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
                  onPressed: () {
                    context.read<CreateEventProvider>().eventInitialize();
                    Navigator.of(context).pop();
                    /// page route reset
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen(),
                      ),
                      (route) => false,
                    );
                    /// page route reset
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, elevation: 0.0),
                  child: Text('삭제하기', style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400)),
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