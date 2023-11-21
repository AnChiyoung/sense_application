import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:sense_flutter_application/screens/my_page/my_page_screen.dart';
import 'package:sense_flutter_application/views/add_event/add_event_provider.dart';
import 'package:sense_flutter_application/views/create_event_view/create_event_provider.dart';
import 'package:sense_flutter_application/views/event_detail/event_detail_provider.dart';
import 'package:sense_flutter_application/views/event_info/recommend_request/recommend_request_provider.dart';
import 'package:sense_flutter_application/views/home/home_provider.dart';
import 'package:sense_flutter_application/views/animation/animation_provider.dart';
import 'package:sense_flutter_application/views/event_feed/event_feed_provider.dart';
import 'package:sense_flutter_application/views/calendar/calendar_provider.dart';
import 'package:sense_flutter_application/views/contact/contacts_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_provider.dart';
import 'package:sense_flutter_application/views/feed/feed_search_provider.dart';
import 'package:sense_flutter_application/views/login/login_provider.dart';
import 'package:sense_flutter_application/views/my_page/my_page_provider.dart';
import 'package:sense_flutter_application/views/preference/food_preference_result_screen.dart';
import 'package:sense_flutter_application/views/preference/food_preference_screen.dart';
import 'package:sense_flutter_application/views/preference/lodging_preference_result_screen.dart';
import 'package:sense_flutter_application/views/preference/lodging_preference_screen.dart';
import 'package:sense_flutter_application/views/preference/preference_provider.dart';
import 'package:sense_flutter_application/views/preference/travel_preference_result_screen.dart';
import 'package:sense_flutter_application/views/preference/travel_preference_screen.dart';
import 'package:sense_flutter_application/views/recommended_event/recommended_event_provider.dart';
import 'package:sense_flutter_application/views/sign_in/sign_in_provider.dart';
import 'package:sense_flutter_application/views/store/store_provider.dart';
import 'models/login/login_provider.dart';
import 'native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

/// 375 * 812 (include safe area..)

void main() async {
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // splash screen 설정. remove하기 전까지 남아있음
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // hive(=저장소) init
  await Hive.initFlutter();
  await initializeDateFormatting();

  /// android status bar set
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  KakaoSdk.init(
    nativeAppKey: '1fc38e74f272a85e46bc10b37fdbebcd',
    javaScriptAppKey: '90dd5b3346fbc9c76d27afbd3b2fc068',
    loggingEnabled: true,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => SigninProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => CalendarProvider()),
      ChangeNotifierProvider(create: (_) => TermProvider()),
      ChangeNotifierProvider(create: (_) => StepProvider()),
      ChangeNotifierProvider(create: (_) => AddEventProvider()),
      ChangeNotifierProvider(create: (_) => RecommendedEventProvider()),
      ChangeNotifierProvider(create: (_) => FeedProvider()),
      ChangeNotifierProvider(create: (_) => FeedSearchProvider()),
      ChangeNotifierProvider(create: (_) => CalendarBodyProvider()),
      ChangeNotifierProvider(create: (_) => ContactProvider()),
      ChangeNotifierProvider(create: (_) => MyPageProvider()),
      ChangeNotifierProvider(create: (_) => RecommendRequestProvider()),
      ChangeNotifierProvider(create: (_) => EventFeedProvider()),
      ChangeNotifierProvider(create: (_) => AnimationProvider()),
      ChangeNotifierProvider(create: (_) => StoreProvider()),
      ChangeNotifierProvider(create: (_) => CEProvider()),
      ChangeNotifierProvider(create: (_) => EDProvider()),
      ChangeNotifierProvider(create: (_) => PreferenceProvider()),
      // ChangeNotifierProvider(create: (_) => CEProvider()),
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
          initialRoute: '/',
          routes: {
            '/my-page': (context) => const MyPageScreen(),
            '/food-preference': (context) => const FoodPreferenceScreen(),
            '/food-preference-result': (context) => const FoodPreferenceResultScreen(),
            '/lodging-preference': (context) => const LodgingPreferenceScreen(),
            '/lodging-preference-result': (context) => const LodgingPreferenceResultScreen(),
            '/travel-preference': (context) => const TravelPreferenceScreen(),
            '/travel-preference-result': (context) => const TravelPreferenceResultScreen(),
          },

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

// class ResponsiveApp {
//   static late MediaQueryData _mediaQueryData;
//   static MediaQueryData get mediaQuery => _mediaQueryData;

//   static void setMediaQuery(BuildContext context) {
//     _mediaQueryData = MediaQuery.of(context);
//   }
// }
