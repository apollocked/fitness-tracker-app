import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const int _firstWeightReminderId = 7000;
  static const int _scheduledReminderCount = 10;
  static const String _channelId = 'weight_tracking_reminders';
  static const String _channelName = 'Weight tracking reminders';
  static const String _channelDescription =
      'Reminders to log your body weight every three days.';

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    timezone_data.initializeTimeZones();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    await _notifications.initialize(
      settings: settings,
    );

    const androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.defaultImportance,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    _initialized = true;
  }

  Future<NotificationPermissionResult> requestNotificationPermission() async {
    if (kIsWeb) return NotificationPermissionResult.granted;

    final status = await Permission.notification.status;

    if (status.isGranted) return NotificationPermissionResult.granted;

    if (status.isPermanentlyDenied) {
      return NotificationPermissionResult.permanentlyDenied;
    }

    final requested = await Permission.notification.request();

    if (requested.isGranted) return NotificationPermissionResult.granted;

    if (requested.isPermanentlyDenied) {
      return NotificationPermissionResult.permanentlyDenied;
    }

    return NotificationPermissionResult.denied;
  }

  Future<bool> areNotificationsAllowed() async {
    if (kIsWeb) return false;
    final status = await Permission.notification.status;
    return status.isGranted;
  }

  Future<bool> scheduleWeightReminder() async {
    await initialize();
    if (!await areNotificationsAllowed()) return false;

    await cancelWeightReminder();

    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        icon: '@mipmap/ic_launcher',
        largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      ),
      iOS: DarwinNotificationDetails(),
      macOS: DarwinNotificationDetails(),
    );

    final now = DateTime.now();
    var scheduledCount = 0;

    for (var i = 0; i < _scheduledReminderCount; i++) {
      try {
        final scheduledDate = now.add(Duration(days: 3 * (i + 1)));
        await _notifications.zonedSchedule(
          id: _firstWeightReminderId + i,
          title: 'Track your weight',
          body: 'Take a moment to log your latest weight measurement.',
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          payload: 'weight-reminder',
          scheduledDate:
              timezone.TZDateTime.from(scheduledDate, timezone.local),
          notificationDetails: details,
        );
        scheduledCount++;
      } catch (_) {}
    }

    return scheduledCount > 0;
  }

  Future<void> cancelWeightReminder() async {
    await initialize();
    for (var i = 0; i < _scheduledReminderCount; i++) {
      try {
        await _notifications.cancel(
          id: _firstWeightReminderId + i,
        );
      } catch (_) {}
    }
  }
}

enum NotificationPermissionResult { granted, denied, permanentlyDenied }

Future<bool> showNotificationRationale(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('Weight Reminders'),
      content: const Text(
        'We use notifications to remind you to log your weight every 3 days. '
        'Consistent tracking helps you see your progress over time.\n\n'
        'Would you like to enable this feature?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('No thanks'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Enable'),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<void> showAppSettingsRedirect(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('Permission Required'),
      content: const Text(
        'Notifications are blocked. Please enable them in your device settings '
        'to receive weight tracking reminders.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );

  if (result == true && !kIsWeb && Platform.isAndroid) {
    await openAppSettings();
  }
}
