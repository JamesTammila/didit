import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class FriendsFilterCubit extends Cubit<FriendsFilterState> {
  FriendsFilterCubit(this.userRepository) : super(FriendsFilterInit()) {
    subscription = userRepository.friendsFilterStream.listen(
      (friends) => emit(friends.isEmpty
          ? FriendsFilterInit()
          : FriendsFilterLoaded(friends)),
      onError: (error) => emit(FriendsFilterError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async => subscription.pause();

  void filterFriends(String searchInput) async {
    if (searchInput.isNotEmpty) {
      if (subscription.isPaused) subscription.resume();
      await userRepository.filterFriends(searchInput);
    } else {
      if (!subscription.isPaused) subscription.pause();
      emit(FriendsFilterInit());
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class FriendsFilterState {}

class FriendsFilterInit extends FriendsFilterState {}

class FriendsFilterLoaded extends FriendsFilterState {
  final Map<String, FriendModel> friends;

  FriendsFilterLoaded(this.friends);
}

class FriendsFilterError extends FriendsFilterState {
  final String error;

  FriendsFilterError(this.error);
}