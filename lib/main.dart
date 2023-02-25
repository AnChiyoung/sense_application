import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/providers.dart';
import 'package:sense_flutter_application/views/calendar/calendar_body_view.dart';
import 'models/login/login_provider.dart';
import 'native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: '1fc38e74f272a85e46bc10b37fdbebcd');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeMenuProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => TermProvider()),
        ChangeNotifierProvider(create: (_) => StepProvider()),
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        // 여기에 추가하시면 되여
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sense flutter application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NativeSplash(),
    );
  }
}