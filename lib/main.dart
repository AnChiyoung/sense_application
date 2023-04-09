import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/providers.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:sense_flutter_application/views/calendar/calendar_body_view.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_search_provider.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';
import 'models/login/login_provider.dart';
import 'native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(nativeAppKey: '1fc38e74f272a85e46bc10b37fdbebcd');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeMenuProvider()),
      ChangeNotifierProvider(create: (_) => DateProvider()),
      ChangeNotifierProvider(create: (_) => TermProvider()),
      ChangeNotifierProvider(create: (_) => StepProvider()),
      ChangeNotifierProvider(create: (_) => DateProvider()),
      ChangeNotifierProvider(create: (_) => PageProvider()),
      ChangeNotifierProvider(create: (_) => AddEventProvider()),
      ChangeNotifierProvider(create: (_) => RecommendedEventProvider()),
      ChangeNotifierProvider(create: (_) => FeedProvider()),
      ChangeNotifierProvider(create: (_) => FeedSearchProvider()),
      // 여기에 추가하시면 되여
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// 현재 context를 가져오기 위한 global key state set
      // navigatorKey: CandyGlobalVariable.naviagatorState,
      /// 모든 기능 페이지에서 home으로 이동 시, route stack을 제거하기 위해 home만 router name을 사용
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const HomeScreen(),
      // },
      debugShowCheckedModeBanner: false,
      title: 'Sense flutter application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NativeSplash(),
    );
  }
}

/// 현재 context를 가져오기 위한 global key state set
// class CandyGlobalVariable {
//   static final GlobalKey<NavigatorState> naviagatorState =
//   GlobalKey<NavigatorState>();
// }