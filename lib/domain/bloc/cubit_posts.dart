import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/mock_database.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsLoading()) {
    getPosts();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  final MockDatabase mockDatabase = MockDatabase();

  void getPosts() async {
    try {
      if (state is! PostsLoading) emit(PostsLoading());
      /*List<PostModel> posts = [];
      final data = await databaseClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        posts.add(PostModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 2));
      List<PostModel> posts = mockDatabase.posts;

      if (posts.isEmpty) {
        emit(PostsEmpty());
      } else {
        emit(PostsLoaded(posts));
      }
    } on String catch (error) {
      emit(PostsError(error));
    }
  }
}

@immutable
abstract class PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<PostModel> posts;

  PostsLoaded(this.posts);
}

class PostsEmpty extends PostsState {}

class PostsError extends PostsState {
  final String error;

  PostsError(this.error);
}