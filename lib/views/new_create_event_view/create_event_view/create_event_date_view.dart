import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/new_create_event_view/bottom_sheet/date_bottom_sheet.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';

class CreateEventDateView extends StatefulWidget {
  bool? edit;
  CreateEventDateView({super.key, this.edit = false});

  @override
  State<CreateEventDateView> createState() => _CreateEventDateViewState();
}

class _CreateEventDateViewState extends State<CreateEventDateView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('날짜', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 14.0.w),
        widget.edit == true ? DateContainer(edit: widget.edit!) :
        Expanded(
          child: DateContainer(edit: widget.edit!),
        )
      ],
    );
  }
}

class DateContainer extends StatefulWidget {
  bool edit;
  DateContainer({super.key, required this.edit});

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
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
              // return CreateEventBottomSheetView();
              return DateBottomSheet();
            }
        );
      },
      child: Container(
          padding: widget.edit == true ? EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h) : EdgeInsets.symmetric(vertical: 18.0.h),
          decoration: BoxDecoration(
            color: StaticColor.grey100F6,
            borderRadius: widget.edit == true ? BorderRadius.circular(18.0) : BorderRadius.circular(4.0),
          ),
          child: Consumer<CEProvider>(
              builder: (context, data, child) {
                // // 날짜, 제목 쪽에서 버튼 활성화 체크
                // if(context.read<CEProvider>().title.isNotEmpty && context.read<CEProvider>().date.isNotEmpty) {
                //   context.read<CEProvider>().createButtonStateChange(true);
                // } else {
                //   context.read<CEProvider>().createButtonStateChange(false);
                // }

                String dateText = '';

                if(data.date.isEmpty){
                  dateText = '선택하기';
                } else {
                  dateText = data.date.toString();
                }

                return Center(child: Text(dateText, style: TextStyle(fontSize: 14.sp, color: dateText == "선택하기" ? StaticColor.grey400BB : StaticColor.black90015, fontWeight: FontWeight.w400)));
              }
          )
      ),
    );
  }
}
