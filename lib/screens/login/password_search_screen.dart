import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/login/password_search_view.dart';

class PasswordSearchScreen extends StatefulWidget {
  const PasswordSearchScreen({Key? key}) : super(key: key);

  @override
  State<PasswordSearchScreen> createState() => _PasswordSearchScreenState();
}

class _PasswordSearchScreenState extends State<PasswordSearchScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - safeAreaTopPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      children: [
                        PasswordSearchInfoInputHeader(),
                        PasswordSearchInfoInputDescription(),
                        PasswordSearchInfoInputField(),
                      ]
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter,
                      child: PasswordSearchInfoInputButton()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
