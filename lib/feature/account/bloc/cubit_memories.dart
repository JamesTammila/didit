import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_media.dart';

class MemoriesCubit extends Cubit<MemoriesState> {
  MemoriesCubit(this.postRepository) : super(MemoriesLoading()) {
    subscription = postRepository.memoriesStream.listen(
      (memories) {
        if (memories.isEmpty) {
          emit(MemoriesEmpty());
        } else {
          emit(MemoriesLoaded(memories));
        }
      },
      onError: (error) => emit(MemoriesError(error.toString())),
      cancelOnError: true,
    );
  }

  final PostRepository postRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! MemoriesLoading) emit(MemoriesLoading());
      await postRepository.getMemories();
      subscription.resume();
    } catch (error) {
      emit(MemoriesError(error.toString()));
    }
  }

  Future<void> refreshMemories() async {
    try {
      await postRepository.getMemories();
    } on String catch (error) {
      emit(MemoriesError(error));
    }
  }

  void deleteMemory(PostModel memory) async {
    try {
      subscription.pause();
      emit(MemoriesLoading());
      final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
      if (user == null) throw 'User Null';
      final String? userId = user.objectId;
      if (userId == null) throw 'UserId Null';
      String? mediaId;
      for (MediaModel media in memory.medias) {
        if (userId == media.user.objectId) {
          mediaId = media.objectId;
          break;
        }
      }
      if (mediaId == null) throw 'MediaId Null';
      await postRepository.deletePost(mediaId);
      await postRepository.getMemories();
      subscription.resume();
    } on String catch (error) {
      emit(MemoriesError(error));
      subscription.resume();
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class MemoriesState {}

class MemoriesLoading extends MemoriesState {}

class MemoriesLoaded extends MemoriesState {
  final Map<String, PostModel> memories;

  MemoriesLoaded(this.memories);
}

class MemoriesEmpty extends MemoriesState {}

class MemoriesError extends MemoriesState {
  final String error;

  MemoriesError(this.error);
}