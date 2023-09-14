import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/event_info_recommend_request_dialog.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class EventRecommendStepMemo extends StatefulWidget {
  const EventRecommendStepMemo({super.key});

  @override
  State<EventRecommendStepMemo> createState() => _EventRecommendStepMemoState();
}

class _EventRecommendStepMemoState extends State<EventRecommendStepMemo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendRequestProvider>(
        builder: (context, data, child) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 32.0.h, left: 20.0.w, right: 20.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ContentDescription(presentPage: 3, totalPage: 3, description: '자세한 요청 사항을 알려주세요'),
                      SizedBox(height: 28.0.h),
                      MemoField(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}

class MemoField extends StatefulWidget {
  const MemoField({super.key});

  @override
  State<MemoField> createState() => _MemoFieldState();
}

class _MemoFieldState extends State<MemoField> {

  TextEditingController recommendMemoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text('정확한 추천을 위해 참고 할 수 있는 정보를 알려주세요', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 16.0.h),
        SizedBox(
          height: 500.h,
          child: TextFormField(
            controller: recommendMemoController,
            autofocus: false,
            autovalidateMode: AutovalidateMode.always,
            textInputAction: TextInputAction.next,
            maxLines: 6,
            maxLength: 300,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 12.0.sp, color: StaticColor.textErrorColor, fontWeight: FontWeight.w400),
              counterText: '',
              filled: true,
              fillColor: StaticColor.grey100F6,
              // fillColor: Colors.black,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              alignLabelWithHint: false,
              labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
              hintText: '이벤트에 대한 메모를 기록해보세요(최대 300자)',
              hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide.none,
              )
            ),
            onChanged: (v) {
              context.read<CreateEventProvider>().recommendMemoChange(v);
            },
            validator: (v) {
              if(v!.length >= 300) {
                return '300자 이내로 작성해 주세요';
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
