// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
//
// class AgencySheet extends StatefulWidget {
//   @override
//   _AgencyState createState() => _AgencyState();
// }
//
// class _AgencyState extends State<AgencySheet> {
//
//   int _visibility = 1;
//   final nameController = TextEditingController();
//   final socialController = TextEditingController();
//   final phoneController = TextEditingController();
//   final agencyController = TextEditingController();
//   var arrAgency = ['SKT', 'KT', 'LG U+', 'SKT 알뜰폰', 'KT 알뜰폰', 'LG U+ 알뜰폰'];
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     socialController.dispose();
//     phoneController.dispose();
//     agencyController.dispose();
//     super.dispose();
//   }
//
//   void _show() {
//     setState(() {
//       _visibility = _visibility + 1;
//     });
//   }
//
//   void _hide() {
//     setState(() {
//       _visibility = _visibility - 1;
//     });
//   }
//
//   String vals = "Null";
//
//   var phoneFormatter = new MaskTextInputFormatter(
//       mask: '###-####-####',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);
//
//   var socialFormatter = new MaskTextInputFormatter(
//       mask: '######-#######',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);
//
//   @override
//   Widget agencyBottomSheet(BuildContext context) {
//     return SizedBox(
//         height: 423,
//         child: Container(
//           height: 150,
//           width: 150,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(16)),
//           ),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: const Text(
//                       '통신사를 선택해주세요',
//                       style: TextStyle(
//                           color: Color.fromRGBO(52, 54, 62, 1),
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         "X",
//                         style: TextStyle(
//                             color: Color.fromRGBO(52, 54, 62, 1),
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               for (var agency in arrAgency) agencyList(context, agency),
//             ],
//           ),
//         ));
//   }
//
//   Widget agencyList(BuildContext context, String agency) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(24, 1, 0, 1),
//         child: TextButton(
//       onPressed: () {
//         Navigator.pop(context);
//         agencyController.text = agency;
//       },
//       style: const ButtonStyle(
//         alignment: Alignment.centerLeft,
//       ),
//       child: Text(
//         agency,
//         style: TextStyle(
//             color: Color.fromRGBO(113, 118, 135, 1),
//             fontSize: 16,
//             fontWeight: FontWeight.w400),
//       ),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
