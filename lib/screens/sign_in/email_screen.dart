import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/sign_in/email_view.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
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
                    EmailHeader(),
                    EmailDescription(),
                    EmailPasswordInputField(),
                  ]
                ),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: EmailButton())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
