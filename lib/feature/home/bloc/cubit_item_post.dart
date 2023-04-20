import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/repo/repo_posts.dart';

class PostItemCubit extends Cubit<PostItemState> {
  PostItemCubit(this.postRepository) : super(PostItemInit());

  final PostRepository postRepository;

  void sharePost(PostModel postModel) async {}

  void reportPost(PostModel postModel) async {}
}

@immutable
abstract class PostItemState {}

class PostItemInit extends PostItemState {}

class PostItemError extends PostItemState {
  final String error;

  PostItemError(this.error);
}