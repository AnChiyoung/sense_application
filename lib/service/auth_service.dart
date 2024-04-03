  import 'package:flutter_secure_storage/flutter_secure_storage.dart';

  class AuthService {
    final FlutterSecureStorage _storage = const FlutterSecureStorage();

    Future<void> setAccessToken(String token) async {
      await _storage.write(key: 'access_token', value: token);
    }

    Future<void> setRefreshToken(String token) async {
      await _storage.write(key: 'refresh_token', value: token);
    }

    Future<String?> getAccessToken() async {
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
  }