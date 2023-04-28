import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/sign_in/policy_view.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_header_view.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({Key? key}) : super(key: key);

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {

    /// safe area height
    final safeAreaTopPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PolicyHeader(),
            PolicyDescription(),
            PolicyCheckField(topPadding: safeAreaTopPadding),
            PolicyButton(),
          ],
        ),
      ),
    );
  }
}
