import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/recommended_event/recommended_screen.dart';

class EventInfoHeaderMenu extends StatefulWidget {
  Key drawerKey;
  EventInfoHeaderMenu({Key? key, required this.drawerKey}) : super(key: key);

  @override
  State<EventInfoHeaderMenu> createState() => _EventInfoHeaderMenuState();
}

class _EventInfoHeaderMenuState extends State<EventInfoHeaderMenu> {

  @override
  void initState() {
    AddEventModel.eventInfoTitle = '님과의 ' + AddEventModel.eventModel + '(1)';
    AddEventModel.eventInfoName = '님과의 ' + AddEventModel.eventModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HeaderMenu(backCallback: backCallback, title: AddEventModel.eventInfoTitle, rightMenu: menu());
  }

  void backCallback() {
    Navigator.of(context).pop();
  }

  Widget menu() {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openEndDrawer();
      },
      child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
    );
  }
}

/*
drawer section
 */
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
          const DrawerEventAction(),
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
  const DrawerEventAction({Key? key}) : super(key: key);

  @override
  State<DrawerEventAction> createState() => _DrawerEventActionState();
}

class _DrawerEventActionState extends State<DrawerEventAction> {

  bool recommend = false;
  bool alarm = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Align(alignment: Alignment.centerLeft, child: Text('이벤트', style: TextStyle(fontSize: 18, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w700))),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('추천받기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
              const SizedBox(width: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: FlutterSwitch(
                  width: 48,
                  height: 24,
                  borderRadius: 12.0,
                  padding: 3,
                  toggleSize: 18,
                  activeColor: StaticColor.drawerToggleActiveColor,
                  inactiveColor: StaticColor.drawerToggleInactiveColor,
                  value: recommend,
                  onToggle: (bool value) {
                    setState(() {
                      recommend = value;
                    });
                },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('알림받기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
              const SizedBox(width: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: FlutterSwitch(
                  width: 48,
                  height: 24,
                  borderRadius: 12.0,
                  padding: 3,
                  toggleSize: 18,
                  activeColor: StaticColor.drawerToggleActiveColor,
                  inactiveColor: StaticColor.drawerToggleInactiveColor,
                  value: alarm,
                  onToggle: (bool value) {
                    setState(() {
                      alarm = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(alignment: Alignment.centerLeft, child: Text('참여자', style: TextStyle(fontSize: 18, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w700), textDirection: TextDirection.ltr,)),
              Container(
                padding: const EdgeInsets.only(left: 0, right: 0),
                width: 53,
                height: 24,
                decoration: BoxDecoration(
                  color: StaticColor.categoryUnselectedColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0, padding: const EdgeInsets.symmetric(horizontal: 0)),
                  child: Text('설정', style: TextStyle(fontSize: 11, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 0, right: 0),
                width: double.infinity,
                height: 40,
                color: Colors.transparent,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: StaticColor.drawerInviteBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Image.asset('assets/recommended_event/invite_icon.png', width: 24, height: 24)),
                          ),
                          const SizedBox(width: 12),
                          Text('초대하기', style: TextStyle(fontSize: 16, color: StaticColor.drawerTextColor, fontWeight: FontWeight.w500)),
                        ]
                    ))
              ),
            ),
          ),
          const SizedBox(height: 24),
          const JoinUserList(),
        ],
      ),
    );
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
                Stack(
                  children: [
                    /// event creater widget
                    creator == true ? Container(width: 43, height: 43,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: GradientBoxBorder(
                          gradient: StaticColor.drawerUserSupervisorColor,
                          width: 2,
                        ),
                      ),
                    ) : Container(),

                    Container(width: 43, height: 43,
                      child: Center(
                        child: Stack(
                            children: [
                              Image.asset('assets/recommended_event/profile_image.png', width: 39, height: 39),
                              Container(width: 39, height: 39,
                                child: Center(
                                    child: Image.asset('assets/recommended_event/empty_user.png', width: 24, height: 24)
                                ),
                              ),
                            ],
                        ),
                      ),
                    ),
                  ],
                ),
                /// event creator widget == true
                creator == true ? const SizedBox(width: 9) : const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                    child: Center(child: Text('안치영(나)', style: TextStyle(fontSize: 16, color: StaticColor.drawerNameColor, fontWeight: FontWeight.w400)))),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 109,
          height: 32,
          decoration: BoxDecoration(
            color: StaticColor.categoryUnselectedColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
            child: Text('이벤트 나가기', style: TextStyle(fontSize: 13, color: StaticColor.drawerEventDeleteTextColor, fontWeight: FontWeight.w400)),
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
  const EventInfoTitle({Key? key}) : super(key: key);

  @override
  State<EventInfoTitle> createState() => _EventInfoTitleState();
}

class _EventInfoTitleState extends State<EventInfoTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('이벤트 정보', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500)),
            Container(
              width: 57,
              height: 32,
              decoration: BoxDecoration(
                color: StaticColor.categoryUnselectedColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {

                  // Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendedEventScreen()));
                },
                style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
                child: Text('편집', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        )
    );
  }
}

class EventInfoNameSection extends StatelessWidget {
  const EventInfoNameSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
        child: Align(alignment: Alignment.centerLeft, child: Text(AddEventModel.eventInfoName, style: TextStyle(fontSize: 16, color: StaticColor.eventInfoNameColor, fontWeight: FontWeight.w700))));
  }
}

class EventInfoPersonSection extends StatefulWidget {
  const EventInfoPersonSection({Key? key}) : super(key: key);

  @override
  State<EventInfoPersonSection> createState() => _EventInfoPersonSectionState();
}

class _EventInfoPersonSectionState extends State<EventInfoPersonSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 16),
      child: Row(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                  ),
                  Stack(
                      children: [
                        Image.asset('assets/recommended_event/profile_image.png', width: 56, height: 56),
                        Positioned(top: 16, left: 16, child: Image.asset('assets/recommended_event/empty_user.png', width: 24, height: 24)),
                      ]
                  ),
                  Positioned(top: 39, left: 39,
                      child: Stack(
                          children: [
                            Image.asset('assets/recommended_event/who.png', width: 20, height: 20),
                            const Positioned(top: 0, left: 4, child: Text('나', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400))),
                          ]
                      ),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              Text('안치영  ', style: TextStyle(fontSize: 12, color: StaticColor.eventInfoPersonNameColor, fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}

class EventInfoEtcSection extends StatefulWidget {
  const EventInfoEtcSection({Key? key}) : super(key: key);

  @override
  State<EventInfoEtcSection> createState() => _EventInfoEtcSectionState();
}

class _EventInfoEtcSectionState extends State<EventInfoEtcSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 48),
      child: Column(
        children: [
          Row(
            children: [
              Text('유형', style: TextStyle(fontSize: 14, color: StaticColor.eventInfoEventModelTitleColor, fontWeight: FontWeight.w700)),
              const SizedBox(width: 12),
              Text(AddEventModel.eventModel.isEmpty ? '미지정' : AddEventModel.eventModel, style: TextStyle(fontSize: 14, color: StaticColor.eventInfoEventModelTextColor, fontWeight: FontWeight.w500)),
              const SizedBox(width: 28),
              Text('날짜', style: TextStyle(fontSize: 14, color: StaticColor.eventInfoEventModelTitleColor, fontWeight: FontWeight.w700)),
              const SizedBox(width: 12),
              Text(AddEventModel.eventDateModel.isEmpty ? '미지정' : AddEventModel.eventDateModel, style: TextStyle(fontSize: 14, color: StaticColor.eventInfoEventModelTextColor, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          Align(alignment: Alignment.centerLeft, child: Text(AddEventModel.memoModel.isEmpty ? '메모 없음' : AddEventModel.memoModel, style: TextStyle(fontSize: 14, color: StaticColor.eventInfoEventModelTextColor, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class EventInfoRecommendedSection extends StatefulWidget {
  const EventInfoRecommendedSection({Key? key}) : super(key: key);

  @override
  State<EventInfoRecommendedSection> createState() => _EventInfoRecommendedSectionState();
}

class _EventInfoRecommendedSectionState extends State<EventInfoRecommendedSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendedScreen()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: StaticColor.eventInfoRecommendedBoxColor, elevation: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // const SizedBox(width: 12),
                    Text('추천', style: TextStyle(fontSize: 16, color: StaticColor.eventInfoPersonNameColor, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 8),
                    Text('미추천', style: TextStyle(fontSize: 12, color: StaticColor.eventInfoEventModelTextColor, fontWeight: FontWeight.w400)),
                  ],
                ),
                Row(
                  children: [
                    Text('더보기', style: TextStyle(fontSize: 12, color: StaticColor.eventInfoPersonNameColor, fontWeight: FontWeight.w500)),
                    const SizedBox(width: 2),
                    Image.asset('assets/recommended_event/recommended_arrow.png', width: 20, height: 20, color: StaticColor.eventInfoRecommendedBoxArrowColor),
                    // const SizedBox(width: 12),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}