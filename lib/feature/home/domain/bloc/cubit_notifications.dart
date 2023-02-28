import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsStart()) {
    setNotifications();
  }

  void setNotifications() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      RemoteMessage? initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        // Outside
      }
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        // Outside
      });
      FirebaseMessaging.onMessage.listen((event) {
        // Inside
      });
    } else {
      emit(NotificationsDenied());
    }
  }
}

@immutable
abstract class NotificationsState {}

class NotificationsStart extends NotificationsState {}

class NotificationsDenied extends NotificationsState {}