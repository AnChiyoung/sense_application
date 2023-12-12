import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';

class EventDetailDrawerSetting extends StatefulWidget {
  const EventDetailDrawerSetting({super.key});

  @override
  State<EventDetailDrawerSetting> createState() => _EventDetailDrawerSettingState();
}

class _EventDetailDrawerSettingState extends State<EventDetailDrawerSetting> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft, 
            child: Text(
              '설정', 
              style: TextStyle(
                fontSize: 18.sp, 
                color: StaticColor.drawerTextColor, 
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 24.0.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '알림 받기', 
                        style: TextStyle(
                          fontSize: 16, 
                          color: StaticColor.drawerTextColor, 
                          fontWeight: FontWeight.w400,
                        ), 
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Consumer<EDProvider>(
                        builder: (context, data, child) {
                          int eventId = data.eventModel.id ?? -1;
                          bool isAlarm = data.eventModel.isAlarm ?? false;
                          
                          return FlutterSwitch(
                            width: 48,
                            height: 24,
                            borderRadius: 12.0,
                            padding: 3,
                            toggleSize: 18,
                            activeColor: StaticColor.drawerToggleActiveColor,
                            inactiveColor: StaticColor.drawerToggleInactiveColor,
                            value: isAlarm,
                            onToggle: (bool value) async {
                              if (eventId < 0) return;
                              context.read<EDProvider>().toggleEventAlarm(eventId, value, true);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0.h),
              Text(
                '새로운 추천 등을 푸시 알림을 통해 받습니다', 
                style: TextStyle(
                  fontSize: 12.sp, 
                  color: StaticColor.grey400BB, 
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.0.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '비공개', 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16, 
                          color: StaticColor.drawerTextColor, 
                          fontWeight: FontWeight.w400,
                        ), 
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Consumer<EDProvider>(
                        builder: (context, data, child) {
                          int eventId = data.eventModel.id ?? -1;
                          bool isPublic = data.eventModel.publicType == 'PUBLIC';

                          return FlutterSwitch(
                            width: 48,
                            height: 24,
                            borderRadius: 12.0,
                            padding: 3,
                            toggleSize: 18,
                            activeColor: StaticColor.drawerToggleActiveColor,
                            inactiveColor: StaticColor.drawerToggleInactiveColor,
                            value: isPublic,
                            onToggle: (bool value) async {
                               if (eventId < 0) return;
                              context.read<EDProvider>().toggleEventPublic(eventId, value, true);
                            },
                          );
                        }
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0.h),
              Text(
                '이벤트를 더 이상 공개하지 않습니다', 
                style: TextStyle(
                  fontSize: 12.sp, 
                  color: StaticColor.grey400BB, 
                  fontWeight: 
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

