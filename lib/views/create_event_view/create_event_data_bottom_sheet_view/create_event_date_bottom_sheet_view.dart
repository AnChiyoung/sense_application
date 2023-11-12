import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/add_event/date_select_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet({super.key});

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
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
                  const DateHeader(),
                  const DateTitle(),
                  SizedBox(height: 24.0.h),
                  const DateViewSection(),
                  const DateSelectSection(),
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: DateSubmitButton(),
              )
            ]
        )
    );
  }
}

class DateHeader extends StatelessWidget {
  const DateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: Image.asset('assets/feed/comment_header_bar.png', width: 75, height: 4));
  }
}

class DateTitle extends StatelessWidget {
  const DateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("이벤트 일자", style: TextStyle(fontSize: 16.0.sp, color: StaticColor.black90015, fontWeight: FontWeight.w500));
  }
}

class DateSubmitButton extends StatefulWidget {
  const DateSubmitButton({super.key});

  @override
  State<DateSubmitButton> createState() => _DateSubmitButtonState();
}

class _DateSubmitButtonState extends State<DateSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70.h,
      child: ElevatedButton(
          onPressed: () {
            dateListener();
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

  void dateListener() async {
    context.read<CEProvider>().dateSave();
    Navigator.pop(context);
  }
}
