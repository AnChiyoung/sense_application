import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_bottom_sheet_submit_button.dart';
import 'package:sense_flutter_application/views/event_detail/bottom_sheet/event_content_select_button.dart';

class EventTargetBottomSheet extends StatefulWidget {
  const EventTargetBottomSheet({super.key});

  @override
  State<EventTargetBottomSheet> createState() => _EventTargetBottomSheetState();
}

class _EventTargetBottomSheetState extends State<EventTargetBottomSheet> {

  void onPressSubmit() {
    int eventId = context.read<EDProvider>().eventModel.id ?? -1;
    int categoryId = context.read<EDProvider>().categoryId;
    context.read<EDProvider>().changeEventCategory(eventId, categoryId, true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Consumer<EDProvider>(
            builder: (context, data, child) {
              int categoryId = data.categoryId;
          
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                            checkState: categoryId == 1,
                            iconPath: 'assets/create_event/birthday.png',
                            title: '생일',
                            onPressed: () {
                              data.setCategoryId(1, true);
                            }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: categoryId == 2,
                              iconPath: 'assets/create_event/date.png',
                              title: '데이트',
                              onPressed: () {
                                data.setCategoryId(2, true);
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
                              checkState: categoryId == 3,
                              iconPath: 'assets/create_event/travel.png',
                              title: '여행',
                              onPressed: () {
                                data.setCategoryId(3, true);
                              }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: categoryId == 4,
                              iconPath: 'assets/create_event/meet.png',
                              title: '모임',
                              onPressed: () {
                                data.setCategoryId(4, true);
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
                              checkState: categoryId == 5,
                              iconPath: 'assets/create_event/business.png',
                              title: '비즈니스',
                              onPressed: () {
                                data.setCategoryId(5, true);
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

