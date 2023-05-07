import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/sign_in/phone_auth_view.dart';

class PhoneAuthScreen extends StatefulWidget {
  String phoneNumber;
  PhoneAuthScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  @override
  Widget build(BuildContext context) {
    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding,
              child: Column(
                children: [
                  PhoneAuthHeader(),
                  PhoneAuthDescription(),
                  PhoneAuthInputField(phoneNumber: widget.phoneNumber),
                  // PhoneAuthButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
