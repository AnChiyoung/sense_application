import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sense_flutter_application/login_check.dart';
import 'package:sense_flutter_application/screens/calendar/calendar_month_select_screen.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';

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
  }

  void splashInitialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: const HomeScreen(),
        // child: const LoginCheck(),
        // child: const Center(
        //   child: Text('SENSE APPLICATION'),

      ),
    );
  }
}