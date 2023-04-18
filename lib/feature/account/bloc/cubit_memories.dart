import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class MemoriesCubit extends Cubit<MemoriesState> {
  MemoriesCubit(this.postRepository) : super(MemoriesLoading()) {
    subscription = postRepository.memoriesStream.listen(
      (memories) =>
          emit(memories.isEmpty ? MemoriesEmpty() : MemoriesLoaded(memories)),
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