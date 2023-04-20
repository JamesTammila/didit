import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/repo/repo_posts.dart';

class MemoryItemCubit extends Cubit<MemoryItemState> {
  MemoryItemCubit(this.postRepository) : super(MemoryItemInit());

  final PostRepository postRepository;

  void sharePost(PostModel postModel) async {}

  void reportPost(PostModel postModel) async {}

  void deleteMemory(PostModel postModel) async {
    try {
      await postRepository.deletePost(postModel);
    } on String catch (error) {
      emit(MemoryItemError(error));
    }
  }
}

@immutable
abstract class MemoryItemState {}

class MemoryItemInit extends MemoryItemState {}

class MemoryItemError extends MemoryItemState {
  final String error;

  MemoryItemError(this.error);
}