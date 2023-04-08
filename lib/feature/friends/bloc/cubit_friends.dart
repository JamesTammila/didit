import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit(this.userRepository) : super(FriendsLoading()) {
    subscription = userRepository.friendsStream.listen(
      (friends) {
        if (friends.isEmpty) {
          emit(FriendsEmpty());
        } else {
          emit(FriendsLoaded(friends));
        }
      },
      onError: (error) => emit(FriendsError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! FriendsLoading) emit(FriendsLoading());
      await userRepository.getFriends();
      subscription.resume();
    } catch (error) {
      emit(FriendsError(error.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      await userRepository.getFriends();
    } catch (error) {
      emit(FriendsError(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final Map<String, FriendModel> friends;

  FriendsLoaded(this.friends);
}

class FriendsEmpty extends FriendsState {}

class FriendsError extends FriendsState {
  final String error;

  FriendsError(this.error);
}