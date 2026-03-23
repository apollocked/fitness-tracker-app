import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  void setNotifications(bool enabled) {
    if (_notificationsEnabled != enabled) {
      _notificationsEnabled = enabled;
      notifyListeners();
    }
  }

  void toggle() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }
}
