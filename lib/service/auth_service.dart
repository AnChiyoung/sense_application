import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sense_flutter_application/apis/auth/auth_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> setAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  static Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'access_token');
  }

  static Future<String?> getRefreshToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'refresh_token');
  }

  Future<void> removeTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  Future<void> storeUserDetails(Map<String, dynamic> userDetails) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userDetails', json.encode(userDetails));
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    print('getUserDetails');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userDetailsString = prefs.getString('userDetails') ?? '{}';
    return json.decode(userDetailsString);
  }

  Future<void> setUserDetails() async {
    if (await getAccessToken() != null) {
      AuthApi().me().then((value) {
        storeUserDetails(value['data']);
      });
    }
  }
}
