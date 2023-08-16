import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/personal_taste/personal_taste_travel_view.dart';

class PersonalTasteTravelScreen extends StatefulWidget {
  const PersonalTasteTravelScreen({super.key});

  @override
  State<PersonalTasteTravelScreen> createState() => _PersonalTasteTravelScreenState();
}

class _PersonalTasteTravelScreenState extends State<PersonalTasteTravelScreen> {
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
                      TravelHeader(),
                      TravelContent(deviceWidth: deviceWidth),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TravelButton(),
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
