import 'package:flutter/material.dart';
import 'package:sense_flutter_application/routes/setting/setting_content.dart';
import 'package:sense_flutter_application/routes/setting/setting_header.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    /// safe area height
    // final safeAreaTopPadding = MediaQuery.of(context).padding.top;
    // final safeAreaBottomPadding = MediaQuery.of(context).padding.bottom;

    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            SettingHeader(),
            SettingContent(),
          ],
        ),
      ),
    );
  }
}
