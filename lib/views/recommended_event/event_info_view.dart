import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/add_event/add_event_model.dart';
import 'package:sense_flutter_application/public_widget/header_menu.dart';
import 'package:sense_flutter_application/screens/recommended_event/recommended_screen.dart';

class EventInfoHeaderMenu extends StatefulWidget {
  const EventInfoHeaderMenu({Key? key}) : super(key: key);

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
      onTap: () {},
      child: Image.asset('assets/recommended_event/menu.png', width: 24, height: 24)
    );
  }
}

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
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendedScreen()));
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

// class EventInfoRecommendedButton extends StatefulWidget {
//   const EventInfoRecommendedButton({Key? key}) : super(key: key);
//
//   @override
//   State<EventInfoRecommendedButton> createState() => _EventInfoRecommendedButtonState();
// }
//
// class _EventInfoRecommendedButtonState extends State<EventInfoRecommendedButton> {
//
//   // Future backButtonAction(BuildContext context) async {
//   //   context.read<RecommendedEventProvider>().recommendedButtonState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // final buttonEnabled = context.watch<RecommendedEventProvider>().recommendedButton;
//
//     return WillPopScope(
//       onWillPop: () async {
//         // await backButtonAction(context);
//         return true;
//       },
//       child: SizedBox(
//         width: double.infinity,
//         height: 76,
//         child: ElevatedButton(
//             onPressed: () {
//               // buttonEnabled == true ? Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendedEventScreen())) : (){};
//             },
//             // style: ElevatedButton.styleFrom(backgroundColor: buttonEnabled == true ? StaticColor.categorySelectedColor : StaticColor.unSelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
//             style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categorySelectedColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: const [
//                   SizedBox(height: 56, child: Center(child: Text('완료', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w700)))),
//                 ]
//             )
//         ),
//       ),
//     );
//   }
// }
