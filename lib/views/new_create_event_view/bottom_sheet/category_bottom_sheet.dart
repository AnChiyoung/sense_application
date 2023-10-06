import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';
import '../../../constants/public_color.dart';

class CreateEventBottomSheetView extends StatefulWidget {
  const CreateEventBottomSheetView({super.key});

  @override
  State<CreateEventBottomSheetView> createState() => _CreateEventBottomSheetViewState();
}

class _CreateEventBottomSheetViewState extends State<CreateEventBottomSheetView> {
  @override
  Widget build(BuildContext context) {

    final safeAreaTopPadding = context.read<CEProvider>().safeAreaTopPadding;
    final safeAreaBottomPadding = context.read<CEProvider>().safeAreaBottomPadding;

    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - safeAreaTopPadding - 60, /// 마지막 60은 header widget height
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Stack(
            children: [
              Column(
                children: [
                  CreateEventBottomSheetHeaderBar(),
                  CreateEventBottomSheetTitle(),
                  SizedBox(height: 24.0.h),
                  CategorySelect(),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CreateEventBottomSheetSubmitButton(),
              )
            ]
        )
    );
  }
}

class CreateEventBottomSheetHeaderBar extends StatelessWidget {
  const CreateEventBottomSheetHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class CreateEventBottomSheetTitle extends StatelessWidget {
  const CreateEventBottomSheetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("이벤트 유형", style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
  }
}

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CEProvider>(
        builder: (context, data, child) {

          int selectState = data.selectCategory;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 0,
                          iconPath: 'assets/create_event/birthday.png',
                          title: '생일',
                          onPressed: () {
                            context.read<CEProvider>().selectCategoryChange(0, true);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 1,
                          iconPath: 'assets/create_event/date.png',
                          title: '데이트',
                          onPressed: () {
                            context.read<CEProvider>().selectCategoryChange(1, true);
                          }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0.h),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 2,
                          iconPath: 'assets/create_event/travel.png',
                          title: '여행',
                          onPressed: () {
                            context.read<CEProvider>().selectCategoryChange(2, true);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 3,
                          iconPath: 'assets/create_event/meet.png',
                          title: '모임',
                          onPressed: () {
                            context.read<CEProvider>().selectCategoryChange(3, true);
                          }
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 4,
                          iconPath: 'assets/create_event/business.png',
                          title: '비즈니스',
                          onPressed: () {
                            context.read<CEProvider>().selectCategoryChange(4, true);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    const Expanded(
                      flex: 1,
                      child: SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}

class CreateEventSelectTab extends StatefulWidget {
  bool checkState;
  String? iconPath;
  String? title;
  Function? onPressed;
  CreateEventSelectTab({super.key, required this.checkState, this.iconPath, this.title, this.onPressed});

  @override
  State<CreateEventSelectTab> createState() => _CreateEventSelectTabState();
}

class _CreateEventSelectTabState extends State<CreateEventSelectTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed == null ? {} : widget.onPressed!.call();
        },
        style: ElevatedButton.styleFrom(elevation: 0.0, backgroundColor: widget.checkState == true ? StaticColor.categorySelectedColor : StaticColor.categoryUnselectedColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.iconPath == null ? const SizedBox.shrink() : Image.asset(widget.iconPath!, width: 32.w, height: 32.h, color: widget.checkState == true ? Colors.white : Colors.black),
            widget.iconPath == null || widget.title == null ? const SizedBox.shrink() : SizedBox(height: 12.0.h),
            widget.title == null ? const SizedBox.shrink() : Text(widget.title!, style: TextStyle(fontSize: 13.sp, color: widget.checkState == true ? Colors.white : StaticColor.addEventFontColor, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}

class CreateEventBottomSheetSubmitButton extends StatefulWidget {
  const CreateEventBottomSheetSubmitButton({super.key});

  @override
  State<CreateEventBottomSheetSubmitButton> createState() => _CreateEventBottomSheetSubmitButtonState();
}

class _CreateEventBottomSheetSubmitButtonState extends State<CreateEventBottomSheetSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            categoryListener();
          },
          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              ]
          )
      ),
    );
  }

  void categoryListener() async {
    context.read<CEProvider>().categorySave();
    Navigator.pop(context);
  }
}
