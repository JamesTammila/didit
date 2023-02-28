import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/data/client/client_home.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/mock_database.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsLoading()) {
    fetchPosts();
  }

  final homeClient = HomeClient();

  void fetchPosts() async {
    try {
      /*if (state is! PostsLoading) emit(PostsLoading());
      List<PostModel> posts = [];
      final data = await homeClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        posts.add(PostModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> posts = mockPosts;

      if (posts.isEmpty) {
        emit(PostsEmpty());
      } else {
        emit(PostsLoaded(posts));
      }
    } on String catch (error) {
      emit(PostsError(error));
    }
  }

  Future<void> refreshPosts() async {
    try {
      /*List<PostModel> posts= [];
      final data = await databaseClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        posts.add(PostModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> posts = mockPosts;

      if (posts.isEmpty) {
        emit(PostsEmpty());
      } else {
        emit(PostsLoaded(posts));
      }
    } on String catch (error) {
      emit(PostsError(error));
    }
  }

  void likePost(String postId) async {
    try {
      await homeClient.likePost(postId);
    } on String catch (error) {
      emit(PostsError(error));
    }
  }

  void reportPost(String postId) async {
    try {
      await homeClient.reportPost(postId);
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