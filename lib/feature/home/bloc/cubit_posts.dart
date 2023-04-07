import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this.postRepository) : super(PostsLoading()) {
    subscription = postRepository.postsStream.listen(
      (posts) {
        if (posts.isEmpty) {
          emit(PostsEmpty());
        } else {
          emit(PostsLoaded(posts));
        }
      },
      onError: (error) => emit(PostsError(error.toString())),
      cancelOnError: true,
    );
  }

  final PostRepository postRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! PostsLoading) emit(PostsLoading());
      await postRepository.getPosts();
      subscription.resume();
    } catch (error) {
      emit(PostsError(error.toString()));
    }
  }

  Future<void> refreshPosts() async {
    try {
      await postRepository.getPosts();
    } on String catch (error) {
      emit(PostsError(error));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
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