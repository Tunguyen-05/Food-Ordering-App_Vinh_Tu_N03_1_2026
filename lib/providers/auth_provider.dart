import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;
  bool _isLoading = false;
  String? _error;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin == true;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId != null) {
      _currentUser = _authService.getUserById(userId);
      notifyListeners();
    }
  }

  bool login(String phone, String password) {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = _authService.login(phone, password);
      if (_currentUser != null) {
        _saveUserId(_currentUser!.id!);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Số điện thoại hoặc mật khẩu không đúng';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Đã xảy ra lỗi: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  bool register(String phone, String password, String name) {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = _authService.register(phone, password, name);
      if (user != null) {
        _currentUser = user;
        _saveUserId(user.id!);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Số điện thoại đã được đăng ký';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Đã xảy ra lỗi: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    _currentUser = null;
    notifyListeners();
  }

  bool updateAddress(String address) {
    if (_currentUser == null) return false;
    final success = _authService.updateAddress(_currentUser!.id!, address);
    if (success) {
      _currentUser = _currentUser!.copyWith(address: address);
      notifyListeners();
    }
    return success;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
