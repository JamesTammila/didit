import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit(this.userRepository, this.postId) : super(LikesLoading()) {
    subscription = userRepository.likesStream.listen(
      (likes) {
        if (likes.isEmpty) {
          emit(LikesEmpty());
        } else {
          emit(LikesLoaded(likes));
        }
      },
      onError: (error) => emit(LikesError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  final String postId;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! LikesLoading) emit(LikesLoading());
      await userRepository.getLikes(postId);
      subscription.resume();
    } catch (error) {
      emit(LikesError(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class LikesState {}

class LikesLoading extends LikesState {}

class LikesLoaded extends LikesState {
  final Map<String, UserModel> likes;

  LikesLoaded(this.likes);
}

class LikesEmpty extends LikesState {}

class LikesError extends LikesState {
  final String error;

  LikesError(this.error);
}