import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';

class NativeSplash extends StatefulWidget {
  const NativeSplash({super.key});

  @override
  State<NativeSplash> createState() => _NativeSplash();
}

class _NativeSplash extends State<NativeSplash> {

  @override
  void initState() {
    super.initState();
    splashInitialization();
    hiveInit();
    ApiUrl.initEnvironment();
  }

  void hiveInit() async {
    var box = await Hive.openBox('eventModelListBox');
  }

  void splashInitialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// iOS status bar set
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: LoginScreen(),
        ),
      ),
    );
  }
}