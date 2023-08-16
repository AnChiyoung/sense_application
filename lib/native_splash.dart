import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';
import 'package:sense_flutter_application/screens/personal_taste/personal_taste_food_screen.dart';

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
        child: LoginScreen(),
        // child: PersonalTasteFoodScreen(),
        // child: TemperatureMenu(),
        // child: CalendarScreen(),
        // child: const HomeScreen(),
        // child: const LoginCheck(),
        // child: EmailScreen(),
        // child: BasicInfoScreen(),
        // child: PhoneAuthScreen(phoneNumber: '01066300387',),
        // child: PhoneAuthScreen(phoneNumber: '01066300387'),
        // child: const Center(
        //   child: Text('SENSE APPLICATION'),
      ),
    );
  }
}