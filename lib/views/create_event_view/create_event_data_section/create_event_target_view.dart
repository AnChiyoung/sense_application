import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_bottom_sheet_view/create_event_target_bottom_sheet_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventTargetView extends StatefulWidget {
  const CreateEventTargetView({super.key});

  @override
  State<CreateEventTargetView> createState() => _CreateEventTargetViewState();
}

class _CreateEventTargetViewState extends State<CreateEventTargetView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('대상', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  isDismissible: false,
                  useSafeArea: true,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return TargetBottomSheet();
                  }
              );
            },
            child: Container(
                height: 50.0.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  // color: Colors.black,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Consumer<CEProvider>(
                    builder: (context, data, child) {
                      return Center(child: Text(data.targetString, style: TextStyle(fontSize: 14.0.sp, color: data.targetString == "선택하기" ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
                    }
                )
            ),
          ),
        )
      ],
    );
  }
}