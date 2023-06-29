// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/models/contact/contact_model.dart';
// import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class ContactCallField extends StatefulWidget {
//   const ContactCallField({Key? key}) : super(key: key);
//
//   @override
//   State<ContactCallField> createState() => _ContactCallFieldState();
// }
//
// class _ContactCallFieldState extends State<ContactCallField> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           getPermission();
//         },
//         child: Container(
//             width: 100, height: 40, child: Center(child: Text('연락처 불러오기', style: TextStyle(color: Colors.white)))),
//       ),
//       //   ) : const SizedBox.shrink(),
//     );
//   }
//
//   void getPermission() async {
//     //(주의) Android 11버전 이상과 iOS에서는 유저가 한 두번 이상 거절하면 다시는 팝업 띄울 수 없습니다.
//     var status = await Permission.contacts.status;
//     if (status.isGranted) {
//       //연락처 권한 줬는지 여부
//       setState(() {});
//       print('허락됨');
//       ContactRequest.contacts = await ContactsService.getContacts();
//
//       print(ContactRequest.contacts);
//
//       List<String> nameList = [];
//       ContactRequest.contacts.map((e) {
//         if (e.givenName == '') {
//           nameList.add(e.familyName.toString());
//           print(e.familyName.toString());
//         } else {
//           nameList.add(e.givenName.toString());
//         }
//       });
//
//       // print(nameList);
//
//       List<ContactModel> models = await ContactRequest().contactListCreateRequest(nameList);
//
//       // context.read<ContactProvider>().isCallContact(ContactRequest.contacts);
//
//       // print(ContactRequest.contacts.length);
//       for (int i = 0; i < ContactRequest.contacts.length; i++) {
//         if (ContactRequest.contacts[i].givenName == '') {
//           // print(ContactRequest.contacts[i].familyName);
//         } else {
//           // print(ContactRequest.contacts[i].givenName);
//         }
//         setState(() {});
//       }
//     } else if (status.isDenied) {
//       print('거절됨');
//       Permission.contacts.request(); //허락해달라고 팝업띄우는 코드
//     }
//     // 하지만 아이폰의 경우 OS가 금지하는 경우도 있고 (status.isRestricted)
//     // 안드로이드의 경우 아예 앱 설정에서 꺼놓은 경우 (status.isPermanentlyDenied)
//     // 그것도 체크하고 싶으면
//     if (status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
// }
