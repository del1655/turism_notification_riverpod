import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  NotificationService();

  Future<void> init({
    Function(String? payload)? onDidReceiveNotificationResponse,
  }) async {
    // Inicialización Android e iOS
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (onDidReceiveNotificationResponse != null) {
          onDidReceiveNotificationResponse(response.payload);
        }
      },
    );

    // Canal Android
    const channel = AndroidNotificationChannel(
      'default_channel',
      'General',
      description: 'Canal de notificaciones generales',
      importance: Importance.high,
    );

    await _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // Permisos Android 13+
    if (Platform.isAndroid) {
      if (await Permission.notification.isDenied) {
        final status = await Permission.notification.request();
        debugPrint('Permiso notificaciones Android: $status');
      }
    }
  }

  Future<void> showLocal({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );

    debugPrint('Notificación mostrada: $title');
  }
}
