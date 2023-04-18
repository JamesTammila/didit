import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class MemoriesPageCubit extends Cubit<MemoriesPageState> {
  MemoriesPageCubit(this.postRepository, this.index) : super(MemoriesPageLoading()) {
    subscription = postRepository.memoriesStream.listen(
      (memories) => emit(memories.isEmpty
          ? MemoriesPageEmpty()
          : MemoriesPageLoaded(index, memories)),
      onError: (error) => emit(MemoriesPageError(error.toString())),
      cancelOnError: true,
    );
  }

  final PostRepository postRepository;
  final int index;
  late final StreamSubscription subscription;

  void init() async => await postRepository.openMemories();

  void deleteMemory(PostModel memory) async {
    try {
      subscription.pause();
      emit(MemoriesPageLoading());
      await postRepository.deletePost(memory);
      subscription.resume();
    } on String catch (error) {
      emit(MemoriesPageError(error));
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
abstract class MemoriesPageState {}

class MemoriesPageLoading extends MemoriesPageState {}

class MemoriesPageLoaded extends MemoriesPageState {
  final int index;
  final Map<String, PostModel> memories;

  MemoriesPageLoaded(this.index, this.memories);
}

class MemoriesPageEmpty extends MemoriesPageState {}

class MemoriesPageError extends MemoriesPageState {
  final String error;

  MemoriesPageError(this.error);
}