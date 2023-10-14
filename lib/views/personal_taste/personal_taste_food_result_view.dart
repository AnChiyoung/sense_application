import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/taste/taste_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/my_page/my_page_screen.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';

class FoodResultHeader extends StatefulWidget {
  const FoodResultHeader({super.key});

  @override
  State<FoodResultHeader> createState() => _FoodResultHeaderState();
}

class _FoodResultHeaderState extends State<FoodResultHeader> {
  @override
  Widget build(BuildContext context) {
    // return HeaderMenu(backCallback: backCallback, title: '음식 취향', rightMenu: complete());
    return HeaderMenu(backCallback: backCallback, title: '음식 취향');
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget complete() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          Navigator.of(context).pop();
          // if(foodTasteInputResult == true) {
          //
          // } else {
          //
          // }
        },
        borderRadius: BorderRadius.circular(25.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0.h),
          child: Text('완료', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.mainSoft, fontWeight: FontWeight.w700))),
      )
    );
  }
}

class FoodResultView extends StatefulWidget {
  FoodTasteModel model;
  FoodResultView({super.key, required this.model});

  @override
  State<FoodResultView> createState() => _FoodResultViewState();
}

class _FoodResultViewState extends State<FoodResultView> {
  late FoodTasteModel model;
  int spicy = 1;
  int sweety = 1;
  int salty = 1;
  List<int> a = [0, 1, 5];
  List<Widget> testFoodList = [];
  List<Widget> foodList = [];

  @override
  void initState() {
    model = widget.model;
    if(model.spicy!.isEmpty || model.spicy == null) {
      spicy = -1;
    } else {
      spicy = model.spicy!.elementAt(0).id!;
    }

    if(model.sweet!.isEmpty || model.sweet == null) {
      sweety = -1;
    } else {
      sweety = model.sweet!.elementAt(0).id!;
    }

    if(model.salty!.isEmpty || model.salty == null) {
      salty = -1;
    } else {
      salty = model.salty!.elementAt(0).id!;
    }
    for(var i in a) {
      // model.foodList!
      testFoodList.add(FoodWidget(foodId: i));
    }
    for(var i in model.foodList!) {
      foodList.add(FoodWidget(foodId: i.id!));
    }
    print('aa : $testFoodList');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 24.0.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${PresentUserInfo.username}님의 음식 취향', style: TextStyle(fontSize: 18.0.sp, color: StaticColor.grey80033, fontWeight: FontWeight.w700))),
            SizedBox(height: 16.0.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.model.content!, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400))),
            SizedBox(height: 32.0.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  spicy == -1 ? const SizedBox.shrink() : SpicyResultWidget(spicy: spicy),
                  spicy == -1 ? const SizedBox.shrink() : SizedBox(height: 8.0.h),
                  sweety == -1 ? const SizedBox.shrink() : SweetyResultWidget(sweety: sweety),
                  sweety == -1 ? const SizedBox.shrink() : SizedBox(height: 8.0.h),
                  salty == -1 ? const SizedBox.shrink() : SaltyResultWidget(salty: salty),
                ],
              )),
            spicy == -1 && sweety == -1 && salty == -1 ? const SizedBox.shrink() : SizedBox(height: 32.0.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('선호하는 음식 순위', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
            SizedBox(height: 8.0.h),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: testFoodList)),
            // ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: foodList)),
            ),
            SizedBox(height: 32.0.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('먹지 못하는 음식', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700))),
            SizedBox(height: 8.0.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('ai content section..\n2023.10.18.수요일. backend 작업 완료 예정', style: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400))),
          ],
        ),
      ),
    );
  }
}

class FoodWidget extends StatefulWidget {
  int foodId;
  FoodWidget({super.key, required this.foodId});

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  String foodPath = '';
  String foodString = '';
  @override
  void initState() {
    if(widget.foodId == 1) {
      foodPath = 'assets/taste/food/food01.png';
      foodString = '한식';
    } else if(widget.foodId == 2) {
      foodPath = 'assets/taste/food/food02.png';
      foodString = '양식';
    } else if(widget.foodId == 3) {
      foodPath = 'assets/taste/food/food03.png';
      foodString = '일식';
    } else if(widget.foodId == 4) {
      foodPath = 'assets/taste/food/food04.png';
      foodString = '중식';
    } else if(widget.foodId == 5) {
      foodPath = 'assets/taste/food/food05.png';
      foodString = '비건';
    } else if(widget.foodId == 6) {
      foodPath = 'assets/taste/food/food06.png';
      foodString = '패스트푸드';
    } else if(widget.foodId == 7) {
      foodPath = 'assets/taste/food/food07.png';
      foodString = '아시안';
    } else if(widget.foodId == 8) {
      foodPath = 'assets/taste/food/food08.png';
      foodString = '분식';
    } else if(widget.foodId == 9) {
      foodPath = 'assets/taste/food/food09.png';
      foodString = '퓨전';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 70.0.w,
              height: 70.0.h,
              child: Image.asset(foodPath),
            ),
            SizedBox(height: 8.0.h),
            Center(
              child: Text(foodString, style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500)),
            )
          ],
        ),
        SizedBox(width: 7.0.w),
      ],
    );
  }
}

class SpicyResultWidget extends StatefulWidget {
  int spicy;
  SpicyResultWidget({super.key, required this.spicy});

  @override
  State<SpicyResultWidget> createState() => _SpicyResultWidgetState();
}

class _SpicyResultWidgetState extends State<SpicyResultWidget> {
  int spicyIndex = 0;
  List<Widget> spicyList = [];
  
  @override
  void initState() {
    if(widget.spicy == 1) {
      spicyIndex = 0;
    } else if(widget.spicy == 2) {
      spicyIndex = 1;
    } else if(widget.spicy == 3) {
      spicyIndex = 2;
    } else if(widget.spicy == 4) {
      spicyIndex = 3;
    } else if(widget.spicy == 5) {
      spicyIndex = 4;
    }

    for(int i = 0; i < 5; i++) {
      if (i <= spicyIndex) {
        spicyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/spicy/spicy.png', width: 20,
                    height: 20,
                    color: StaticColor.errorColor),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      } else {
        spicyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/spicy/spicy.png', width: 20,
                    height: 20,
                    color: StaticColor.grey400BB),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      }
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0.w,
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 7.0.h),
      decoration: BoxDecoration(
        color: StaticColor.grey100F6,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("매운맛", style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
          Row(
            children: spicyList,
          ),
        ],
      ),
    );
  }
}

class SweetyResultWidget extends StatefulWidget {
  int sweety;
  SweetyResultWidget({super.key, required this.sweety});

  @override
  State<SweetyResultWidget> createState() => _SweetyResultWidgetState();
}

class _SweetyResultWidgetState extends State<SweetyResultWidget> {
  int sweetyIndex = 0;
  List<Widget> sweetyList = [];

  @override
  void initState() {
    if(widget.sweety == 6) {
      sweetyIndex = 0;
    } else if(widget.sweety == 7) {
      sweetyIndex = 1;
    } else if(widget.sweety == 8) {
      sweetyIndex = 2;
    } else if(widget.sweety == 9) {
      sweetyIndex = 3;
    } else if(widget.sweety == 10) {
      sweetyIndex = 4;
    }

    for(int i = 0; i < 5; i++) {
      if(i <= sweetyIndex) {
        sweetyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/candy/candy.png', width: 20, height: 20, color: StaticColor.dateLabelColor),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      } else {
        sweetyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/candy/candy.png', width: 20, height: 20, color: StaticColor.grey400BB),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0.w,
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 7.0.h),
      decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("단맛", style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
          Row(
            children: sweetyList,
          ),
        ],
      ),
    );
  }
}

class SaltyResultWidget extends StatefulWidget {
  int salty;
  SaltyResultWidget({super.key, required this.salty});

  @override
  State<SaltyResultWidget> createState() => _SaltyResultWidgetState();
}

class _SaltyResultWidgetState extends State<SaltyResultWidget> {
  int saltyIndex = 0;
  List<Widget> saltyList = [];

  @override
  void initState() {
    if(widget.salty == 11) {
      saltyIndex = 0;
    } else if(widget.salty == 12) {
      saltyIndex = 1;
    } else if(widget.salty == 13) {
      saltyIndex = 2;
    } else if(widget.salty == 14) {
      saltyIndex = 3;
    } else if(widget.salty == 15) {
      saltyIndex = 4;
    }

    for(int i = 0; i < 5; i++) {
      if(i <= saltyIndex) {
        saltyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/salty/salty.png', width: 20, height: 20, color: StaticColor.businessLabelColor),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      } else {
        saltyList.add(
            Row(
              children: [
                Image.asset('assets/taste/food/salty/salty.png', width: 20, height: 20, color: StaticColor.grey400BB),
                i == 4 ? const SizedBox.shrink() : SizedBox(width: 5.0.w),
              ],
            ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0.w,
      padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 7.0.h),
      decoration: BoxDecoration(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(4.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("짠맛", style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
          Row(
            children: saltyList,
          ),
        ],
      ),
    );
  }
}