import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as timezone_data;
import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static const int _firstWeightReminderId = 7000;
  static const int _scheduledReminderCount = 32;
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
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
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

  Future<bool> requestNotificationPermission() async {
    if (kIsWeb) return false;

    final status = await Permission.notification.status;
    if (status.isGranted) return true;

    final requested = await Permission.notification.request();
    return requested.isGranted;
  }

  Future<bool> areNotificationsAllowed() async {
    if (kIsWeb) return false;
    return Permission.notification.isGranted;
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
    for (var i = 0; i < _scheduledReminderCount; i++) {
      final scheduledDate = now.add(Duration(days: 3 * (i + 1)));
      await _notifications.zonedSchedule(
        id: _firstWeightReminderId + i,
        title: 'Track your weight',
        body: 'Take a moment to log your latest weight measurement.',
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: 'weight-reminder',
        scheduledDate: timezone.TZDateTime.from(scheduledDate, timezone.local),
        notificationDetails: details,
      );
    }

    return true;
  }

  Future<void> cancelWeightReminder() async {
    await initialize();
    for (var i = 0; i < _scheduledReminderCount; i++) {
      await _notifications.cancel(
        id: _firstWeightReminderId + i,
      );
    }
  }
}
