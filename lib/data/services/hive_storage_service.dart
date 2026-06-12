import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService {
  static const String _boxName = 'fitness_app';

  static late Box<String> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  // ── Users ──
  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final json = jsonEncode(users);
    await _box.put('users', json);
  }

  static List<Map<String, dynamic>> getUsers() {
    final json = _box.get('users');
    if (json == null || json.isEmpty) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.cast<Map<String, dynamic>>();
  }

  // ── Current user ──
  static Future<void> saveCurrentUser(Map<String, dynamic>? user) async {
    if (user == null) {
      await _box.delete('currentUser');
    } else {
      await _box.put('currentUser', jsonEncode(user));
    }
  }

  static Map<String, dynamic>? getCurrentUser() {
    final json = _box.get('currentUser');
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }

  // ── Measurements (per user) ──
  static Future<void> saveMeasurements(
      String username, List<Map<String, dynamic>> measurements) async {
    final key = 'measurements_$username';
    await _box.put(key, jsonEncode(measurements));
  }

  static List<Map<String, dynamic>> getMeasurements(String username) {
    final key = 'measurements_$username';
    final json = _box.get(key);
    if (json == null) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.cast<Map<String, dynamic>>();
  }

  // ── Guest settings ──
  static Future<void> setGuestDarkMode(bool isDark) async {
    await _box.put('guestDarkMode', isDark ? 'true' : 'false');
  }

  static bool getGuestDarkMode() => _box.get('guestDarkMode') == 'true';

  // ── Onboarding ──
  static bool hasSeenOnboarding() => _box.get('onboardingSeen') == 'true';

  static Future<void> setOnboardingSeen() async {
    await _box.put('onboardingSeen', 'true');
  }

  // ── Clear ──
  static Future<void> clearCurrentSession() async {
    await _box.delete('currentUser');
    await _box.delete('guestDarkMode');
  }

  static Future<void> deleteUserData(String username) async {
    await _box.delete('measurements_$username');
  }
}
