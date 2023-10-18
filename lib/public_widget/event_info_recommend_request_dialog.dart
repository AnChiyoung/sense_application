import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/recommend_model.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';

class RecommendRequestDialog extends StatefulWidget {
  const RecommendRequestDialog({super.key});

  @override
  State<RecommendRequestDialog> createState() => _RecommendRequestDialogState();
}

class _RecommendRequestDialogState extends State<RecommendRequestDialog> {
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
          Text('요청을 등록할까요?', style: TextStyle(fontSize: 18.sp, color: StaticColor.addEventCancelTitle, fontWeight: FontWeight.w700)),
          const SizedBox(
              height: 8
          ),
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
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.grey100F6, elevation: 0.0),
                  child: Text('계속하기', style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            SizedBox(
                width: 8.0.h
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
                    /// 추천 요청하기 로직 완료
                    // bool recommendRequestResult = await RecommendRequest().eventRecommendRequest(
                    //     context,
                    //     context.read<CreateEventImproveProvider>().eventUniqueId);
                    // if(recommendRequestResult == true) {
                    //   context.read<RecommendRequestProvider>().recommendFinish();
                    //   Navigator.of(context).pop();
                    //   Navigator.of(context).pop();
                    // } else {}
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
