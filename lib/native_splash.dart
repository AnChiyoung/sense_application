// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/constants/api_path.dart';
import 'package:sense_flutter_application/models/login/login_model.dart';
import 'package:sense_flutter_application/models/user/user_model.dart';
import 'package:sense_flutter_application/routes/additional_info/additional_info_screen.dart';
import 'package:sense_flutter_application/screens/home/home_screen.dart';
import 'package:sense_flutter_application/screens/login/login_screen.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // void hiveInit() async {
  //   var box = await Hive.openBox('eventModelListBox');
  // }

  void splashInitialization() async {
    await Future.delayed(const Duration(seconds: 2));
    await ApiUrl.initEnvironment();
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    if (sharedPref.getBool('is_auto_login') == true) {
      initAutoLoginState();
      // user/me 호출해서 값 바인딩
      UserModel user = await UserRequest().userInfoRequest();
      if (user.id == null) {
        // 에러나면 로그인 화면으로
        navigateToLoginScreen();
      } else {
        PresentUserInfo.id = user.id!;
        PresentUserInfo.username = user.username ?? '';
        PresentUserInfo.profileImage = user.profileImageString ?? '';
        PresentUserInfo.loginToken = await LoginRequest.storage.read(key: 'loginToken') ?? '';
        if (user.isAddProfile == true) {
          navigateToHomeScreen();
        } else {
          navigateAdditionalInfoScreen();
        }
      }
    } else {
      navigateToLoginScreen();
    }

    FlutterNativeSplash.remove();
  }

  void initAutoLoginState() {
    context.read<LoginProvider>().autoLoginBoxState(true, false);
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(initPage: 0),
      ),
    );
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void navigateAdditionalInfoScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AdditionalInfoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// iOS status bar set
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
