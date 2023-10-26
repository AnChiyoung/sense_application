import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/store/preference_model.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class StoreSearchView extends StatefulWidget {
  const StoreSearchView({super.key});

  @override
  State<StoreSearchView> createState() => _StoreSearchViewState();
}

class _StoreSearchViewState extends State<StoreSearchView> {

  List<String> preferenceStringList = [];

  @override
  void initState() {
    loadPreference();
    super.initState();
  }

  void loadPreference() {
    preferenceStringList.clear();
    StoreSearchHistory.loadSearchObject().then((value) {
      for(var e in value) {
        preferenceStringList.add(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // 전체에 static color grey100f6을 줘도 되지만 개별 컨테이너 지정이 더 작업량이 많음. 해서 구분선을 두는 쪽으로 구현
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 1.0.h,
          color: StaticColor.grey200EE,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 10.0.w),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: preferenceStringList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<StoreProvider>().textBoxInputAndSearch(preferenceStringList.elementAt(index));
                      },
                      child: Container( // flutter color bug 때문에, 컨테이너로 wrap 해준 후 컬러 지정해야 gesture detector가 동작함
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 15.0.h),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(preferenceStringList.elementAt(index))),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                width: 40.w,
                                height: 40.h,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(25.0),
                                  onTap: () {
                                    StoreSearchHistory.targetRemove(index);
                                    loadPreference();
                                    setState(() {

                                    });
                                  },
                                  child: Center(child: Image.asset('assets/signin/button_close.png', width: 20.0.w, height: 20.0.h)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0.h,
                      color: StaticColor.grey100F6,
                    )
                  ],
                );
              }
            ),
          ),
        ),
        preferenceStringList.isEmpty ? const SizedBox.shrink() : Container(
          width: double.infinity,
          height: 8.0.h,
          color: StaticColor.grey100F6,
        ),
        /// 2023.10.22. 방침이 없어 우선 제거. by JERRY
        // StoreLiveProducts(),
      ],
    );
  }
}

class StoreLiveProducts extends StatefulWidget {
  const StoreLiveProducts({super.key});

  @override
  State<StoreLiveProducts> createState() => _StoreLiveProductsState();
}

class _StoreLiveProductsState extends State<StoreLiveProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 8.0.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('실시간 인기', style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w700))),
        ),
        Container(
          width: double.infinity,
          height: 300.0.h,
          child: Center(
            child: Text("실시간 인기 상품이 없습니다", style: TextStyle(fontSize: 12.0.sp, color: StaticColor.grey60077, fontWeight: FontWeight.w400)),
          ),
        ),
      ],
    );
  }
}
