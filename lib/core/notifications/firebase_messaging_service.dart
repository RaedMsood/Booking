// lib/notifications/firebase_messaging_service.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'awesome_notification_service.dart';

/// لازم يكون Top-Level و عليه @pragma حتى يشتغل بالخلفية.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(message.notification == null){
    await AwesomeNotificationService.I.showFromRemote(message);

  }
  // لا تنشئ قنوات هنا. فقط اعرض باستخدام القنوات المسجّلة مسبقًا.
}

class FirebaseMessagingService {
  FirebaseMessagingService._();
  static final FirebaseMessagingService I = FirebaseMessagingService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _configured = false;

  Future<String?> getDeviceToken() async {
    try {
      return _messaging.getToken();
    } catch (e) {
      if (kDebugMode) print('[FCM] getToken error: $e');
      return null;
    }
  }

  Future<void> configure() async {
    if (_configured) return;

    // أذونات iOS + Android 13
    await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    // Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('[FCM] onMessage: ${message.notification?.title} | ${message.notification?.body}');
      }
      await AwesomeNotificationService.I.showFromRemote(message);
    });

    // App opened from notification (اختياري توجيه/روتنج)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('[FCM] onMessageOpenedApp: ${message.data}');
      }
      // TODO: نفّذ توجيه معين إذا احتجت (Router)
    });

    _configured = true;
  }
}
