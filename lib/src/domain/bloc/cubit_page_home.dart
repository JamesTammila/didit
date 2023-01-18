import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:didit/src/data/client/client_database.dart';
import 'package:didit/src/domain/model/model_post.dart';
import 'package:didit/src/domain/model/model_task.dart';
import 'package:didit/src/domain/model/model_user.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(Loading()) {
    setNotifications();
    getPosts();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  bool isActive = false;

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
      emit(Denied());
    }
  }

  void openSettings() async {
    try {
      if (!await openAppSettings()) throw "Could not open app settings";
    } on String catch (error) {
      emit(Error(error));
    }
  }

  void getPosts() async {
    try {
      if (state is! Loading) emit(Loading());
      /*List<PostModel> posts = [];
      final data = await databaseClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        posts.add(PostModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 2));

      List<PostModel> posts = List<PostModel>.generate(
        100,
        (i) => const PostModel(
          objectId: '1',
          createdAt: '1',
          mediaUri: 'https://www.talarpoolen.se/wp-content/uploads/donnie-s-c-lygonis-forelasning.jpg',
          task: TaskModel(
            objectId: '1',
            createdAt: '1',
            message: 'Take a picture of your idol :D',
            sender: UserModel(
              objectId: '1',
              createdAt: '1',
              username: 'James',
              proPicUri: 'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
              friendState: '1',
              requestId: '1',
            ),
            receiver: UserModel(
              objectId: '1',
              createdAt: '1',
              username: 'Jimmy',
              proPicUri: 'https://s.abcnews.com/images/US/genco-ht-er-210722_1626977585979_hpMain_4x5_992.jpg',
              friendState: '1',
              requestId: '1',
            ),
          ),
        ),
      );

      if (posts.isEmpty) {
        emit(Empty());
      } else {
        emit(Loaded(posts));
      }
    } on String catch (error) {
      emit(Error(error));
    }
  }

  void toggleActive(bool isActive) {
    this.isActive = isActive;
  }
}

@immutable
abstract class HomePageState {}

class Loading extends HomePageState {}

class Loaded extends HomePageState {
  final List<PostModel> posts;

  Loaded(this.posts);
}

class Empty extends HomePageState {}

class Error extends HomePageState {
  final String error;

  Error(this.error);
}

class Denied extends HomePageState {}