import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService {
  static const String _boxName = 'fitness_app_enc';
  static const String _encKeyKey = 'hive_encryption_key';

  static late Box<String> _box;
  static const _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    await Hive.initFlutter();

    final key = await _getOrCreateEncryptionKey();

    _box = await Hive.openBox<String>(_boxName, encryptionKey: key);
  }

  static Future<List<int>> _getOrCreateEncryptionKey() async {
    final stored = await _secureStorage.read(key: _encKeyKey);
    if (stored != null) {
      return base64Url.decode(stored);
    }
    final key = Hive.generateSecureKey();
    await _secureStorage.write(key: _encKeyKey, value: base64Url.encode(key));
    return key;
  }

  // ── Users ──
  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    await _box.put('users', jsonEncode(users));
  }

  static List<Map<String, dynamic>> getUsers() {
    final json = _box.get('users');
    if (json == null || json.isEmpty) return [];
    final List<dynamic> list = jsonDecode(json);
    return list.cast<Map<String, dynamic>>();
  }

  // ── Current user ID (session reference only) ──
  static Future<void> saveCurrentUserId(String? userId) async {
    if (userId == null) {
      await _box.delete('currentUserId');
    } else {
      await _box.put('currentUserId', userId);
    }
  }

  static String? getCurrentUserId() => _box.get('currentUserId');

  static Future<void> saveCurrentUser(Map<String, dynamic>? _) async {
    // Deprecated — only user ID is stored now.
  }

  static Map<String, dynamic>? getCurrentUser() => null;

  // ── Measurements (per user) ──
  static Future<void> saveMeasurements(
      String username, List<Map<String, dynamic>> measurements) async {
    await _box.put('measurements_$username', jsonEncode(measurements));
  }

  static List<Map<String, dynamic>> getMeasurements(String username) {
    final json = _box.get('measurements_$username');
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
    await _box.delete('currentUserId');
    await _box.delete('guestDarkMode');
  }

  static Future<void> deleteUserData(String username) async {
    await _box.delete('measurements_$username');
  }

  static Future<void> clearGuestMeasurements() async {
    await _box.delete('measurements_Guest');
  }
}
