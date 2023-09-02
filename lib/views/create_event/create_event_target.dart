import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/public_widget/create_event_select_tab.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';

class CreateEventTargetView extends StatefulWidget {
  const CreateEventTargetView({super.key});

  @override
  State<CreateEventTargetView> createState() => _CreateEventTargetViewState();
}

class _CreateEventTargetViewState extends State<CreateEventTargetView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
        builder: (context, data, child) {

          List<bool> state = data.targetState;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: state.elementAt(0),
                          iconPath: 'assets/create_event/home.png',
                          title: '가족',
                          onPressed: () {
                            context.read<CreateEventProvider>().targetStateChange([true, false, false, false]);

                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: state.elementAt(1),
                          iconPath: 'assets/create_event/couple.png',
                          title: '연인',
                          onPressed: () {
                            context.read<CreateEventProvider>().targetStateChange([false, true, false, false]);
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
                      child: CreateEventSelectTab(
                          checkState: state.elementAt(2),
                          iconPath: 'assets/create_event/friend.png',
                          title: '친구',
                          onPressed: () {
                            context.read<CreateEventProvider>().targetStateChange([false, false, true, false]);
                          }
                      ),
                    ),
                    SizedBox(width: 13.0.w),
                    Expanded(
                      flex: 1,
                      child: CreateEventSelectTab(
                          checkState: state.elementAt(3),
                          iconPath: 'assets/create_event/coperation.png',
                          title: '직장',
                          onPressed: () {
                            context.read<CreateEventProvider>().targetStateChange([false, false, false, true]);
                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
    );
  }
}