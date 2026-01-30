// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static late SharedPreferences _prefs;
  static bool _isInitialized = false;

  // Initialize storage
  static Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      print('StorageService initialized');
    }
  }

  // Ensure initialization
  static Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }

  // Keys
  static const String _usersKey = 'fitness_users';
  static const String _currentUserKey = 'current_user';
  static const String _measurementsKey = 'measurements';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save all users
  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    await _ensureInitialized();
    try {
      final jsonString = jsonEncode(users);
      await _prefs.setString(_usersKey, jsonString);
      print('Users saved to storage: ${users.length} users');
    } catch (e) {
      print('Error saving users: $e');
      rethrow;
    }
  }

  // Get all users
  static List<Map<String, dynamic>> getUsers() {
    if (!_isInitialized) {
      print('WARNING: StorageService not initialized when getting users');
      return [];
    }

    try {
      final jsonString = _prefs.getString(_usersKey);
      if (jsonString == null || jsonString.isEmpty) {
        print('No users found in storage');
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      final users = jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
      print('Users loaded from storage: ${users.length} users');
      return users;
    } catch (e) {
      print('Error getting users from storage: $e');
      return [];
    }
  }

  // Save current user
  static Future<void> saveCurrentUser(Map<String, dynamic>? user) async {
    await _ensureInitialized();
    try {
      if (user == null) {
        await _prefs.remove(_currentUserKey);
        print('Current user cleared from storage');
      } else {
        final jsonString = jsonEncode(user);
        await _prefs.setString(_currentUserKey, jsonString);
        print('Current user saved: ${user['username']}');
      }
    } catch (e) {
      print('Error saving current user: $e');
      rethrow;
    }
  }

  // Get current user
  static Map<String, dynamic>? getCurrentUser() {
    if (!_isInitialized) {
      print(
          'WARNING: StorageService not initialized when getting current user');
      return null;
    }

    try {
      final jsonString = _prefs.getString(_currentUserKey);
      if (jsonString == null || jsonString.isEmpty) {
        print('No current user found in storage');
        return null;
      }
      final user = Map<String, dynamic>.from(jsonDecode(jsonString));
      print('Current user loaded: ${user['username']}');
      return user;
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  // Save login state
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await _ensureInitialized();
    await _prefs.setBool(_isLoggedInKey, isLoggedIn);
    print('Login state set to: $isLoggedIn');
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    if (!_isInitialized) {
      return false;
    }
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save measurements
  static Future<void> saveMeasurements(
      List<Map<String, dynamic>> measurements) async {
    await _ensureInitialized();
    final jsonString = jsonEncode(measurements);
    await _prefs.setString(_measurementsKey, jsonString);
  }

  // Get measurements
  static List<Map<String, dynamic>> getMeasurements() {
    if (!_isInitialized) {
      return [];
    }

    final jsonString = _prefs.getString(_measurementsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Clear all data (logout)
  static Future<void> clearAll() async {
    await _ensureInitialized();
    print('Clearing all user data (logout)');
    await _prefs.remove(_currentUserKey);
    await _prefs.remove(_isLoggedInKey);
  }

  // Clear everything (for account deletion)
  static Future<void> clearEverything() async {
    await _ensureInitialized();
    print('Clearing ALL storage data');
    await _prefs.clear();
    _isInitialized = false; // Reset initialization state
  }
}
