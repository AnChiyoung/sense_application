import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class TravelStep01 extends StatefulWidget {
  const TravelStep01({super.key});

  @override
  State<TravelStep01> createState() => _TravelStep01State();
}

class _TravelStep01State extends State<TravelStep01> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.text = context.read<PreferenceProvider>().travelPrice.toString();

    // TextFormField가 빌드된 후 텍스트를 자동으로 선택합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _controller.text.length,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          const ContentDescription(
            presentPage: 1,
            totalPage: 6,
            description: '2박3일 기준 적당한 가격대는\n얼마라고 생각하시나요?',
          ),
          SizedBox(height: 24.0.h),
          Consumer<PreferenceProvider>(builder: (context, data, child) {
            bool limitTravelPrice = data.limitTravelPrice;

            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: StaticColor.grey100F6,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: TextFormField(
                      controller: _controller,
                      readOnly: limitTravelPrice ? true : false,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      maxLines: 1,
                      maxLength: 4,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: limitTravelPrice ? StaticColor.grey50099 : Colors.black,
                        fontSize: 14.sp,
                      ),
                      cursorHeight: 15.h,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: StaticColor.loginInputBoxColor,
                        // fillColor: Colors.black,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 1.0.h),
                        alignLabelWithHint: false,
                        labelStyle: TextStyle(
                          fontSize: 14.sp,
                          color: StaticColor.mainSoft,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: '금액을 입력해 주세요',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: StaticColor.loginHintTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (v) {
                        context
                            .read<PreferenceProvider>()
                            .changeTravelPrice(v.isEmpty ? 0 : int.parse(v), notify: true);
                      },
                      // unfocus on tap outside
                      onTapOutside: (v) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
                  ),
                ),
                SizedBox(width: 8.0.w),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '만원 이하',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: StaticColor.black90015,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 8.0.h),
          Consumer<PreferenceProvider>(
            builder: (context, data, child) {
              bool limitTravelPrice = data.limitTravelPrice;

              return GestureDetector(
                onTap: () {
                  data.changeLimitTravelPrice(!limitTravelPrice, notify: true);
                },
                child: Row(
                  children: [
                    limitTravelPrice
                        ? Image.asset('assets/signin/policy_check_done.png',
                            width: 16.0.h, height: 16.0.h)
                        : Image.asset(
                            'assets/signin/policy_check_empty.png',
                            width: 16.0.h,
                            height: 16.0.h,
                          ),
                    SizedBox(width: 8.0.w),
                    Text(
                      '금액제한 없음',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: StaticColor.grey70055,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
