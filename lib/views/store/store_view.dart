import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/store/preference_model.dart';
import 'package:sense_flutter_application/views/store/content_list/store_content_main_menu.dart';
import 'package:sense_flutter_application/views/store/content_search/store_search_view.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';

class StoreHeader extends StatefulWidget {
  const StoreHeader({super.key});

  @override
  State<StoreHeader> createState() => _StoreHeaderState();
}

class _StoreHeaderState extends State<StoreHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (context, data, child) {
      bool isSearchState = data.isSearchView;
      bool textformfieldEmpty = data.storeSearchController.text.isEmpty;
      bool isVisible = false;
      if (isSearchState == true) {
        isVisible = true;
      } else {
        if (textformfieldEmpty == true) {
          isVisible = false;
        } else {
          isVisible = true;
        }
      }

      return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
              left: isSearchState == true ? 10.0.w : 20.0.w,
              right: 20.0.w,
              top: 10.0.h,
              bottom: 10.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isVisible ? const StoreSearchBackButton() : const SizedBox.shrink(),
              SizedBox(width: 8.0.w),
              const Expanded(child: StoreSearchBox()),
              // isSearchState == true ? const SizedBox.shrink() : Row(
              //   children: [
              //     storeAlarmButton(),
              //     storeMyPageButton(),
              //   ],
              // ),
            ],
          ),
        ),
      );
    });
  }

  Widget storeAlarmButton() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {},
          child:
              Center(child: Image.asset('assets/store/alarm.png', width: 24.0.w, height: 24.0.h)),
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
          onTap: () {},
          child:
              Center(child: Image.asset('assets/store/my_page.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
  }
}

class StoreSearchBackButton extends StatefulWidget {
  const StoreSearchBackButton({super.key});

  @override
  State<StoreSearchBackButton> createState() => _StoreSearchBackButtonState();
}

class _StoreSearchBackButtonState extends State<StoreSearchBackButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (context, data, child) {
      bool isSearchView = data.isSearchView;
      bool textformfieldEmpty = data.storeSearchController.text.isEmpty;
      bool state = false; // true: 검색, false: 클리어
      if (isSearchView == true) {
        state = true;
      } else {
        if (textformfieldEmpty == false) {
          state = false;
        }
      }

      return Material(
        color: Colors.transparent,
        child: SizedBox(
          width: 40.w,
          height: 40.h,
          child: InkWell(
            borderRadius: BorderRadius.circular(25.0),
            onTap: () {
              if (state == false) {
                context.read<StoreProvider>().textBoxClear();
              } else {
                context.read<StoreProvider>().textBoxInputAndSearch(
                    context.read<StoreProvider>().storeSearchController.text);
              }
            },
            child: Center(
              child: Image.asset(
                'assets/store/back_arrow_thin.png',
                width: 24.h,
                height: 24.h,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class StoreSearchBox extends StatefulWidget {
  const StoreSearchBox({super.key});

  @override
  State<StoreSearchBox> createState() => _StoreSearchBoxState();
}

class _StoreSearchBoxState extends State<StoreSearchBox> {
  late TextEditingController storeSearchController;
  late FocusNode storeSearchFocusNode;
  late PageController storePageController;

  @override
  void initState() {
    // storePageController = context.read<StoreProvider>().storePageController;
    storeSearchFocusNode = context.read<StoreProvider>().storeSearchFocus;
    storeSearchController = context.read<StoreProvider>().storeSearchController;
    storeSearchFocusNode.addListener(() {
      if (storeSearchFocusNode.hasFocus) {
        context.read<StoreProvider>().searchViewChange(true);
      } else {
        context.read<StoreProvider>().searchViewChange(false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StaticColor.grey200EE,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: StaticColor.grey200EE,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: TextFormField(
              controller: storeSearchController,
              focusNode: storeSearchFocusNode,
              autofocus: false,
              style: TextStyle(
                  fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 16.0.w, top: 10.0.h),
                hintText: "'생일선물'을 검색해 보세요",
                hintStyle: TextStyle(
                    fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
              onEditingComplete: () {
                if (storeSearchController.text.isEmpty) {
                  // 빈 값에선 저장은 하지 않음
                  context.read<StoreProvider>().textBoxInputAndSearch(storeSearchController.text);
                } else {
                  StoreSearchHistory.saveSearchObject(storeSearchController.text);
                  context.read<StoreProvider>().textBoxInputAndSearch(storeSearchController.text);
                  // List<String> aa = [];
                  // StoreSearchHistory.loadSearchObject().then((value) {
                  //   for(var e in value) {
                  //     aa.add(e);
                  //   }
                  //   print(aa);
                  // });
                }
              },
              onChanged: (v) {
                if (v.isEmpty) {
                  context.read<StoreProvider>().textBoxClear();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.0.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: suffixIcon(),
            ),
          ),
        ],
      ),
    );
  }

  Widget suffixIcon() {
    // if(context.read<StoreProvider>().isSearchView == false && context.read<StoreProvider>().storeSearchController.text.isEmpty) {
    //   return Material(
    //     color: Colors.transparent,
    //     child: SizedBox(
    //       width: 40.w,
    //       height: 40.h,
    //       child: InkWell(
    //         borderRadius: BorderRadius.circular(25.0),
    //         onTap: () {
    //           context.read<StoreProvider>().textBoxInputAndSearch(storeSearchController.text);
    //         },
    //         child: Center(child: Icon(Icons.cancel_outlined, size: 24.0, color: StaticColor.grey60077)),
    //       ),
    //     ),
    //   );
    // } else {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {
            if (storeSearchController.text.isEmpty) {
              // 빈 값에선 저장은 하지 않음
              context.read<StoreProvider>().textBoxInputAndSearch(storeSearchController.text);
            } else {
              StoreSearchHistory.saveSearchObject(storeSearchController.text);
              context.read<StoreProvider>().textBoxInputAndSearch(storeSearchController.text);
              // List<String> aa = [];
              // StoreSearchHistory.loadSearchObject().then((value) {
              //   for(var e in value) {
              //     aa.add(e);
              //   }
              //   print(aa);
              // });
            }
          },
          child: Center(
              child: Image.asset('assets/store/prime_search.png', width: 24.0.w, height: 24.0.h)),
        ),
      ),
    );
    // }
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
    return Consumer<StoreProvider>(builder: (context, data, child) {
      bool isSearchView = data.isSearchView;

      if (isSearchView == true) {
        return const StoreSearchView();
      } else {
        return const StoreContentMainProduct();
      }
    });
  }
}
