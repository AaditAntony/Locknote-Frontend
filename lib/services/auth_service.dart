import 'package:dio/dio.dart';
import '../core/api/api_client.dart';
import '../core/storage/token_storage.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    await _dio.post(
      '/auth/register',
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final token = response.data['token'];
    await TokenStorage.saveToken(token);
  }
}
