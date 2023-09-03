import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/providers.dart';
import 'package:sense_flutter_application/views/create_event/create_event_improve_provider.dart';
import 'package:sense_flutter_application/views/event_info/event_info_provider.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:sense_flutter_application/views/create_event/create_event_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_search_provider.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/personal_taste/taste_provider.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';
import 'models/login/login_provider.dart';
import 'native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

/// 375 * 812 (include safe area..)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  await initializeDateFormatting();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /// android status bar set
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      ),
  );
  
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  KakaoSdk.init(
    nativeAppKey: '1fc38e74f272a85e46bc10b37fdbebcd',
    javaScriptAppKey: '90dd5b3346fbc9c76d27afbd3b2fc068',
    loggingEnabled: true,
  );
  // // 앱 화면방향 세로 고정
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
  //     .then((_) => runApp(const MyApp()));

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => SigninProvider()),
          ChangeNotifierProvider(create: (_) => HomeMenuProvider()),
          ChangeNotifierProvider(create: (_) => CalendarProvider()),
          ChangeNotifierProvider(create: (_) => TermProvider()),
          ChangeNotifierProvider(create: (_) => StepProvider()),
          ChangeNotifierProvider(create: (_) => AddEventProvider()),
          ChangeNotifierProvider(create: (_) => RecommendedEventProvider()),
          ChangeNotifierProvider(create: (_) => FeedProvider()),
          ChangeNotifierProvider(create: (_) => FeedSearchProvider()),
          ChangeNotifierProvider(create: (_) => CalendarBodyProvider()),
          ChangeNotifierProvider(create: (_) => ContactProvider()),
          ChangeNotifierProvider(create: (_) => CreateEventProvider()),
          ChangeNotifierProvider(create: (_) => EventInfoProvider()),
          ChangeNotifierProvider(create: (_) => MyPageProvider()),
          ChangeNotifierProvider(create: (_) => TasteProvider()),
          ChangeNotifierProvider(create: (_) => CreateEventImproveProvider()),
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

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // color: Colors.white,
          /// 현재 context를 가져오기 위한 global key state set
          // navigatorKey: CandyGlobalVariable.naviagatorState,
          /// 모든 기능 페이지에서 home으로 이동 시, route stack을 제거하기 위해 home만 router name을 사용
          // initialRoute: '/',
          // routes: {
          //   '/': (context) => const HomeScreen(),
          // },
          /// picker localization
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', ''),
            Locale('en', ''),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Sense flutter application',
          home: const NativeSplash(),
        );
      },
    );
  }
}

/// 현재 context를 가져오기 위한 global key state set
// class CandyGlobalVariable {
//   static final GlobalKey<NavigatorState> naviagatorState =
//   GlobalKey<NavigatorState>();
// }