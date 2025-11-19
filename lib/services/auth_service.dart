import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_routes.dart';

class AuthService extends ChangeNotifier {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Auth state properties
  bool isLoggedIn = false;
  bool hasCompletedOnboarding = false;
  bool isInitialized = false;

  // Keys for shared preferences
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _hasCompletedOnboardingKey = 'hasCompletedOnboarding';

  // Initialize auth state from secure storage
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load auth state from storage
      isLoggedIn = false; // Always reset login on app start for demo
      hasCompletedOnboarding = false; // Always reset onboarding on app start

      // Save the reset state to storage
      await _saveAuthState();

      // Simulate additional initialization time
      await Future.delayed(const Duration(milliseconds: 500));

      isInitialized = true;
      notifyListeners();
    } catch (e) {
      // Fallback to default values if storage fails
      isLoggedIn = false;
      hasCompletedOnboarding = false;
      isInitialized = true;
      notifyListeners();
    }
  }

  // Reset onboarding for testing splash screen
  void resetOnboarding() {
    hasCompletedOnboarding = false;
    notifyListeners();
  }

  // Login method
  Future<bool> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, accept any email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      isLoggedIn = true;
      await _saveAuthState();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Signup method
  Future<bool> signup(String fullName, String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, accept any input
    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      isLoggedIn = true;
      await _saveAuthState();
      notifyListeners();
      return true;
    }
    return false;
  }

  // Logout method
  Future<void> logout() async {
    isLoggedIn = false;
    await _saveAuthState();
    notifyListeners();
  }

  // Complete onboarding
  Future<void> completeOnboarding() async {
    hasCompletedOnboarding = true;
    await _saveAuthState();
    notifyListeners();
  }

  // Save auth state to secure storage
  Future<void> _saveAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, isLoggedIn);
      await prefs.setBool(_hasCompletedOnboardingKey, hasCompletedOnboarding);
    } catch (e) {
      // Handle storage errors silently in demo
      debugPrint('Failed to save auth state: $e');
    }
  }

  // Get redirect path based on auth state
  String getRedirectPath() {
    if (!isInitialized) return AppRoutes.splash;
    return AppRoutes.splash; // Always show splash screen first
  }
}
