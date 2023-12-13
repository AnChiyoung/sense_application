import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  static const String _devDomain = 'server.dev.sens.im';
  static const String _stgDomain = 'server.stg.sens.im';
  static const String _liveDomain = 'server.sens.im';

  static const String _devUrl = 'https://server.dev.sens.im/api/v1';
  static const String _stagingUrl = 'https://server.stg.sens.im/api/v1';
  static const String _liveUrl = 'https://server.sens.im/api/v1';

  static String releaseUrl = _devUrl;
  static String releaseDomain = _devDomain;

  static setDevUrl(SharedPreferences pref) async {
    pref.setString('env_mode', 'dev');
    releaseUrl = _devUrl;
    releaseDomain = _devDomain;
  }

  static setStagingUrl(SharedPreferences pref) async {
    pref.setString('env_mode', 'stg');
    releaseUrl = _stagingUrl;
    releaseDomain = _stgDomain;
  }

  static setLiveUrl(SharedPreferences pref) async {
    pref.setString('env_mode', 'live');
    releaseUrl = _liveUrl;
    releaseDomain = _liveDomain;
  }

  static Future initEnvironment() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? env = pref.getString('env_mode');
    if (env == null) setDevUrl(pref);
  }

  static Future<String> setEnvironmentState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? env = pref.getString('env_mode');
    if (env == 'dev') {
      await setStagingUrl(pref);
      return 'stg';
    }

    if (env == 'stg') {
      await setLiveUrl(pref);
      return 'live';
    }

    await setDevUrl(pref);
    return 'dev';
  }
}
