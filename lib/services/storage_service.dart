import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static late SharedPreferences _prefs;

  // Initialize storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Keys
  static const String _usersKey = 'fitness_users';
  static const String _currentUserKey = 'current_user';
  static const String _measurementsKey = 'measurements';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save all users
  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final jsonString = jsonEncode(users);
    await _prefs.setString(_usersKey, jsonString);
  }

  // Get all users
  static List<Map<String, dynamic>> getUsers() {
    final jsonString = _prefs.getString(_usersKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Save current user
  static Future<void> saveCurrentUser(Map<String, dynamic>? user) async {
    if (user == null) {
      await _prefs.remove(_currentUserKey);
    } else {
      final jsonString = jsonEncode(user);
      await _prefs.setString(_currentUserKey, jsonString);
    }
  }

  // Get current user
  static Map<String, dynamic>? getCurrentUser() {
    final jsonString = _prefs.getString(_currentUserKey);
    if (jsonString == null || jsonString.isEmpty) return null;
    return Map<String, dynamic>.from(jsonDecode(jsonString));
  }

  // Save login state
  static Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Save measurements
  static Future<void> saveMeasurements(List<Map<String, dynamic>> measurements) async {
    final jsonString = jsonEncode(measurements);
    await _prefs.setString(_measurementsKey, jsonString);
  }

  // Get measurements
  static List<Map<String, dynamic>> getMeasurements() {
    final jsonString = _prefs.getString(_measurementsKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Clear all data (logout)
  static Future<void> clearAll() async {
    await _prefs.remove(_currentUserKey);
    await _prefs.remove(_isLoggedInKey);
  }

  // Clear everything (for account deletion)
  static Future<void> clearEverything() async {
    await _prefs.clear();
  }
}