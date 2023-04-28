// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:sense_flutter_application/models/login/login_provider.dart';
// import 'package:sense_flutter_application/views/sign_up/sign_up_identity_view.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/sign_up/sign_up_home_model.dart';
//
// class LoginBody extends StatefulWidget {
//   @override
//   _LoginBodyView createState() => _LoginBodyView();
// }
//
// class _LoginBodyView extends State<LoginBody> {
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
//   void _socialData() {
//     setState(() {
//       socialController.text = socialController.text + '●●●●●';
//     });
//   }
//
//   void _signup() {
//     final param = {
//       "type_carrier": agencyController.text,
//       "phone": phoneController.text.replaceAll(RegExp('\\s'), ""),
//       "name": nameController.text,
//       "resident_number": socialController.text
//           .replaceAll(RegExp('[^0-9\\s]'), "")
//           .replaceAll(RegExp('\\s'), "")
//     };
//     Sigup(param: param);
//   }
//
//   String vals = "Null";
//
//   var phoneFormatter = new MaskTextInputFormatter(
//       mask: '### - #### - ####',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);
//
//   var socialFormatter = new MaskTextInputFormatter(
//       mask: '###### - #',
//       filter: {"#": RegExp(r'[0-9]')},
//       type: MaskAutoCompletionType.lazy);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         minimum: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 padding: const EdgeInsets.fromLTRB(20, 40, 14, 0),
//                 child: Row(children: [
//                   Text("${context.watch<StepProvider>().step} ",
//                       style: const TextStyle(
//                         color: Color(0xff3E97FF),
//                         fontFamily: 'Pretendard',
//                         fontWeight: FontWeight.w700,
//                         fontSize: 14,
//                       )),
//                   Text("/ 6",
//                       style: const TextStyle(
//                         color: Color(0xffB5C0D2),
//                         fontFamily: 'Pretendard',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       )),
//                 ]),
//               ),
//               SizedBox(
//                 // width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 16, 0, 24),
//                   child: Text(
//                     context.watch<StepProvider>().stepTitle,
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontFamily: 'Pretendard',
//                       fontWeight: FontWeight.w700,
//                       color: const Color.fromRGBO(52, 54, 62, 1),
//                       height: 1.4,
//                       letterSpacing: -0.38,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 // width: MediaQuery.of(context).size.width,
//                 // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   color: Color.fromRGBO(248, 249, 252, 1),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     if (context.read<StepProvider>().step == 4)
//                       TextField(
//                           controller: agencyController,
//                           inputFormatters: [phoneFormatter],
//                           keyboardType: TextInputType.number,
//                           style: const TextStyle(
//                               color: Color.fromRGBO(80, 84, 95, 1),
//                               fontSize: 16,
//                               height: 1.6),
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               filled: true,
//                               labelText: '통신사',
//                               labelStyle: TextStyle(
//                                   color: Color.fromRGBO(121, 121, 121, 1),
//                                   fontSize: 12,
//                                   height: 8),
//                               hintText: '통신사',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(181, 192, 210, 1),
//                                 fontSize: 16,
//                               ),
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(16, 40, 16, 10)),
//                           onSubmitted: (value) {}),
//                     if (context.read<StepProvider>().step >= 3)
//                       TextField(
//                           controller: phoneController,
//                           inputFormatters: [phoneFormatter],
//                           keyboardType: TextInputType.number,
//                           style: const TextStyle(
//                               color: Color.fromRGBO(80, 84, 95, 1),
//                               fontSize: 16,
//                               height: 1.6),
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               filled: true,
//                               labelText: '연락처',
//                               labelStyle: TextStyle(
//                                   color: Color.fromRGBO(121, 121, 121, 1),
//                                   fontSize: 12,
//                                   height: 8),
//                               hintText: '전화번호를 입력해주세요',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(181, 192, 210, 1),
//                                 fontSize: 16,
//                               ),
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(16, 40, 16, 10)),
//                           onChanged: (text) {
//                             if (text.length >= 17) {
//                               context.read<StepProvider>().addStep();
//                               showModalBottomSheet(
//                                   context: context,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                   ),
//                                   backgroundColor: Colors.white,
//                                   builder: (BuildContext content) {
//                                     return agencyBottomSheet(content);
//                                   });
//                             }
//                           },
//                           onSubmitted: (value) {}),
//                     if (context.read<StepProvider>().step >= 2)
//                       TextField(
//                           controller: socialController,
//                           inputFormatters: [socialFormatter],
//                           keyboardType: TextInputType.number,
//                           style: const TextStyle(
//                             color: Color.fromRGBO(80, 84, 95, 1),
//                             fontSize: 16,
//                           ),
//                           decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 width: 0,
//                                 style: BorderStyle.none,
//                               ),
//                             ),
//                             filled: true,
//                             labelText: '주민번호',
//                             labelStyle: TextStyle(
//                                 color: Color.fromRGBO(121, 121, 121, 1),
//                                 fontSize: 12,
//                                 height: 8),
//                             hintText: '주민번호를 입력해주세요',
//                             hintStyle: TextStyle(
//                               color: Color.fromRGBO(181, 192, 210, 1),
//                               fontSize: 16,
//                             ),
//                             contentPadding: EdgeInsets.fromLTRB(16, 40, 16, 10),
//                           ),
//                           onChanged: (text) {
//                             if (text.length > 7) {
//                               _socialData();
//                               context.read<StepProvider>().addStep();
//                             }
//                           },
//                           onSubmitted: (value) {}),
//                     if (context.read<StepProvider>().step >= 1)
//                       TextField(
//                           controller: nameController,
//                           style: const TextStyle(
//                               color: Color.fromRGBO(80, 84, 95, 1),
//                               fontSize: 16,
//                               height: 1.6),
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                               filled: true,
//                               labelText: '이름',
//                               labelStyle: TextStyle(
//                                   color: Color.fromRGBO(121, 121, 121, 1),
//                                   fontSize: 12,
//                                   height: 8),
//                               hintText: '실명을 입력해주세요',
//                               hintStyle: TextStyle(
//                                 color: Color(0xffC1C1C1),
//                                 fontSize: 16,
//                               ),
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(16, 40, 16, 10)),
//                           onSubmitted: (value) {
//                             context.read<StepProvider>().addStep();
//                           }),
//                     if (context.read<StepProvider>().step >= 4)
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromRGBO(62, 151, 255, 1),
//                             padding:
//                                 const EdgeInsets.fromLTRB(123, 16, 123, 16),
//                           ),
//                           onPressed: () {
//                             context.read<TermProvider>().resetTerm();
//                             showModalBottomSheet(
//                                 context: context,
//                                 builder: (BuildContext content) {
//                                   return termsBottomSheet(content);
//                                 });
//                           },
//                           child: const Text(
//                             '본인인증 하기',
//                             style: TextStyle(
//                                 color: Color.fromRGBO(255, 255, 255, 1),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       )
//                   ],
//                 ),
//               ),
//             ]));
//   }
//
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
//         width: double.infinity,
//         padding: const EdgeInsets.fromLTRB(24, 1, 0, 1),
//         child: TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             agencyController.text = agency;
//           },
//           style: const ButtonStyle(
//             alignment: Alignment.centerLeft,
//           ),
//           child: Text(
//             agency,
//             style: TextStyle(
//                 color: Color.fromRGBO(113, 118, 135, 1),
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400),
//           ),
//         ));
//   }
//
//   Widget termsBottomSheet(BuildContext context) {
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
//                     padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
//                     child: const Text(
//                       '센스 서비스를 제공해드리려면\n약관에 동의해 주세요.',
//                       style: TextStyle(
//                           color: Color.fromRGBO(52, 54, 62, 1),
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           height: 1.4),
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
//               //  for (var agency in arrAgency) termsList(context, agency),
//               Container(
//                   width: double.infinity,
//                   height: 40,
//                   margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         value: context.watch<TermProvider>().isFirstTerms,
//                         onChanged: (value) {
//                           context.read<TermProvider>().checkFirstTerms();
//                         },
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             context.watch<TermProvider>().checkFirstTerms();
//                           },
//                           child: Text(
//                             "[필수] 이용약관 및 필수 동의사항",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(85, 85, 85, 1),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
//                           child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "더보기",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(193, 193, 193, 1),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700),
//                               )))
//                     ],
//                   )),
//               Container(
//                   width: double.infinity,
//                   height: 40,
//                   margin: const EdgeInsets.all(0),
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         value: context.watch<TermProvider>().isSecondTerms,
//                         onChanged: (value) {
//                           context.read<TermProvider>().checkSecondTerms();
//                         },
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             context.watch<TermProvider>().checkSecondTerms();
//                           },
//                           child: Text(
//                             "[필수] 본인인증을 위한 개인정보 제 3자 제공",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(85, 85, 85, 1),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                           child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "더보기",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(193, 193, 193, 1),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700),
//                               )))
//                     ],
//                   )),
//               Container(
//                   width: double.infinity,
//                   height: 40,
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         value: context.watch<TermProvider>().isThirdTerms,
//                         onChanged: (value) {
//                           context.read<TermProvider>().checkThirdTerms();
//                         },
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             context.watch<TermProvider>().checkThirdTerms();
//                           },
//                           child: Text(
//                             "[선택] 취향 맞춤형 서비스 제공 항목",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(85, 85, 85, 1),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
//                           child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "더보기",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(193, 193, 193, 1),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700),
//                               )))
//                     ],
//                   )),
//               Container(
//                   width: double.infinity,
//                   height: 40,
//                   margin: const EdgeInsets.all(0),
//                   child: Row(
//                     children: [
//                       Checkbox(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         value: context.watch<TermProvider>().isFourthTerms,
//                         onChanged: (value) {
//                           context.read<TermProvider>().checkFourthTerms();
//                         },
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             context.watch<TermProvider>().checkFourthTerms();
//                           },
//                           child: Text(
//                             "[선택] 마케팅 정보 수신 동의사항",
//                             style: TextStyle(
//                                 color: Color.fromRGBO(85, 85, 85, 1),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                       Padding(
//                           padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
//                           child: TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "더보기",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(193, 193, 193, 1),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w700),
//                               )))
//                     ],
//                   )),
//               Container(
//                 width: double.infinity,
//                 height: 56,
//                 margin: const EdgeInsets.fromLTRB(20, 32, 20, 24),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     _signup();
//                     context.read<StepProvider>().addStep();
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => LoginIdentityVeiw()));
//                   },
//                   child: const Text(
//                     "모두 동의하기",
//                     style: TextStyle(
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
//
//   Widget termsList(BuildContext context, String agency) {
//     bool? _isChecked = false;
//     return Container(
//         width: double.infinity,
//         padding: const EdgeInsets.fromLTRB(24, 1, 0, 1),
//         child: TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               agencyController.text = agency;
//             },
//             style: const ButtonStyle(
//               alignment: Alignment.centerLeft,
//             ),
//             child: Row(
//               children: [
//                 //  Checkbox(
//                 //         value: _isChecked,
//                 //         onChanged: (value) {
//                 //           setState(() {
//                 //             _isChecked = value;
//                 //           });
//                 //         }
//                 //       ),
//               ],
//             )));
//   }
// }
