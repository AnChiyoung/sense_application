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

    return Consumer<StoreProvider>(
      builder: (context, data, child) {

        bool isSearchState = data.isSearchView;

        return Padding(
          padding: EdgeInsets.only(left: isSearchState == true ? 10.0.w : 20.0.w, right: 20.0.w, top: 10.0.h, bottom: 10.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isSearchState == true ? storeSearchBackButton() : const SizedBox.shrink(),
              const Expanded(
                  child: StoreSearchBox()
              ),
              isSearchState == true ? const SizedBox.shrink() : Row(
                children: [
                  storeAlarmButton(),
                  storeMyPageButton(),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  Widget storeSearchBackButton() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 40.w,
        height: 40.h,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0),
          onTap: () {
            context.read<StoreProvider>().searchViewChange(false);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: Image.asset('assets/store/back_arrow_thin.png', width: 24.w, height: 24.h)),
            ],
          ),
        ),
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
  final FocusNode storeSearchFocusNode = FocusNode();
  late PageController storePageController;

  @override
  void initState() {
    // storePageController = context.read<StoreProvider>().storePageController;
    storeSearchController = context.read<StoreProvider>().storeSearchController;
    storeSearchFocusNode.addListener(() {
      if(storeSearchFocusNode.hasFocus) {
        context.read<StoreProvider>().searchViewChange(true);
      } else {
        context.read<StoreProvider>().searchViewChange(false);
      }
    });
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
            focusNode: storeSearchFocusNode,
            autofocus: context.read<StoreProvider>().isSearchView,
            style: TextStyle(fontSize: 14.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 16.0.w, top: 10.0.h, bottom: 10.0.h),
              hintText: "'생일선물'을 검색해 보세요",
              hintStyle: TextStyle(fontSize: 14.0.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400),
              border: InputBorder.none,
              // suffixIcon: suffixIcon(),
            ),
            onEditingComplete: () {
              if(storeSearchController.text.isEmpty) {
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
            if(storeSearchController.text.isEmpty) {
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
    return Consumer<StoreProvider>(
      builder: (context, data, child) {

        bool isSearchView = data.isSearchView;

        if(isSearchView == true) {
          return StoreSearchView();
        } else {
          return StoreContentMainProduct();
        }
      }
    );
  }
}
