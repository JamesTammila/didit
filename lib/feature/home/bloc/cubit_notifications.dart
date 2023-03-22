import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsStart());

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'important_channel',
    'Important Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  static const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  void init() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    final NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) onForegroundMessage(initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen((event) => onBackgroundMessage(event));
      FirebaseMessaging.onMessage.listen((event) => onForegroundMessage(event));
    } else {
      emit(NotificationsDenied());
    }
  }

  onForegroundMessage(RemoteMessage message) async {
    final Map<String, dynamic> data = json.decode(message.data.values.first);
    if (data['type'] == 'MATCH') {
    } else if (data['type'] == 'FRIEND_REQUEST') {
    } else if (data['type'] == 'FRIEND_ACCEPT') {}

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true),
      );

      NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: message.data.toString(),
      );
    }
  }

  onBackgroundMessage(RemoteMessage message) {
    final Map<String, dynamic> data = json.decode(message.data.values.first);
    if (data['type'] == 'MATCH') {
      emit(NotificationsBackgroundMatch());
    } else if (data['type'] == 'FRIEND_REQUEST') {
      emit(NotificationsBackgroundRequest());
    } else if (data['type'] == 'FRIEND_ACCEPT') {
      emit(NotificationsBackgroundAccept());
    }
  }

  void reset() => emit(NotificationsStart());
}

@immutable
abstract class NotificationsState {}

class NotificationsStart extends NotificationsState {}

class NotificationsDenied extends NotificationsState {}

class NotificationsBackgroundMatch extends NotificationsState {}

class NotificationsBackgroundRequest extends NotificationsState {}

class NotificationsBackgroundAccept extends NotificationsState {}