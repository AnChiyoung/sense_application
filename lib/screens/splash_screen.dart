import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:sense_flutter_application/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoad = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      AuthService().setUserDetails().then((value) {
        if (mounted) {
          setState(() {
            isLoad = true;
          });
        }
      });
    } catch (error) {
      print(error);
      print('Error while fetching user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoad) {
      Future.delayed(const Duration(seconds: 2), () {
        GoRouter.of(context).go('/home');
      });
    }

    return Scaffold(
      body: Center(child: SvgPicture.asset('lib/assets/images/logo.svg')),
    );
  }
}
