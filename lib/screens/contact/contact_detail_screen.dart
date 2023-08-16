import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/public_color.dart';
import 'package:sense_flutter_application/models/contact/contact_model.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:sense_flutter_application/views/contact/detail/ai_analytics_view.dart';
import 'package:sense_flutter_application/views/contact/detail/bottom_button_view.dart';
import 'package:sense_flutter_application/views/contact/detail/combine_event_view.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_friend_info_view.dart';
import 'package:sense_flutter_application/views/contact/detail/contact_detail_header_view.dart';
import 'package:sense_flutter_application/views/contact/detail/favorite_view.dart';

class ContactDetailScreen extends StatefulWidget {
  ContactModel contactModel;
  ContactDetailScreen({Key? key, required this.contactModel}) : super(key: key);

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
  Widget build(BuildContext context) {
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
                  Column(
                    children: [
                      ContactDetailHeader(contactModel: model!),
                      Container(height: 1.0, color: StaticColor.grey200EE),
                      ContactDetailFriendInfoView(contactModel: model!),
                      const AiAnalyticsView(),
                      const CombineEventView(),
                      FavoriteListView(contactModel: model!),
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
}
