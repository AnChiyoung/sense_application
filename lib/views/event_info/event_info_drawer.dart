/*
drawer section
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/event_delete_dialog.dart';
import 'package:sense_flutter_application/views/new_create_event_view/new_create_event_provider.dart';
import 'package:toast/toast.dart';

class EventInfoDrawer extends StatefulWidget {
  const EventInfoDrawer({Key? key}) : super(key: key);

  @override
  State<EventInfoDrawer> createState() => _EventInfoDrawerState();
}

class _EventInfoDrawerState extends State<EventInfoDrawer> {

  @override
  Widget build(BuildContext context) {
    /// safe area 상단 height
    var safePadding = MediaQuery.of(context).padding.top;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
          children: [
            SizedBox(height: safePadding),
            DrawerEventAction(),
            Container(width: double.infinity, height: 1, color: StaticColor.drawerDividerColor),
            const Expanded(child: DrawerJoinUser()),
            Container(width: double.infinity, height: 1, color: StaticColor.drawerDividerColor),
            const DrawerEventDelete(),
          ]
      ),
    );

  }
}

class DrawerEventAction extends StatefulWidget {
  DrawerEventAction({Key? key}) : super(key: key);

  @override
  State<DrawerEventAction> createState() => _DrawerEventActionState();
}

class _DrawerEventActionState extends State<DrawerEventAction> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: EventRequest().eventRequest(context.read<CEProvider>().eventUniqueId),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return const SizedBox.shrink();
          } else if(snapshot.hasData) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            } else if(snapshot.connectionState == ConnectionState.done) {

              EventModel loadEventModel = snapshot.data ?? EventModel();

              context.read<CEProvider>().drawerDataLoad(
                loadEventModel.isAlarm ?? false,
                loadEventModel.publicType ?? 'PUBLIC',
              );

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                child: Column(
                  children: [
                    Align(alignment: Alignment.centerLeft, child: Text('설정', style: TextStyle(fontSize: 18.sp, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w700))),
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
                                    child: Text('알림 받기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center))),
                            Expanded(
                              flex: 3,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Consumer<CEProvider>(
                                      builder: (context, data, child) {

                                        print('alarm ${data.isAlarm}');

                                        bool alarm = data.isAlarm;

                                        return FlutterSwitch(
                                          width: 48,
                                          height: 24,
                                          borderRadius: 12.0,
                                          padding: 3,
                                          toggleSize: 18,
                                          activeColor: StaticColor.drawerToggleActiveColor,
                                          inactiveColor: StaticColor.drawerToggleInactiveColor,
                                          value: alarm,
                                          onToggle: (bool value) async {
                                            print(value);
                                            if(value == true) {
                                              context.read<CEProvider>().isAlarmChange(value);
                                              bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CEProvider>().eventUniqueId, 5);

                                              if(updateResult == true) {
                                                alarm = value;
                                              } else {

                                              }
                                            } else if(value == false) {
                                              context.read<CEProvider>().isAlarmChange(value);
                                              bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CEProvider>().eventUniqueId, 5);

                                              if(updateResult == true) {
                                                alarm = value;
                                              } else {

                                              }
                                            }
                                          },
                                        );
                                      }
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0.h),
                        Text('새로운 추천 등을 푸시 알림을 통해 받습니다', style: TextStyle(fontSize: 12.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
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
                                    child: Text('비공개', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center))),
                            Expanded(
                              flex: 3,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Consumer<CEProvider>(
                                      builder: (context, data, child) {

                                        bool public = false;

                                        if(data.publicType == 'PUBLIC') {
                                          public = false;
                                        } else if(data.publicType == 'PRIVATE'){
                                          public = true;
                                        }

                                        return FlutterSwitch(
                                          width: 48,
                                          height: 24,
                                          borderRadius: 12.0,
                                          padding: 3,
                                          toggleSize: 18,
                                          activeColor: StaticColor.drawerToggleActiveColor,
                                          inactiveColor: StaticColor.drawerToggleInactiveColor,
                                          value: public,
                                          onToggle: (bool value) async {
                                            if(value == true) {
                                              context.read<CEProvider>().publicTypeChange('PRIVATE');
                                              bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CEProvider>().eventUniqueId, 6);

                                              if(updateResult == true) {
                                                public = value;
                                              } else {

                                              }
                                            } else if(value == false) {
                                              context.read<CEProvider>().publicTypeChange('PUBLIC');
                                              bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CEProvider>().eventUniqueId, 6);

                                              if(updateResult == true) {
                                                public = value;
                                              } else {

                                              }
                                            }
                                          },
                                        );
                                      }
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0.h),
                        Text('이벤트를 더 이상 공개하지 않습니다', style: TextStyle(fontSize: 12.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              );

            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        }
    );
  }
}

class DrawerJoinUser extends StatefulWidget {
  const DrawerJoinUser({Key? key}) : super(key: key);

  @override
  State<DrawerJoinUser> createState() => _DrawerJoinUserState();
}

class _DrawerJoinUserState extends State<DrawerJoinUser> {
  @override
  Widget build(BuildContext context) {

    ToastContext().init(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Row(
            children: [
              Align(alignment: Alignment.centerLeft, child: Text('참여자', style: TextStyle(fontSize: 18.sp, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w700), textDirection: TextDirection.ltr,)),
              SizedBox(width: 8.0.w),
              Image.asset('assets/feed/comment_dot.png', width: 4.0.w, height: 4.0.h, color: StaticColor.grey400BB),
              SizedBox(width: 8.0.w),
              Text('1명', style: TextStyle(fontSize: 16.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
              // Container(
              //   padding: const EdgeInsets.only(left: 0, right: 0),
              //   width: 53,
              //   height: 24,
              //   decoration: BoxDecoration(
              //     color: StaticColor.categoryUnselectedColor,
              //     borderRadius: BorderRadius.circular(8.0),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //     },
              //     style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0, padding: const EdgeInsets.symmetric(horizontal: 0)),
              //     child: Text('설정', style: TextStyle(fontSize: 11, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
              //   ),
              // ),
            ],
          ),
          // const SizedBox(height: 24),
          // Material(
          //   color: Colors.white,
          //   child: InkWell(
          //     splashColor: Colors.transparent,
          //     highlightColor: Colors.transparent,
          //     onTap: () {
          //       showToast('현재는 등록가능한 친구 목록이 없습니다', Toast.lengthLong, Toast.bottom);
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.only(left: 0, right: 0),
          //       width: double.infinity,
          //       height: 40,
          //       color: Colors.transparent,
          //       child: Align(
          //           alignment: Alignment.centerLeft,
          //           child: Row(
          //               children: [
          //                 Container(
          //                   width: 40,
          //                   height: 40,
          //                   decoration: BoxDecoration(
          //                     color: StaticColor.drawerInviteBackgroundColor,
          //                     shape: BoxShape.circle,
          //                   ),
          //                   child: Center(child: Image.asset('assets/recommended_event/invite_icon.png', width: 24, height: 24)),
          //                 ),
          //                 const SizedBox(width: 12),
          //                 Text('초대하기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w500)),
          //               ]
          //           ))
          //     ),
          //   ),
          // ),
          const SizedBox(height: 24),
          const JoinUserList(),
        ],
      ),
    );
  }

  void showToast(String msg, int? duration, int? gravity) {
    Toast.show(msg, duration: duration, gravity: gravity, backgroundColor: Colors.grey);
  }
}

class JoinUserList extends StatefulWidget {
  const JoinUserList({Key? key}) : super(key: key);

  @override
  State<JoinUserList> createState() => _JoinUserListState();
}

class _JoinUserListState extends State<JoinUserList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.topLeft,
          child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {

                bool creator = true;

                return Row(
                  children: [
                    /// profile image
                    UserProfileImage(profileImageUrl: PresentUserInfo.profileImage),
                    /// event creator widget == true
                    creator == true ? const SizedBox(width: 9) : const SizedBox(width: 12),
                    Container(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Center(child: Text(PresentUserInfo.username.isEmpty ? 'User${PresentUserInfo.id}' : PresentUserInfo.username, style: TextStyle(height: 2.0, fontSize: 16, color: StaticColor.drawerNameColor, fontWeight: FontWeight.w400)))),
                    const SizedBox(width: 6),
                    creator == true ? Image.asset('assets/recommended_event/event_creator_auth_mark.png', width: 20, height: 20) : Container(),
                  ],
                );
              }
          )
      ),
    );
  }
}

class DrawerEventDelete extends StatefulWidget {
  const DrawerEventDelete({Key? key}) : super(key: key);

  @override
  State<DrawerEventDelete> createState() => _DrawerEventDeleteState();
}

class _DrawerEventDeleteState extends State<DrawerEventDelete> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 35,
          // padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 6.0.h),
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return EventDeleteDialog();
                  }
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
            child: Text('이벤트 삭제하기', style: TextStyle(fontSize: 13, color: StaticColor.drawerEventDeleteTextColor, fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
/*
drawer section end
 */