import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/store/content_main/store_content_main_menu.dart';

class StoreHeader extends StatefulWidget {
  const StoreHeader({super.key});

  @override
  State<StoreHeader> createState() => _StoreHeaderState();
}

class _StoreHeaderState extends State<StoreHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            child: StoreSearchBox()
          ),
          Row(
            children: [
              storeAlarmButton(),
              storeMyPageButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget storeAlarmButton() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {

          },
          child: Center(child: Image.asset('assets/store/alarm.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
  }

  Widget storeMyPageButton() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {

          },
          child: Center(child: Image.asset('assets/store/my_page.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
  }
}

class StoreSearchBox extends StatefulWidget {
  const StoreSearchBox({super.key});

  @override
  State<StoreSearchBox> createState() => _StoreSearchBoxState();
}

class _StoreSearchBoxState extends State<StoreSearchBox> {

  late TextEditingController storeSearchController;

  @override
  void initState() {
    storeSearchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: StaticColor.grey200EE,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: storeSearchController,
            style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16.0.w, top: 10.0.h, bottom: 10.0.h),
              hintText: "'생일선물'을 검색해 보세요",
              hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              // suffixIcon: suffixIcon(),
            ),
          ),
        ),
        Positioned(
          top: 3.0.h,
          right: 0.0,
          child: Align(
            alignment: Alignment.centerRight,
            child: suffixIcon(),
          ),
        ),
      ],
    );
  }

  Widget suffixIcon() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {

          },
          child: Center(child: Image.asset('assets/store/prime_search.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
  }
}

class StoreContent extends StatefulWidget {
  const StoreContent({super.key});

  @override
  State<StoreContent> createState() => _StoreContentState();
}

class _StoreContentState extends State<StoreContent> {
  @override
  Widget build(BuildContext context) {
    /// search view or content view
    return StoreContentMain();
  }
}

class StoreContentMain extends StatefulWidget {
  const StoreContentMain({super.key});

  @override
  State<StoreContentMain> createState() => _StoreContentMainState();
}

class _StoreContentMainState extends State<StoreContentMain> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoreContentMainMenu(),
        StoreContentMainProduct(),
      ],
    );
  }
}
