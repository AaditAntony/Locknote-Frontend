import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../core/api/api_client.dart';
import '../core/constants/api_constants.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<String> login({
    required String email,
    required String password,
  }) async {
    debugPrint('🟡 AuthService.login()');
    debugPrint('🌐 POST ${ApiConstants.loginEndpoint}');

    final response = await _dio.post(
      ApiConstants.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );

    debugPrint('📥 Status: ${response.statusCode}');
    debugPrint('📦 Response: ${response.data}');

    // ✅ BACKEND RETURNS RAW STRING
    return response.data.toString();
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    debugPrint('🟡 AuthService.register()');
    debugPrint('🌐 POST ${ApiConstants.registerEndpoint}');

    await _dio.post(
      ApiConstants.registerEndpoint,
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    debugPrint('✅ Register API success');
  }
}
