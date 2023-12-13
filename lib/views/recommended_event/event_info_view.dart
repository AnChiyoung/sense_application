import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/event/add_event_model.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/public_widget/empty_user_profile.dart';
import 'package:sense_flutter_application/public_widget/event_delete_dialog.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';
import 'package:toast/toast.dart';

class EventInfoHeaderMenu extends StatefulWidget {
  Key drawerKey;
  EventInfoHeaderMenu({super.key, required this.drawerKey});

  @override
  State<EventInfoHeaderMenu> createState() => _EventInfoHeaderMenuState();
}

class _EventInfoHeaderMenuState extends State<EventInfoHeaderMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventTitle = context.watch<RecommendedEventProvider>().editTitle;

    return HeaderMenu(
        backCallback: backCallback,
        title: eventTitle.isEmpty ? '미지정(1)' : '$eventTitle(1)',
        rightMenu: menu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget menu() {
    return GestureDetector(
        onTap: () {
          Scaffold.of(context).openEndDrawer();
        },
        child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24));
  }
}

// /*
// drawer section
//  */
// class EventInfoDrawer extends StatefulWidget {
//   const EventInfoDrawer({Key? key}) : super(key: key);

//   @override
//   State<EventInfoDrawer> createState() => _EventInfoDrawerState();
// }

// class _EventInfoDrawerState extends State<EventInfoDrawer> {

//   @override
//   Widget build(BuildContext context) {
//     /// safe area 상단 height
//     var safePadding = MediaQuery.of(context).padding.top;

//     return Consumer<CEProvider>(
//       builder: (context, data, child) {

//         return Container();
//         // EventModel model = data.selectEventModel;
//         //
//         // return Drawer(
//         //   backgroundColor: Colors.white,
//         //   child: Column(
//         //       children: [
//         //         SizedBox(height: safePadding),
//         //         DrawerEventAction(),
//         //         Container(width: double.infinity, height: 1, color: StaticColor.drawerDividerColor),
//         //         model.eventHost!.id == PresentUserInfo.id ? const Expanded(child: DrawerJoinUser()) : const SizedBox.shrink(),
//         //         Container(width: double.infinity, height: 1, color: StaticColor.drawerDividerColor),
//         //         model.eventHost!.id == PresentUserInfo.id ? const DrawerEventDelete() : const SizedBox.shrink(),
//         //       ]
//         //   ),
//         // );
//       }
//     );

//   }
// }

class DrawerEventAction extends StatefulWidget {
  const DrawerEventAction({super.key});

  @override
  State<DrawerEventAction> createState() => _DrawerEventActionState();
}

class _DrawerEventActionState extends State<DrawerEventAction> {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return FutureBuilder(
    //     future: EventRequest().eventRequest(context.read<CEProvider>().eventUniqueId),
    //     builder: (context, snapshot) {
    //       if(snapshot.hasError) {
    //         return const SizedBox.shrink();
    //       } else if(snapshot.hasData) {
    //         if(snapshot.connectionState == ConnectionState.waiting) {
    //           return const SizedBox.shrink();
    //         } else if(snapshot.connectionState == ConnectionState.done) {
    //
    //           // EventModel loadEventModel = snapshot.data ?? EventModel();
    //           //
    //           // context.read<CEProvider>().drawerDataLoad(
    //           //   loadEventModel.isAlarm ?? false,
    //           //   loadEventModel.publicType ?? 'PUBLIC',
    //           // );
    //
    //           return Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
    //             child: Column(
    //               children: [
    //                 Align(alignment: Alignment.centerLeft, child: Text('설정', style: TextStyle(fontSize: 18.sp, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w700))),
    //                 SizedBox(height: 24.0.h),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                             flex: 2,
    //                             child: Align(
    //                                 alignment: Alignment.centerLeft,
    //                                 child: Text('알림 받기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center))),
    //                         Expanded(
    //                           flex: 3,
    //                           child: Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Consumer<CEProvider>(
    //                                   builder: (context, data, child) {
    //
    //                                     // bool alarm = data.isAlarm;
    //
    //                                     return FlutterSwitch(
    //                                       width: 48,
    //                                       height: 24,
    //                                       borderRadius: 12.0,
    //                                       padding: 3,
    //                                       toggleSize: 18,
    //                                       activeColor: StaticColor.drawerToggleActiveColor,
    //                                       inactiveColor: StaticColor.drawerToggleInactiveColor,
    //                                       value: alarm,
    //                                       onToggle: (bool value) async {
    //                                         if(value == true) {
    //                                           context.read<CEProvider>().isAlarmChange(value);
    //                                           bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CreateEventImproveProvider>().eventUniqueId, 5);
    //
    //                                           if(updateResult == true) {
    //                                             alarm = value;
    //                                           } else {
    //
    //                                           }
    //                                         } else if(value == false) {
    //                                           context.read<CEProvider>().isAlarmChange(value);
    //                                           bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CreateEventImproveProvider>().eventUniqueId, 5);
    //
    //                                           if(updateResult == true) {
    //                                             alarm = value;
    //                                           } else {
    //
    //                                           }
    //                                         }
    //                                       },
    //                                     );
    //                                   }
    //                               )
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(height: 8.0.h),
    //                     Text('새로운 추천 등을 푸시 알림을 통해 받습니다', style: TextStyle(fontSize: 12.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
    //                   ],
    //                 ),
    //                 SizedBox(height: 32.0.h),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                             flex: 2,
    //                             child: Align(
    //                                 alignment: Alignment.centerLeft,
    //                                 child: Text('비공개', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center))),
    //                         Expanded(
    //                           flex: 3,
    //                           child: Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Consumer<CreateEventImproveProvider>(
    //                                   builder: (context, data, child) {
    //
    //                                     bool public = false;
    //
    //                                     if(data.publicType == 'PUBLIC') {
    //                                       public = false;
    //                                     } else if(data.publicType == 'PRIVATE'){
    //                                       public = true;
    //                                     }
    //
    //                                     return FlutterSwitch(
    //                                       width: 48,
    //                                       height: 24,
    //                                       borderRadius: 12.0,
    //                                       padding: 3,
    //                                       toggleSize: 18,
    //                                       activeColor: StaticColor.drawerToggleActiveColor,
    //                                       inactiveColor: StaticColor.drawerToggleInactiveColor,
    //                                       value: public,
    //                                       onToggle: (bool value) async {
    //                                         if(value == true) {
    //                                           context.read<CreateEventImproveProvider>().publicTypeChange('PRIVATE');
    //                                           bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CreateEventImproveProvider>().eventUniqueId, 6);
    //
    //                                           if(updateResult == true) {
    //                                             public = value;
    //                                           } else {
    //
    //                                           }
    //                                         } else if(value == false) {
    //                                           context.read<CreateEventImproveProvider>().publicTypeChange('PUBLIC');
    //                                           bool updateResult = await EventRequest().personalFieldUpdateEvent(context, context.read<CreateEventImproveProvider>().eventUniqueId, 6);
    //
    //                                           if(updateResult == true) {
    //                                             public = value;
    //                                           } else {
    //
    //                                           }
    //                                         }
    //                                       },
    //                                     );
    //                                   }
    //                               )
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(height: 8.0.h),
    //                     Text('이벤트를 더 이상 공개하지 않습니다', style: TextStyle(fontSize: 12.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w400)),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           );
    //
    //         } else {
    //           return const SizedBox.shrink();
    //         }
    //       } else {
    //         return const SizedBox.shrink();
    //       }
    //     }
    // );
  }
}

class DrawerJoinUser extends StatefulWidget {
  const DrawerJoinUser({super.key});

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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '참여자',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: StaticColor.drawerTextColor,
                        fontWeight: FontWeight.w700),
                    textDirection: TextDirection.ltr,
                  )),
              SizedBox(width: 8.0.w),
              Image.asset('assets/feed/comment_dot.png',
                  width: 4.0.w, height: 4.0.h, color: StaticColor.grey400BB),
              SizedBox(width: 8.0.w),
              Text('1명',
                  style: TextStyle(
                      fontSize: 16.sp, color: StaticColor.grey400BB, fontWeight: FontWeight.w500)),
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
  const JoinUserList({super.key});

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
                        child: Center(
                            child: Text(
                                PresentUserInfo.username.isEmpty
                                    ? 'User${PresentUserInfo.id}'
                                    : PresentUserInfo.username,
                                style: TextStyle(
                                    height: 1.4,
                                    fontSize: 16,
                                    color: StaticColor.drawerNameColor,
                                    fontWeight: FontWeight.w400)))),
                    const SizedBox(width: 6),
                    creator == true
                        ? Image.asset('assets/recommended_event/event_creator_auth_mark.png',
                            width: 20, height: 20)
                        : Container(),
                  ],
                );
              })),
    );
  }
}

class DrawerEventDelete extends StatefulWidget {
  const DrawerEventDelete({super.key});

  @override
  State<DrawerEventDelete> createState() => _DrawerEventDeleteState();
}

class _DrawerEventDeleteState extends State<DrawerEventDelete> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.h, bottom: 60.0.h),
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
                    return const EventDeleteDialog();
                  });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
            child: Text('이벤트 삭제하기',
                style: TextStyle(
                    fontSize: 13,
                    color: StaticColor.drawerEventDeleteTextColor,
                    fontWeight: FontWeight.w400)),
          ),
        ),
      ),
    );
  }
}
/*
drawer section end
 */

class EventInfoTitle extends StatefulWidget {
  const EventInfoTitle({super.key});

  @override
  State<EventInfoTitle> createState() => _EventInfoTitleState();
}

class _EventInfoTitleState extends State<EventInfoTitle> {
  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<RecommendedEventProvider>().editMode;

    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('이벤트 정보',
                style: TextStyle(
                    fontSize: 24,
                    color: StaticColor.addEventTitleColor,
                    fontWeight: FontWeight.w500)),
            Container(
              width: 57,
              height: 32,
              decoration: BoxDecoration(
                color: StaticColor.categoryUnselectedColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  context.read<RecommendedEventProvider>().editMode == false
                      ? context.read<RecommendedEventProvider>().isEditMode(true)
                      : {
                          context.read<RecommendedEventProvider>().isEditMode(false),
                          context.read<RecommendedEventProvider>().titleChange()
                        };
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                child: Text(editMode == true ? '완료' : '편집',
                    style: TextStyle(
                        fontSize: 13,
                        color: StaticColor.addEventFontColor,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ));
  }
}

class EventInfoNameSection extends StatefulWidget {
  const EventInfoNameSection({super.key});

  @override
  State<EventInfoNameSection> createState() => _EventInfoNameSectionState();
}

class _EventInfoNameSectionState extends State<EventInfoNameSection> {
  TextEditingController teController = TextEditingController(
      text: AddEventModel.eventInfoName == '' ? '미지정' : AddEventModel.eventInfoName);

  @override
  void initState() {
    AddEventModel.eventInfoName = AddEventModel.eventTypeModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<RecommendedEventProvider>().editMode;
    final editName = context.watch<RecommendedEventProvider>().editName;

    return editMode == false
        ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 32, bottom: 12),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AddEventModel.eventInfoName == '' ? '미지정' : editName,
                        style: TextStyle(
                            fontSize: 16,
                            color: StaticColor.eventInfoNameColor,
                            fontWeight: FontWeight.w700))),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: StaticColor.eventInfoPersonSectionDividerColor,
                ),
              ],
            ))
        : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: TextField(
              controller: teController,
              style: TextStyle(
                  fontSize: 20,
                  color: StaticColor.editModeInfoNameColor,
                  fontWeight: FontWeight.w700),
              maxLength: 50,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              maxLines: null,
              onChanged: (text) {
                AddEventModel.eventInfoTitle = teController.text;
                AddEventModel.eventInfoName = teController.text;
              },
              cursorHeight: 22,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  border: InputBorder.none,
                  counterText: '',
                  filled: true,
                  fillColor: StaticColor.textFormFieldFillColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: StaticColor.editModeInputBorderColor),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1.0, color: StaticColor.editModeInputBorderColor),
                    borderRadius: BorderRadius.circular(4.0),
                  )),
            ),
          );
  }
}

class EventInfoPersonSection extends StatefulWidget {
  const EventInfoPersonSection({super.key});

  @override
  State<EventInfoPersonSection> createState() => _EventInfoPersonSectionState();
}

class _EventInfoPersonSectionState extends State<EventInfoPersonSection> {
  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<RecommendedEventProvider>().editMode;
    ToastContext().init(context);

    return editMode == false
        ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            const SizedBox(
                              width: 65,
                              height: 65,
                            ),
                            Stack(children: [
                              Image.asset('assets/recommended_event/profile_image.png',
                                  width: 56, height: 56),
                              Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Image.asset('assets/recommended_event/empty_user.png',
                                      width: 24, height: 24)),
                            ]),
                            Positioned(
                              top: 39,
                              left: 39,
                              child: Stack(children: [
                                Image.asset('assets/recommended_event/who.png',
                                    width: 20, height: 20),
                                const Positioned(
                                    top: 0,
                                    left: 4,
                                    child: Text('나',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400))),
                              ]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 0),
                        Text('안치영  ',
                            style: TextStyle(
                                fontSize: 12,
                                color: StaticColor.eventInfoPersonNameColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: StaticColor.eventInfoPersonSectionDividerColor,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 12),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: StaticColor.editModeInviteBackgroundColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(children: [
                      Text('대상',
                          style: TextStyle(
                              fontSize: 14,
                              color: StaticColor.eventInfoEventModelTextColor,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(width: 6),
                      Image.asset('assets/recommended_event/dot.png', width: 4, height: 4),
                      const SizedBox(width: 6),
                      Text('1명',
                          style: TextStyle(
                              fontSize: 14,
                              color: StaticColor.editModeTextColor,
                              fontWeight: FontWeight.w500)),
                    ])),
                const SizedBox(height: 16),

                /// user list
                Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6),
                  child: Row(
                    children: [
                      // Material(
                      //   color: Colors.transparent,
                      //   child: InkWell(
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           width: 56,
                      //           height: 56,
                      //           decoration: BoxDecoration(
                      //             color: StaticColor.drawerInviteBackgroundColor,
                      //             shape: BoxShape.circle,
                      //           ),
                      //           child: Center(child: Image.asset('assets/recommended_event/invite_icon.png', width: 24, height: 24, color: StaticColor.editModeInviteIconColor)),
                      //         ),
                      //         const SizedBox(height: 9),
                      //         Text('초대하기', style: TextStyle(fontSize: 13, color: StaticColor.editModeInviteIconColor, fontWeight: FontWeight.w500)),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Material(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            showToast('현재는 등록가능한 친구 목록이 없습니다', Toast.lengthLong, Toast.bottom);
                          },
                          child: Container(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              color: Colors.transparent,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(children: [
                                    SizedBox(
                                      width: 62,
                                      height: 62,
                                      child: Center(
                                        child: Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: StaticColor.drawerInviteBackgroundColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                                  'assets/recommended_event/invite_icon.png',
                                                  width: 24,
                                                  height: 24,
                                                  color: StaticColor.editModeInviteIconColor)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 9),
                                    Text('초대하기',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: StaticColor.editModeInviteIconColor,
                                            fontWeight: FontWeight.w500)),
                                  ]))),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          // Container(width: 56, height: 56, color: Colors.red),

                          Stack(
                            children: [
                              /// event creater widget
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: GradientBoxBorder(
                                    gradient: StaticColor.drawerUserSupervisorColor,
                                    width: 2,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 62,
                                height: 62,
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Image.asset('assets/recommended_event/profile_image.png',
                                          width: 56, height: 56),
                                      SizedBox(
                                        width: 56,
                                        height: 56,
                                        child: Center(
                                            child: Image.asset(
                                                'assets/recommended_event/empty_user.png',
                                                width: 24,
                                                height: 24)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 40,
                                left: 40,
                                child: Stack(children: [
                                  Image.asset('assets/recommended_event/who.png',
                                      width: 20, height: 20),
                                  const Positioned(
                                      top: 0,
                                      left: 4,
                                      child: Text('나',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400))),
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          Text('안치영',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: StaticColor.editModeInfoNameColor,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  void showToast(String msg, int? duration, int? gravity) {
    Toast.show(msg, duration: duration, gravity: gravity, backgroundColor: Colors.grey);
  }
}

class EventInfoEtcSection extends StatefulWidget {
  const EventInfoEtcSection({super.key});

  @override
  State<EventInfoEtcSection> createState() => _EventInfoEtcSectionState();
}

class _EventInfoEtcSectionState extends State<EventInfoEtcSection> {
  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<RecommendedEventProvider>().editMode;
    final editCategory = context.watch<RecommendedEventProvider>().editCategory;
    final editMemo = context.watch<RecommendedEventProvider>().editMemo;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 48),
      child: Column(
        children: [
          editMode == false
              ? Row(
                  children: [
                    Text('유형',
                        style: TextStyle(
                            fontSize: 14,
                            color: StaticColor.eventInfoEventModelTitleColor,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(width: 12),
                    Text(
                        AddEventModel.eventTypeModel.isEmpty ? '미지정' : AddEventModel.eventTypeModel,
                        style: TextStyle(
                            fontSize: 14,
                            color: StaticColor.eventInfoEventModelTextColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(width: 28),
                    Text('날짜',
                        style: TextStyle(
                            fontSize: 14,
                            color: StaticColor.eventInfoEventModelTitleColor,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(width: 12),
                    Text(AddEventModel.dateModel.isEmpty ? '미지정' : AddEventModel.dateModel,
                        style: TextStyle(
                            fontSize: 14,
                            color: StaticColor.eventInfoEventModelTextColor,
                            fontWeight: FontWeight.w500)),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: StaticColor.editModeInviteBackgroundColor,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            AddEventModel.editorMode = true;
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddEventScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: StaticColor.editModeInviteBackgroundColor,
                              elevation: 0.0),
                          child: Row(
                            children: [
                              Text('유형',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: StaticColor.editModeInfoTitleColor,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(width: 12),
                              Text(editCategory.isEmpty ? '미지정' : editCategory,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: StaticColor.editModeTextColor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: StaticColor.editModeInviteBackgroundColor,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            AddEventModel.editorMode = true;
                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => DateSelectScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: StaticColor.editModeInviteBackgroundColor,
                              elevation: 0.0),
                          child: Row(
                            children: [
                              Text('날짜',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: StaticColor.editModeInfoTitleColor,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(width: 12),
                              Text(
                                  AddEventModel.dateModel.isEmpty ? '미지정' : AddEventModel.dateModel,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: StaticColor.editModeTextColor,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          editMode == false ? const SizedBox(height: 16) : const SizedBox(height: 12),
          editMode == false
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AddEventModel.memoModel.isEmpty ? '메모 없음' : AddEventModel.memoModel,
                      style: TextStyle(
                          fontSize: 14,
                          color: StaticColor.eventInfoEventModelTextColor,
                          fontWeight: FontWeight.w500)))
              : ElevatedButton(
                  onPressed: () {
                    AddEventModel.editorMode = true;
                    // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PresentMemoScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: StaticColor.editModeInviteBackgroundColor, elevation: 0.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: StaticColor.editModeInviteBackgroundColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('메모',
                            style: TextStyle(
                                fontSize: 14,
                                color: StaticColor.editModeInfoTitleColor,
                                fontWeight: FontWeight.w700)),
                        const SizedBox(width: 12),
                        SizedBox(
                            width: MediaQuery.of(context).size.width - 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        strutStyle: const StrutStyle(fontSize: 14.0),
                                        text: TextSpan(
                                            text: AddEventModel.memoModel.isEmpty
                                                ? '이벤트에 대한 내용을 기록해보세요.'
                                                : AddEventModel.memoModel,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: StaticColor.editModeTextColor,
                                                fontWeight: FontWeight.w500))))
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class EventInfoRecommendedSection extends StatefulWidget {
  const EventInfoRecommendedSection({super.key});

  @override
  State<EventInfoRecommendedSection> createState() => _EventInfoRecommendedSectionState();
}

class _EventInfoRecommendedSectionState extends State<EventInfoRecommendedSection> {
  @override
  Widget build(BuildContext context) {
    final editMode = context.watch<RecommendedEventProvider>().editMode;

    return editMode == false
        ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 62,
              decoration: BoxDecoration(
                color: StaticColor.eventInfoRecommendedBoxColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  print(AddEventModel.recommendedModel);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendedScreen()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: StaticColor.eventInfoRecommendedBoxColor, elevation: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // const SizedBox(width: 12),
                        Text('추천',
                            style: TextStyle(
                                fontSize: 16,
                                color: StaticColor.eventInfoPersonNameColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        Text('미추천',
                            style: TextStyle(
                                fontSize: 12,
                                color: StaticColor.eventInfoEventModelTextColor,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('더보기',
                            style: TextStyle(
                                fontSize: 12,
                                color: StaticColor.eventInfoPersonNameColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(width: 2),
                        Image.asset('assets/recommended_event/recommended_arrow.png',
                            width: 20,
                            height: 20,
                            color: StaticColor.eventInfoRecommendedBoxArrowColor),
                        // const SizedBox(width: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
