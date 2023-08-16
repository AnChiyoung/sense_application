import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_screen.dart';

class MyPageTab extends StatefulWidget {
  const MyPageTab({super.key});

  @override
  State<MyPageTab> createState() => _MyPageTabState();
}

class _MyPageTabState extends State<MyPageTab> with TickerProviderStateMixin{

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyPageTabField(controller: controller),
        Container(
          width: double.infinity,
          height: 1.0.h,
          decoration: BoxDecoration(
            color: StaticColor.grey200EE,
          ),
        ),
        Expanded(child: MyPageTabbarViewField(controller: controller)),
      ],
    );
  }
}

class MyPageTabField extends StatefulWidget {
  TabController controller;
  MyPageTabField({super.key, required this.controller});

  @override
  State<MyPageTabField> createState() => _MyPageTabFieldState();
}

class _MyPageTabFieldState extends State<MyPageTabField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              controller: widget.controller,
              labelColor: StaticColor.mainSoft,
              labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
              unselectedLabelColor: StaticColor.grey70055,
              indicatorWeight: 3,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: StaticColor.mainSoft, width: 3.0),
              ),
              unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              tabs: [
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '게시글'
                  ),
                ),
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '상품'
                  ),
                ),
                SizedBox(
                  height: 37.0.h,
                  child: const Tab(
                      text: '취향'
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyPageTabbarViewField extends StatefulWidget {
  TabController controller;
  MyPageTabbarViewField({super.key, required this.controller});

  @override
  State<MyPageTabbarViewField> createState() => _MyPageTabbarViewFieldState();
}

class _MyPageTabbarViewFieldState extends State<MyPageTabbarViewField> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: widget.controller,
      children: [
        SingleChildScrollView(child: Container(height: 400, child: Center(child: Text('아직 게시글이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400))))),
        SingleChildScrollView(child: Container(height: 400, child: Center(child: Text('아직 등록된 상품이 없습니다', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey50099, fontWeight: FontWeight.w400))))),
        SingleChildScrollView(child: PersonalTaste()),
      ],
    );
  }
}

class PersonalTaste extends StatefulWidget {
  const PersonalTaste({super.key});

  @override
  State<PersonalTaste> createState() => _PersonalTasteState();
}

class _PersonalTasteState extends State<PersonalTaste> {
  @override
  Widget build(BuildContext context) {
    /// 취향 입력
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.0.h),
      child: Container(
        height: 400,
        child: Column(
          children: [
            PersonalTasteFoodBanner(),
            NonPersonalTaste(),
          ],
        ),
      ),
    );
  }
}

class PersonalTasteFoodBanner extends StatelessWidget {
  const PersonalTasteFoodBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          FittedBox(child: Image.asset('assets/my_page/food_background.png')), // width, heigth 설정
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 4.0.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text('음식', style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w400)),
                ),
                SizedBox(height: 10.0.h),
                Text('매운거 괴롭지 않아요!', style: TextStyle(fontSize: 12.0.sp, color: Colors.white, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NonPersonalTaste extends StatelessWidget {
  const NonPersonalTaste({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: StaticColor.grey100F6,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0.h),
        child: Column(
          children: [
            Center(child: Text('아직 취향정보가 없습니다.', style: TextStyle(fontSize: 14, color: StaticColor.grey400BB, fontWeight: FontWeight.w400))),
            SizedBox(height: 16.0.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalTasteFoodScreen()));
              },
              child: const Text('취향추가', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
