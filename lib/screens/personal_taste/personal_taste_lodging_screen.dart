import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/personal_taste/personal_taste_lodging_view.dart';

class PersonalTasteLodgingScreen extends StatefulWidget {
  const PersonalTasteLodgingScreen({super.key});

  @override
  State<PersonalTasteLodgingScreen> createState() => _PersonalTasteLodgingScreenState();
}

class _PersonalTasteLodgingScreenState extends State<PersonalTasteLodgingScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const LodgingHeader(),
                      LodgingContent(deviceWidth: deviceWidth),
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LodgingButton(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
