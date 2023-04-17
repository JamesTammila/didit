import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/model/model_post.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.postRepository) : super(MatchLoading());

  final PostRepository postRepository;

  void init() async {
    try {
      final PostModel? match = await postRepository.getMatch();
      if (match == null) {
        emit(MatchEmpty());
      } else {
        emit(MatchLoaded(match));
      }
    } on String catch (error) {
      emit(MatchError(error));
    }
  }

  Future<void> refreshMatch() async {
    try {
      final PostModel? match = await postRepository.refreshMatch();
      if (match == null) {
        emit(MatchEmpty());
      } else {
        emit(MatchLoaded(match));
      }
    } on String catch (error) {
      emit(MatchError(error));
    }
  }

  Future<void> clearMatch() async => emit(MatchEmpty());
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