import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      await _authService.register(
        username: username,
        email: email,
        password: password,
      );
      _error = null;
    } catch (e) {
      _error = 'Registration failed';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      await _authService.login(
        email: email,
        password: password,
      );
      _error = null;
    } catch (e) {
      _error = 'Login failed';
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
