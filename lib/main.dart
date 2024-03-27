import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:sense_flutter_application/config/router_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(
    nativeAppKey: 'f1489d23cb70cd99057f97d645b8ae03',
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(ProviderScope(child: RouterView()));
  });

  // runApp(
  //   ProviderScope(child: RouterView())
  // );
}
