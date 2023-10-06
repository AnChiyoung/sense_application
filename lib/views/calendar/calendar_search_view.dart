import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sense_flutter_application/constants/public_color.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {

  late TextEditingController calendarSearchController;

  @override
  void initState() {
    calendarSearchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 40.w,
              height: 40.h,
              child: InkWell(
                borderRadius: BorderRadius.circular(25.0),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(child: Image.asset('assets/create_event/button_back.png', width: 24.w, height: 24.h)),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: calendarSearchController,
              autofocus: false,
              obscureText: false,
              maxLines: 1,
              // maxLength: 7,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(color: Colors.black), /// input text color
              decoration: InputDecoration(
                isDense: false,
                filled: true,
                fillColor: StaticColor.loginInputBoxColor,
                contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
                counterText: '',
                hintText: '이벤트를 검색해주세요',
                hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      width: 1, color: Colors.transparent,
                    )
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1, color: Colors.transparent,
                  ),
                ),
              ),
              onChanged: (value) {
                // inputSearchText = value;
                // /// 검색어 변경
                // context.read<ContactProvider>().searchTextChange(value.toLowerCase());
              },
              // onTap: () {
              // // context.read<ContactProvider>().isSearchState(true);
              // if(context.read<ContactProvider>().searchFocus == 0) {
              //   print(context.read<ContactProvider>().searchFocus);
              //   context.read<ContactProvider>().isSearchState(true);
              //   context.read<ContactProvider>().searchFocusUpdate();
              // } else {
              //   print(context.read<ContactProvider>().searchFocus);
              // }
              // }
            ),
          )
        ],
      ),
    );
  }
}
