import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_data_bottom_sheet_view/create_event_date_bottom_sheet_view.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';

class CreateEventDateView extends StatefulWidget {
  const CreateEventDateView({super.key});

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
                    // return CreateEventBottomSheetView();
                    return DateBottomSheet();
                  }
              );
            },
            child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: StaticColor.grey100F6,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Consumer<CEProvider>(
                    builder: (context, data, child) {

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
          ),
        )
      ],
    );
  }
}