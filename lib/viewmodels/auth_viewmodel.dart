import 'package:flutter/material.dart';
import '../core/storage/token_storage.dart';
import '../services/auth_service.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    debugPrint('🟡 AuthViewModel.login() START');
    debugPrint('📧 Email: $email');

    _error = null;
    _setLoading(true);

    try {
      debugPrint('➡️ Calling AuthService.login()');

      final token = await _authService.login(
        email: email,
        password: password,
      );

      debugPrint('✅ Token received: $token');

      await TokenStorage.saveToken(token);
      debugPrint('🔐 Token saved to secure storage');
    } catch (e) {
      debugPrint('❌ Login error in ViewModel: $e');
      _error = 'Invalid email or password';
    } finally {
      _setLoading(false);
      debugPrint('🔵 AuthViewModel.login() END');
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    debugPrint('🟡 AuthViewModel.register() START');

    _error = null;
    _setLoading(true);

    try {
      await _authService.register(
        username: username,
        email: email,
        password: password,
      );
      debugPrint('✅ Registration success');
    } catch (e) {
      debugPrint('❌ Registration error: $e');
      _error = 'Registration failed';
    } finally {
      _setLoading(false);
      debugPrint('🔵 AuthViewModel.register() END');
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logout() async {
    print('🔴 Logging out...');
    await TokenStorage.clearToken();
    _error = null;
    notifyListeners();
  }

}
