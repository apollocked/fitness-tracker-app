import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PasskeyHasher {
  static String generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Url.encode(bytes);
  }

  static String hash(String passkey, String salt) {
    final key = utf8.encode(salt);
    final msg = utf8.encode(passkey);
    final hmac = Hmac(sha256, key);
    return base64Url.encode(hmac.convert(msg).bytes);
  }

  static bool verify(String passkey, String salt, String expected) {
    return expected == hash(passkey, salt);
  }
}
