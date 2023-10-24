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
    EnumEventTarget? target = context.read<EDProvider>().target;
    if (target == null) return;

    context.read<EDProvider>().changeEventTarget(eventId, target, true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Consumer<EDProvider>(
            builder: (context, data, child) {
              EnumEventTarget? target = data.target;
          
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                            checkState: target == EnumEventTarget.friend,
                            iconPath: 'assets/create_event/friend.png',
                            title: '친구',
                            onPressed: () {
                              data.setTarget(EnumEventTarget.friend, true);
                            }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: target == EnumEventTarget.family,
                              iconPath: 'assets/create_event/home.png',
                              title: '가족',
                              onPressed: () {
                                data.setTarget(EnumEventTarget.family, true);
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
                              checkState: target == EnumEventTarget.lover,
                              iconPath: 'assets/create_event/couple.png',
                              title: '연인',
                              onPressed: () {
                                data.setTarget(EnumEventTarget.lover, true);
                              }
                          ),
                        ),
                        SizedBox(width: 13.0.w),
                        Expanded(
                          flex: 1,
                          child: EventContentSelectButton(
                              checkState: target == EnumEventTarget.work,
                              iconPath: 'assets/create_event/coperation.png',
                              title: '직장',
                              onPressed: () {
                                data.setTarget(EnumEventTarget.work, true);
                              }
                          ),
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

