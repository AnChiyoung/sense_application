import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/detail/ai_analytics_view.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/detail/combine_event_view.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/detail/contact_detail_friend_info_view.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/detail/contact_detail_header_view.dart';
import 'package:sense_flutter_application/views/contact/contact_version02/detail/favorite_view.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';

class ContactDetailScreen extends StatefulWidget {
  ContactModel contactModel;
  ContactDetailScreen({super.key, required this.contactModel});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {

  late ContactModel model;

  /// logger setting
  var logger = Logger(
    printer: PrettyPrinter(
      lineLength: 120,
      colors: true,
      printTime: true,
    ),
  );

  @override
  void initState() {
    print('model from params');
    model = widget.contactModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // return GestureDetector(
    //   onTap: () {
    //     FocusScope.of(context).unfocus();
    //   },
    //   child: Scaffold(
    //     backgroundColor: Colors.white,
    //     body: SafeArea(
    //       bottom: false,
    //       child: SingleChildScrollView(
    //         physics: const ClampingScrollPhysics(),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //                 children: [
    //                   ContactDetailHeader(contactModel: model!),
    //                   Container(height: 1.0, color: StaticColor.grey200EE),
    //                   ContactDetailFriendInfoView(contactModel: model!),
    //                   const AiAnalyticsView(),
    //                   const CombineEventView(),
    //                   FavoriteListView(contactModel: model!),
    //                 ]
    //             ),
    //             const Align(
    //               alignment: Alignment.bottomCenter,
    //               // child: BottomButtonView(),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // return FutureBuilder(
    //   future: ContactRequest().contactDetailRequest(widget.contactModel.id!),
    //   builder: (context, snapshot) {
    //     if(snapshot.hasError) {
    //       return Text('Data fetching..');
    //     } else if(snapshot.hasData) {
    //
    //       if(snapshot.connectionState == ConnectionState.waiting) {
    //         return Container();
    //       } else if(snapshot.connectionState == ConnectionState.done) {
    //
    //         ContactModel model = snapshot.data ?? ContactModel();
    //
    //         return GestureDetector(
    //           onTap: () {
    //             FocusScope.of(context).unfocus();
    //           },
    //           child: Scaffold(
    //             // backgroundColor: Colors.white,
    //             body: SafeArea(
    //               bottom: false,
    //               child: Stack(
    //                 children: [
    //                   Column(
    //                       children: [
    //                         ContactDetailHeader(contactModel: model!),
    //                         Container(height: 1.0, color: StaticColor.grey200EE),
    //                         ContactDetailFriendInfoView(contactModel: model!),
    //                         const AiAnalyticsView(),
    //                         const CombineEventView(),
    //                         FavoriteListView(contactModel: model!),
    //                       ]
    //                   ),
    //                   const Align(
    //                     alignment: Alignment.bottomCenter,
    //                     // child: BottomButtonView(),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         );
    //
    //       } else {
    //         return Container();
    //       }
    //
    //     } else {
    //       return Text('Data fetching..');
    //     }
    //   }
    // );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Consumer<ContactProvider>(
            builder: (context, data, child) {

              if(data.contactModel == ContactProvider.publicEmptyObject) {
                print('model from params');
                model = widget.contactModel;
              } else {
                print('model from provider');
                model = data.contactModel;
              }

              return Stack(
                children: [
                  // aa(model.phone!),
                  Column(
                    children: [
                      ContactDetailHeader(contactModel: model),
                      Container(height: 1.0, color: StaticColor.grey200EE),
                      ContactDetailFriendInfoView(contactModel: model),
                      const AiAnalyticsView(),
                      const CombineEventView(),
                      FavoriteListView(contactModel: model),
                    ]
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    // child: BottomButtonView(),
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget aa(String a) {
    return a == '010-1111-2222' ? Container(width: 50, height: 50, color: Colors.red) : Container(width: 50, height: 50, color: Colors.black);
  }
}
