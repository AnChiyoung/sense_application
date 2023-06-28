// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sense_flutter_application/constants/public_color.dart';
// import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
//
// class ContactSearchField extends StatefulWidget {
//   const ContactSearchField({Key? key}) : super(key: key);
//
//   @override
//   State<ContactSearchField> createState() => _ContactSearchFieldState();
// }
//
// class _ContactSearchFieldState extends State<ContactSearchField> {
//
//   TextEditingController searchController = TextEditingController();
//   FocusNode searchFieldFocusNode = FocusNode();
//
//   @override
//   void initState() {
//     searchFieldFocusNodeListen();
//     super.initState();
//   }
//
//   void searchFieldFocusNodeListen() {
//     searchFieldFocusNode.addListener(() {
//       if(searchFieldFocusNode.hasFocus) {
//         context.read<ContactProvider>().isSearchState(true);
//       } else {
//         context.read<ContactProvider>().isSearchState(false);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//       child: Stack(
//         alignment: Alignment.centerRight,
//         children: [
//           contactSearchBox(),
//           Padding(padding: const EdgeInsets.only(right: 2), child: searchButton()),
//         ]
//       )
//     );
//   }
//
//   Widget contactSearchBox() {
//     return TextFormField(
//       controller: searchController,
//       focusNode: searchFieldFocusNode,
//       obscureText: false,
//       maxLines: 1,
//       maxLength: 7,
//       textAlignVertical: TextAlignVertical.center,
//       decoration: InputDecoration(
//         isDense: false,
//         filled: true,
//         fillColor: StaticColor.loginInputBoxColor,
//         contentPadding: const EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
//         counterText: '',
//         hintText: '친구를 검색해 주세요',
//         hintStyle: TextStyle(fontSize: 14, color: StaticColor.loginHintTextColor, fontWeight: FontWeight.w400),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(4.0),
//           borderSide: const BorderSide(
//             width: 1, color: Colors.transparent,
//           )
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 1, color: Colors.transparent,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget searchButton() {
//     return Consumer<ContactProvider>(
//       builder: (context, data, child) => data.searchState == true
//         ? Material(
//           color: Colors.transparent,
//           child: InkWell(
//             customBorder: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//             onTap: () {},
//             child: SizedBox(
//                 width: 36,
//                 height: 36,
//                 child: Center(child: Image.asset('assets/contact/searchbox_delete_button.png', width: 24, height: 24, color: StaticColor.grey2))),
//           )
//         )
//         : Material(
//             color: Colors.transparent,
//             child: InkWell(
//               customBorder: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               onTap: () {},
//               child: SizedBox(
//                 width: 36,
//                 height: 36,
//                 child: Center(child: Image.asset('assets/contact/search_button.png', width: 24, height: 24))),
//             )
//           ),
//     );
//   }
// }
