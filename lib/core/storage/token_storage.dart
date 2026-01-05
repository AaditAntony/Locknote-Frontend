import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'jwt_token';

  static Future<void> saveToken(String token) async {
    debugPrint('💾 Saving JWT token');
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    debugPrint('📤 Retrieved token: $token');
    return token;
  }

  static Future<void> clearToken() async {
    debugPrint('🧹 Clearing token');
    await _storage.delete(key: _tokenKey);
  }
}
