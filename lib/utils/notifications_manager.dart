import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  static final android = AndroidNotificationDetails(
      'channelId', 'Уведомления', 'Канал уведомлений',
      channelShowBadge: true,
      color: Colors.blue,
      priority: Priority.high,
      importance: Importance.high,
      autoCancel: true,
      channelAction: AndroidNotificationChannelAction.update,
      icon: 'drawable/ic_notifications');
  static final iOS = IOSNotificationDetails();
  static final notificationDetails =
      NotificationDetails(android: android, iOS: iOS);

  String? _token;

  void init() async {
    if (!_initialized) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      final platform = InitializationSettings(
        android: AndroidInitializationSettings('drawable/ic_launcher'),
        iOS: IOSInitializationSettings(),
      );

      await _flutterLocalNotificationsPlugin.initialize(platform);

      await _firebaseMessaging.requestPermission(
          sound: true, alert: true, badge: true, provisional: false);

      await _firebaseMessaging.subscribeToTopic('allKyrgyzMoskvaDevices');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        final android = message.notification?.android;

        if (notification != null) {
          try {
            _flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    'channelId', 'Уведомления', 'Канал уведомлений',

                    // TODO add a proper drawable resource to android, for now using
                    //      one that already exists in example app.
                    icon: 'logo',
                  ),
                ));
          } catch (e) {}
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('onNotificationOpen');
      });

      _token = await _firebaseMessaging.getToken();

      _firebaseMessaging.onTokenRefresh.listen((token) {
        _token = token;
      });

      _initialized = true;
    }
  }

  Future<RemoteMessage?> initialMessage() {
    return _firebaseMessaging.getInitialMessage();
  }

  Future<void> logout() async {
    await _firebaseMessaging.deleteToken();
  }

  Future<void> sendPushMessage(String title, String body) async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      print(_token);
      await Dio().post(
        'https://fcm.googleapis.com/fcm/send',
        data: constructFCMPayload(title, body),
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'key=AAAAe2TB9MU:APA91bHxCXofSAuuG5nioYkXN9OFXiax'
                'SIIW8FzCq3oJRJvK_j7faKDIrb31zKODU-QyqWBfw6SWoMvqqNh5TsjUR6T7bQU1tn'
                'JUsYcG7P4bvrj4oFQKJgo-pOtNDJ4n4mxp5uj0H7lp',
          },
        ),
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
  String constructFCMPayload(String title, String body) {
    return jsonEncode({
      // 'registration_ids': [token],
      'to': '/topics/allKyrgyzMoskvaDevices',
      'notification': {
        'title': title,
        'body': body,
      },
    });
  }
}
