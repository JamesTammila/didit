import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.postRepository) : super(PostsLoading()) {
    fetchPosts();
  }

  final PostRepository postRepository;

  void fetchPosts() async {
    try {
      if (state is! PostsLoading) emit(PostsLoading());
      final Map<String, PostModel> posts = await postRepository.getPosts();
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
      final Map<String, PostModel> posts = await postRepository.getPosts();
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
      await postRepository.likePost(postId);
    } on String catch (error) {
      emit(PostsError(error));
    }
  }
}

@immutable
abstract class PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final Map<String, PostModel> posts;

  PostsLoaded(this.posts);
}

class PostsEmpty extends PostsState {}

class PostsError extends PostsState {
  final String error;

  PostsError(this.error);
}