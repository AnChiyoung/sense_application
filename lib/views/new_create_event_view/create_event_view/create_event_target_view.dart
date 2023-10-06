import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/bottom_sheet/target_bottom_sheet.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventTargetView extends StatefulWidget {
  bool? edit;
  CreateEventTargetView({super.key, this.edit = false});

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
        widget.edit == true ? TargetContainer(edit: widget.edit!) :
        Expanded(
          child: TargetContainer(edit: widget.edit!),
        )
      ],
    );
  }
}

class TargetContainer extends StatefulWidget {
  bool edit;
  TargetContainer({super.key, required this.edit});

  @override
  State<TargetContainer> createState() => _TargetContainerState();
}

class _TargetContainerState extends State<TargetContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          padding: widget.edit == true ? EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h) : EdgeInsets.symmetric(vertical: 18.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            // color: Colors.black,
            borderRadius: widget.edit == true ? BorderRadius.circular(18.0) : BorderRadius.circular(4.0),
          ),
          child: Consumer<CEProvider>(
              builder: (context, data, child) {
                return Center(child: Text(data.targetString, style: TextStyle(fontSize: 14.0.sp, color: data.targetString == "선택하기" ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
              }
          )
      ),
    );
  }
}
