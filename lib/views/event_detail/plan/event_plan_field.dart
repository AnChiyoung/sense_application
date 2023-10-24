import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_date_bottom_sheet.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_region_bottom_sheet.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_target_bottom_sheet.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_category_bottom_sheet.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_bottom_sheet.dart';

class EventPlanField extends StatefulWidget {
  final EnumEventDetailBottomSheetField eventField;
  const EventPlanField({super.key, required this.eventField});

  @override
  State<EventPlanField> createState() => _EventPlanFieldState();
}

class _EventPlanFieldState extends State<EventPlanField> {

  void openBottomSheet(String title, Widget child) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0.r)),),
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return EventBottomSheet(title: title, child: child);
      }
    );
  }

  void onTab() {
    context.read<EDProvider>().setEventDetailBottomSheetField(widget.eventField, false);

    Widget child = Container();
    switch (widget.eventField) {
      case EnumEventDetailBottomSheetField.category:
        child = const EventCategoryBottomSheet();
        break;
      case EnumEventDetailBottomSheetField.target:
        child = const EventTargetBottomSheet();
        break;
      case EnumEventDetailBottomSheetField.date:
        child = const EventDateBottomSheet();
        break;
      case EnumEventDetailBottomSheetField.region:
        child = const EventRegionBottomSheet();
        break;
      default:
    }

    String bottomSheetTitle = widget.eventField.bottomSheetTitle;
    openBottomSheet(bottomSheetTitle, child);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.eventField.label, style: TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w700)),
        SizedBox(width: 8.0.w),
        Material(
          color: StaticColor.grey100F6,
          borderRadius: BorderRadius.circular(18.0.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(18.0.r),
            onTap: onTab,
            child: Consumer<EDProvider>(
              builder: (context, data, child) {

                EventModel eventModel = data.eventModel;
                String label = '선택하기';
                bool hasChosen = false;

                switch (widget.eventField) {
                  case EnumEventDetailBottomSheetField.category:
                    if (eventModel.eventCategoryObject?.title != null && eventModel.eventCategoryObject?.title != '') {
                      label = eventModel.eventCategoryObject!.title!;
                      hasChosen = true;
                    }
                    break;
                  case EnumEventDetailBottomSheetField.target:
                    if (eventModel.targetCategoryObject?.title != null && eventModel.targetCategoryObject?.title != '') {
                      label = eventModel.targetCategoryObject!.title!;
                      hasChosen = true;
                    }
                    break;
                  case EnumEventDetailBottomSheetField.date:
                    if (eventModel.eventDate != null && eventModel.eventDate != '') {
                      label = eventModel.eventDate!;
                      hasChosen = true;
                    }
                    break;
                  case EnumEventDetailBottomSheetField.region:
                    if (eventModel.city?.title != null && eventModel.city?.title != '') {
                      if (eventModel.subCity?.title != null && eventModel.subCity?.title != '') {
                        label = eventModel.subCity!.title!;
                      } else {
                        label = eventModel.city!.title!;
                      }
                      hasChosen = true;
                    }
                    break;
                  default:
                }

                TextStyle textStyle = hasChosen 
                  ? TextStyle(fontSize: 14.sp, color: StaticColor.grey70055, fontWeight: FontWeight.w500, height: 1) 
                  : TextStyle(fontSize: 14.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400, height: 1);

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 11.0.h),
                  child: Center(child: Text(label, style: textStyle)),
                );
              }
            )
          ),
        ),
    
    
      ],
    );
  }
}
