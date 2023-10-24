import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_bottom_sheet_submit_button.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_content_select_button.dart';

class EventCategoryBottomSheet extends StatefulWidget {
  const EventCategoryBottomSheet({super.key});

  @override
  State<EventCategoryBottomSheet> createState() => _EventCategoryBottomSheetState();
}

class _EventCategoryBottomSheetState extends State<EventCategoryBottomSheet> {

  void onPressSubmit() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    EnumEventCategory? category = context.read<EDProvider>().category;
    if (category == null) return;

    context.read<EDProvider>().changeEventCategory(eventId, category, true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Consumer<EDProvider>(
            builder: (context, data, child) {
              EnumEventCategory category = data.category ?? EnumEventCategory.birthday;
          
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                            checkState: category == EnumEventCategory.birthday,
                            iconPath: 'assets/create_event/birthday.png',
                            title: '생일',
                            onPressed: () {
                              data.setCategory(EnumEventCategory.birthday, true);
                            }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: category == EnumEventCategory.date,
                              iconPath: 'assets/create_event/date.png',
                              title: '데이트',
                              onPressed: () {
                                data.setCategory(EnumEventCategory.date, true);
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
                          child: EventContentSelectButton(
                              checkState: category == EnumEventCategory.travel,
                              iconPath: 'assets/create_event/travel.png',
                              title: '여행',
                              onPressed: () {
                                data.setCategory(EnumEventCategory.travel, true);
                              }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: category == EnumEventCategory.meeting,
                              iconPath: 'assets/create_event/meet.png',
                              title: '모임',
                              onPressed: () {
                                data.setCategory(EnumEventCategory.meeting, true);
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
                          child: EventContentSelectButton(
                              checkState: category == EnumEventCategory.business,
                              iconPath: 'assets/create_event/business.png',
                              title: '비즈니스',
                              onPressed: () {
                                data.setCategory(EnumEventCategory.business, true);
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
          ),
          Align(alignment: Alignment.bottomCenter, child: EventBottomSheetSubmitButton(onPressed: onPressSubmit))
        ],
      ),
    );
  }
}

