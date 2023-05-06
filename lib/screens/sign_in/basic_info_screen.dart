import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/sign_in/basic_info_view.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({Key? key}) : super(key: key);

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  @override
  Widget build(BuildContext context) {
    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      children: const [
                        BasicInfoHeader(),
                        BasicInfoDescription(),
                        BasicInfoInputField(),
                      ],
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: BasicInfoAuthButton())
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
