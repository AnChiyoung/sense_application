// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/public_widget/add_event_cancel_dialog.dart';
// import 'package:sense_flutter_application/public_widget/header_menu.dart';
//
// class ShareEventHeader extends StatefulWidget {
//   const ShareEventHeader({Key? key}) : super(key: key);
//
//   @override
//   State<ShareEventHeader> createState() => _ShareEventHeaderState();
// }
//
// class _ShareEventHeaderState extends State<ShareEventHeader> {
//   @override
//   Widget build(BuildContext context) {
//     return HeaderMenu(backCallback: backCallback, title: '이벤트 생성', closeCallback: closeCallback);
//   }
//
//   void backCallback() {
//     // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegeditContactScreen()));
//     Navigator.of(context).pop();
//   }
//
//   void closeCallback() {
//     showDialog(
//         context: context,
//         //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return const AddEventCancelDialog();
//         });
//   }
// }
//
// class ShareEventTitle extends StatefulWidget {
//   const ShareEventTitle({Key? key}) : super(key: key);
//
//   @override
//   State<ShareEventTitle> createState() => _ShareEventTitleState();
// }
//
// class _ShareEventTitleState extends State<ShareEventTitle> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 32),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text('이벤트를\n공유할까요?', style: TextStyle(fontSize: 24, color: StaticColor.addEventTitleColor, fontWeight: FontWeight.w500)),
//             Container(
//               width: 81,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: StaticColor.categoryUnselectedColor,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => const DateSelectScreen()));
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: StaticColor.categoryUnselectedColor, elevation: 0.0),
//                 child: Text('건너뛰기', style: TextStyle(fontSize: 13, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w400)),
//               ),
//             ),
//           ],
//         )
//     );
//   }
// }
//
// class ShareEventContent extends StatefulWidget {
//   const ShareEventContent({Key? key}) : super(key: key);
//
//   @override
//   State<ShareEventContent> createState() => _ShareEventContentState();
// }
//
// class _ShareEventContentState extends State<ShareEventContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         children: [
//           AllShareSwitch(),
//           // ShareContactList(),
//         ],
//       ),
//     );
//   }
// }
//
// class AllShareSwitch extends StatefulWidget {
//   const AllShareSwitch({Key? key}) : super(key: key);
//
//   @override
//   State<AllShareSwitch> createState() => _AllShareSwitchState();
// }
//
// class _AllShareSwitchState extends State<AllShareSwitch> {
//
//   bool shareSwitch = false;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20),
//       child: Container(
//         height: 24,
//         // color: Colors.red,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           // mainAxisAlignment: MainAxisAlignment.start,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // 왜 센터로 정렬이 안되너?
//             Align(alignment: Alignment.center, child: Text('모두 공유', style: TextStyle(fontSize: 16, color: StaticColor.addEventFontColor, fontWeight: FontWeight.w700), textAlign: TextAlign.center)),
//             const SizedBox(
//               width: 12,
//             ),
//             FlutterSwitch(borderRadius: 12.0, width: 48, height: 24, toggleColor: Colors.white, inactiveColor: StaticColor.switchInactiveFillColor, activeColor: StaticColor.switchActiveFillColor, toggleSize: 18, value: shareSwitch, onToggle: (state) {
//               setState(() {
//                 shareSwitch = state;
//               });
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }