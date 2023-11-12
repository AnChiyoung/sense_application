import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_bottom_sheet_view/create_event_category_bottom_sheet_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class TargetBottomSheet extends StatefulWidget {
  const TargetBottomSheet({super.key});

  @override
  State<TargetBottomSheet> createState() => _TargetBottomSheetState();
}

class _TargetBottomSheetState extends State<TargetBottomSheet> {
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
                  const TargetHeaderBar(),
                  const TargetTitle(),
                  SizedBox(height: 24.0.h),
                  const TargetSelect(),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: TargetSubmitButton(),
              )
            ]
        )
    );
  }
}

class TargetHeaderBar extends StatelessWidget {
  const TargetHeaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class TargetTitle extends StatelessWidget {
  const TargetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("이벤트 대상", style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
  }
}

class TargetSelect extends StatefulWidget {
  const TargetSelect({super.key});

  @override
  State<TargetSelect> createState() => _TargetSelectState();
}

class _TargetSelectState extends State<TargetSelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CEProvider>(
        builder: (context, data, child) {

          int selectState = data.selectTarget;

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
                          iconPath: 'assets/create_event/home.png',
                          title: '가족',
                          onPressed: () {
                            context.read<CEProvider>().selectTargetChange(0, true);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 1,
                          iconPath: 'assets/create_event/couple.png',
                          title: '연인',
                          onPressed: () {
                            context.read<CEProvider>().selectTargetChange(1, true);
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
                          iconPath: 'assets/create_event/friend.png',
                          title: '친구',
                          onPressed: () {
                            context.read<CEProvider>().selectTargetChange(2, true);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: selectState == 3,
                          iconPath: 'assets/create_event/coperation.png',
                          title: '직장',
                          onPressed: () {
                            context.read<CEProvider>().selectTargetChange(3, true);
                          }
                      ),
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

class TargetSubmitButton extends StatefulWidget {
  const TargetSubmitButton({super.key});

  @override
  State<TargetSubmitButton> createState() => _TargetSubmitButtonState();
}

class _TargetSubmitButtonState extends State<TargetSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            targetListener();
          },
          style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 56, child: Center(child: Text('저장', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)))),
              ]
          )
      ),
    );
  }

  void targetListener() async {
    context.read<CEProvider>().targetSave();
    Navigator.pop(context);
  }
}
