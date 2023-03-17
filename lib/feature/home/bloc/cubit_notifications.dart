import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsStart());

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
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      final RemoteMessage? initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) onMessage(initialMessage);
      FirebaseMessaging.onMessageOpenedApp.listen((event) => onMessage(event));
      FirebaseMessaging.onMessage.listen((event) => onMessage(event));
    } else {
      emit(NotificationsDenied());
    }
  }

  onMessage(RemoteMessage message) {
    final Map<String, dynamic> data = json.decode(message.data.values.first);
    if (data['type'] == 'MATCH') {
      emit(NotificationsMatch());
    } else if (data['type'] == 'FRIEND_REQUEST') {
      emit(NotificationsRequest());
    } else if (data['type'] == 'FRIEND_ACCEPT') {
      emit(NotificationsAccept());
    }
  }

  void reset() => emit(NotificationsStart());
}

@immutable
abstract class NotificationsState {}

class NotificationsStart extends NotificationsState {}

class NotificationsDenied extends NotificationsState {}

class NotificationsMatch extends NotificationsState {}

class NotificationsRequest extends NotificationsState {}

class NotificationsAccept extends NotificationsState {}