import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_description_view.dart';

class FoodStep01 extends StatefulWidget {
  const FoodStep01({super.key});

  @override
  State<FoodStep01> createState() => _FoodStep01State();
}

class _FoodStep01State extends State<FoodStep01> {

  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    /// when back step, save bundle data
    priceController.text = context.read<TasteProvider>().beforePrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 24.0.h),
      child: Column(
        children: [
          ContentDescription(presentPage: 1, totalPage: 7, description: '한끼 기준 적당한 가격대는\n얼마라고 생각하시나요?',),
          SizedBox(height: 24.0.h),
          Consumer<TasteProvider>(
            builder: (context, data, child) {

              int priceState = data.foodPrice;

              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 10.0.h),
                      width: double.infinity,
                      // height: 50,
                      decoration: BoxDecoration(
                        color: StaticColor.grey100F6,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: TextFormField(
                          controller: priceController,
                          readOnly: priceState == -1 ? true : false,
                          autofocus: false,
                          textInputAction: TextInputAction.next,
                          maxLines: 1,
                          maxLength: 4,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(color: Colors.black, fontSize: 14.sp),
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
                              labelStyle: TextStyle(fontSize: 14.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w500),
                              hintText: '금액을 입력해 주세요',
                              hintStyle: TextStyle(fontSize: 14.sp, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide.none,
                              )
                          ),
                          onChanged: (v) {
                            /// empty necessary control field
                            if(v.isEmpty) {
                              context.read<TasteProvider>().beforePriceChange(0);
                            } else {
                              context.read<TasteProvider>().beforePriceChange(int.parse(v));
                            }
                          }
                      ),
                      // child: Text(title, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(width: 8.0.w),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Text('만원 이하', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
                ],
              );
            }
          ),
          SizedBox(height: 8.0.h),
          Consumer<TasteProvider>(
            builder: (context, data, child) {

              int priceState = data.foodPrice;
              int beforePriceState = data.beforePrice;

              return GestureDetector(
                onTap: () {
                  if(priceState == -1) {
                    context.read<TasteProvider>().foodPriceChange(beforePriceState);
                  } else {
                    context.read<TasteProvider>().foodPriceChange(-1);
                  }
                },
                child: Row(
                  children: [
                    priceState == -1 ? Image.asset('assets/signin/policy_check_done.png', width: 16, height: 16) : Image.asset('assets/signin/policy_check_empty.png', width: 16, height: 16),
                    SizedBox(width: 8.0.w),
                    Text('금액제한 없음', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500)),
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
