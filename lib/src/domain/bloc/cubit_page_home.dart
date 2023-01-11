import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/src/data/client/client_database.dart';
import 'package:didit/src/domain/model/model_post.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this.databaseClient) : super(Loading()) {
    getPosts();
  }

  final DatabaseClient databaseClient;

  void getPosts() async {
    try {
      if (state is! Loading) emit(Loading());
      List<PostModel> posts = [];
      final data = await databaseClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        posts.add(PostModel.fromJson(jsonObject));
      }
      if (posts.isEmpty) {
        emit(Empty());
      } else {
        emit(Loaded(posts));
      }
    } on String catch (error) {
      emit(Error(error));
    }
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