import 'package:shared_preferences/shared_preferences.dart';

/// url 및 params 정책은 백엔드 개발자와 상의한다.
/// server base url은 하위 슬래시까지 표기 x : sense/api
/// api url은 하위 슬래시까지 표기 x : base url + /login/kakao

class ApiUrl {
  static String devUrl = 'https://server.dev.sens.im/api/v1';
  static String liveUrl = 'https://server.sens.im/api/v1';
  static String stagingUrl = 'https://server.stg.sens.im/api/v1';
  static String releaseUrl = devUrl;

// post create event model
  static String createEventPath = '$devUrl/event';
  static String recommendListPath = '$devUrl/suggestions?recommend_type=';


  static setDevUrl() {
    releaseUrl = devUrl;
    createEventPath = '$devUrl/event';
    recommendListPath = '$devUrl/suggestions?recommend_type=';
  }

  static setStagingUrl() {
    releaseUrl = stagingUrl;
    createEventPath = '$stagingUrl/event';
    recommendListPath = '$stagingUrl/suggestions?recommend_type=';
  }

  static setLiveUrl() {
    releaseUrl = liveUrl;
    createEventPath = '$liveUrl/event';
    recommendListPath = '$liveUrl/suggestions?recommend_type=';
  }

  static Future<String> initEnvironment() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? env = pref.getString('env_mode');
    if (env == 'stg') {
      setStagingUrl();
      pref.setString('env_mode', 'stg');
      return 'stg';
    } 
    
    if (env == 'live') {
      setLiveUrl();
      pref.setString('env_mode', 'live');
      return 'live';
    } 
    
    setDevUrl();
    pref.setString('env_mode', 'dev');
    return 'dev';
  }

  static Future<String> setEnvironmentState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? env = pref.getString('env_mode');
    if (env == 'dev') {
      setStagingUrl();
      pref.setString('env_mode', 'stg');
      return 'stg';
    } 
    
    if (env == 'stg') {
      setLiveUrl();
      pref.setString('env_mode', 'live');
      return 'live';
    } 

    setDevUrl();
    pref.setString('env_mode', 'dev');
    return 'dev';
  }


}