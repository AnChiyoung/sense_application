// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/public_widget/behavior_collection.dart';
// import 'package:sense_flutter_application/screens/contact/contact_friend_screen.dart';
// import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
//
// class ContactListField extends StatefulWidget {
//   const ContactListField({Key? key}) : super(key: key);
//
//   @override
//   State<ContactListField> createState() => _ContactListFieldState();
// }
//
// class _ContactListFieldState extends State<ContactListField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           child: Column(
//             children: [
//               /// favorite
//               // Column(
//               //   children: [
//               //     Container(
//               //         padding: const EdgeInsets.only(left: 20.0),
//               //         alignment: Alignment.centerLeft,
//               //         height: 32, color: StaticColor.grey100F6,
//               //         child: Text('즐겨찾기', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
//               //     /// 즐겨찾기 필드
//               //   ],
//               //   /// favorite list insert
//               // ),
//               //
//               // const SizedBox(height: 16.0),
//               //
//               // /// birthday friends
//               // Column(
//               //   children: [
//               //     Container(
//               //         padding: const EdgeInsets.only(left: 20.0),
//               //         alignment: Alignment.centerLeft,
//               //         height: 32, color: StaticColor.grey100F6,
//               //         child: Text('생일인 친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
//               //     /// 생일인 친구 필드
//               //   ],
//               // ),
//               //
//               // const SizedBox(height: 16.0),
//
//               /// friends
//               Column(
//                 children: [
//                   Container(
//                       padding: const EdgeInsets.only(left: 20.0),
//                       alignment: Alignment.centerLeft,
//                       height: 32, color: StaticColor.grey100F6,
//                       child: Text('친구', style: TextStyle(fontSize: 14, color: StaticColor.black90015, fontWeight: FontWeight.w500))),
//                   // Consumer<ContactProvider>(
//                   //   builder: (context, data, child) => data.callContact == [] ?
//
//                   Consumer<ContactProvider>(
//                     builder: (context, data, child) => data.callContact.length == 0 ?
//                     const SizedBox.shrink() : Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
//                       child: Expanded(
//                         child: ScrollConfiguration(
//                           behavior: MyBehavior(),
//                           child: ListView.builder(
//                             physics: const ClampingScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: data.callContact.length,
//                             itemBuilder: (context, index) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (_) => ContactFriendScreen()));
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                                   /// gesture detector press용 color bug 해소를 위한 container
//                                   child: Container(
//                                     width: double.infinity,
//                                     color: Colors.transparent,
//                                     child: Row(
//                                       children: [
//                                         Image.asset('assets/contact/empty_profile.png', width: 40, height: 40),
//                                         const SizedBox(width: 8),
//                                         Text(data.callContact.elementAt(index).familyName!, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400)),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
