import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading()) {
    subscription = postRepository.matchStream.listen(
      (match) {
        if (match == null) {
          emit(MatchEmpty());
        } else {
          emit(MatchLoaded(match));
        }
      },
      onError: (error) => emit(MatchError(error.toString())),
      cancelOnError: true,
    );
  }

  final PostRepository postRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      await postRepository.getMatch();
    } on String catch (error) {
      emit(MatchError(error));
    }
  }

  Future<void> refreshMatch() async {
    try {
      await postRepository.refreshMatch();
    } on String catch (error) {
      emit(MatchError(error));
    }
  }

  Future<void> clearMatch() async => await postRepository.clearMatch();

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class MatchState {}

class MatchLoading extends MatchState {}

class MatchEmpty extends MatchState {}

class MatchLoaded extends MatchState {
  final PostModel match;

  MatchLoaded(this.match);
}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}