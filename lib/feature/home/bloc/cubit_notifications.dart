import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsStart());

  Future<void> init() async {
    final NotificationSettings notificationSettings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    notificationSettings.authorizationStatus != AuthorizationStatus.authorized
        ? emit(NotificationsDenied())
        : Platform.isIOS
            ? await initIOS()
            : await initAndroid();
  }

  Future<void> initIOS() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) onBackgroundMessageIOS(initialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onBackgroundMessageIOS);
    //FirebaseMessaging.onMessage.listen((message) async {});
  }

  Future<void> initAndroid() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final AndroidFlutterLocalNotificationsPlugin? androidFlutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'important_channel',
      'Important Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );
    if (androidFlutterLocalNotificationsPlugin == null) return;
    await androidFlutterLocalNotificationsPlugin.initialize(androidInitializationSettings);
    await androidFlutterLocalNotificationsPlugin.createNotificationChannel(androidNotificationChannel);
    final int? androidVersion = int.tryParse(Platform.version.split('.').first);
    androidVersion == null || androidVersion < 13 || await androidFlutterLocalNotificationsPlugin.requestPermission() == true
        ? await registerAndroidListeners(androidFlutterLocalNotificationsPlugin, androidNotificationChannel)
        : emit(NotificationsDeniedAndroid());
  }

  Future<void> registerAndroidListeners(AndroidFlutterLocalNotificationsPlugin androidFlutterLocalNotificationsPlugin, AndroidNotificationChannel androidNotificationChannel) async {
    final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) onBackgroundMessageAndroid(initialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onBackgroundMessageAndroid);
    FirebaseMessaging.onMessage.listen((message) async {
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = notification?.android;
      if (notification == null || android == null) return;
      final AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        channelDescription: androidNotificationChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: const DefaultStyleInformation(true, true),
      );
      await androidFlutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails: androidNotificationDetails,
        payload: message.data.toString(),
      );
    });
  }

  void onBackgroundMessageIOS(RemoteMessage message) {
    final data = json.decode(message.data.values.first);
    switch (data['data']['type']) {
      case 'MATCH':
        emit(NotificationsBackgroundMatch());
        break;
      case 'FRIEND_REQUEST':
        emit(NotificationsBackgroundRequest());
        break;
      case 'FRIEND_ACCEPT':
        emit(NotificationsBackgroundAccept());
        break;
      default:
        break;
    }
  }

  void onBackgroundMessageAndroid(RemoteMessage message) {
    final data = json.decode(message.data.values.first);
    switch (data['type']) {
      case 'MATCH':
        emit(NotificationsBackgroundMatch());
        break;
      case 'FRIEND_REQUEST':
        emit(NotificationsBackgroundRequest());
        break;
      case 'FRIEND_ACCEPT':
        emit(NotificationsBackgroundAccept());
        break;
      default:
        break;
    }
  }

  void reset() => emit(NotificationsStart());
}

@immutable
abstract class NotificationsState {}

class NotificationsStart extends NotificationsState {}

class NotificationsDenied extends NotificationsState {}

class NotificationsDeniedAndroid extends NotificationsState {}

class NotificationsBackgroundMatch extends NotificationsState {}

class NotificationsBackgroundRequest extends NotificationsState {}

class NotificationsBackgroundAccept extends NotificationsState {}