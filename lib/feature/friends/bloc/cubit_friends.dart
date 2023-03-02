import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit(this.userRepository) : super(FriendsLoading()) {
    fetchFriends();
  }

  final UserRepository userRepository;

  void fetchFriends() async {
    try {
      if (state is! FriendsLoading) emit(FriendsLoading());
      final friends = await userRepository.getFriends();
      if (friends.isEmpty) {
        emit(FriendsEmpty());
      } else {
        emit(FriendsLoaded(friends));
      }
    } on String catch (error) {
      emit(FriendsError(error));
    }
  }
}

@immutable
abstract class FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final Map<String, UserModel> friends;

  FriendsLoaded(this.friends);
}

class FriendsEmpty extends FriendsState {}

class FriendsError extends FriendsState {
  final String error;

  FriendsError(this.error);
}