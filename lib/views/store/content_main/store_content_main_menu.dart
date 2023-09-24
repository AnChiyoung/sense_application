import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class StoreContentMainMenu extends StatefulWidget {
  const StoreContentMainMenu({super.key});

  @override
  State<StoreContentMainMenu> createState() => _StoreContentMainMenuState();
}

class _StoreContentMainMenuState extends State<StoreContentMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 16.0.h, bottom: 24.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('필요한 것만 골라보세요', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w700),),
          ),
          SizedBox(height: 16.0.h),
          Consumer<StoreProvider>(
            builder: (context, data, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/present.png', '선물', data.storeMenuSelector.elementAt(0), 0),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/hotel.png', '호텔', data.storeMenuSelector.elementAt(1), 1),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/lunch.png', '점심', data.storeMenuSelector.elementAt(2), 2),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.0.h),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/dinner.png', '저녁', data.storeMenuSelector.elementAt(3), 3),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/activity.png', '액티비티', data.storeMenuSelector.elementAt(4), 4),
                      ),
                      SizedBox(width: 12.0.w),
                      Flexible(
                        flex: 1,
                        child: menuItem('assets/recommended_event/pub.png', '술집', data.storeMenuSelector.elementAt(5), 5),
                      ),
                    ],
                  ),
                ],
              );
            }
          ),
        ],
      ),
    );
  }

  /// icon position 개선 필요
  Widget menuItem(String imagePath, String menuName, bool checkState, int index) {
    return AspectRatio(
      aspectRatio: 104 / 88,
      child: ElevatedButton(
        onPressed: () {
          /// 선택된 아이템이 하나일 때는, 선택 해제할 수 없음.
          int trueCount = context.read<StoreProvider>().storeMenuSelector.where((e) => true == e).length;

          if(trueCount == 1) {
            if(checkState == true) {
              return ;
            } else if(checkState == false) {
              context.read<StoreProvider>().recommendCategoryValueChange(!checkState, index);
            }
          } else {
            context.read<StoreProvider>().recommendCategoryValueChange(!checkState, index);
          }
        },
        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: checkState == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.0.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(imagePath, color: checkState == true ? Colors.white : StaticColor.grey80033, width: 33.0.w, height: 35.0.h),
              SizedBox(height: 8.0.h),
              Text(menuName, style: TextStyle(fontSize: 14.0.sp, color: checkState == true ? Colors.white : StaticColor.grey80033, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreContentMainProduct extends StatefulWidget {
  const StoreContentMainProduct({super.key});

  @override
  State<StoreContentMainProduct> createState() => _StoreContentMainProductState();
}

class _StoreContentMainProductState extends State<StoreContentMainProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: GridView.builder(
        physics: ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
          childAspectRatio: 1 / 1,
        ),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            color: Colors.green,
          );
        }
      )
    );
  }
}

