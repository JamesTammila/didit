import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository, this.userModel) : super(UserLoading()) {
    startingState();
  }

  final UserRepository userRepository;
  UserModel userModel;
  String? friendId;

  void startingState() async {
    try {
      final Map<String, String> data = await userRepository.getUser(userModel);
      friendId = data['friendRequestId'];
      final String? friendState = data['friendState'];
      if (friendState == null) throw 'Error';
      //const friendState = '';
      switch (friendState) {
        case 'ME':
          emit(UserMe());
          break;
        case 'FRIEND':
          emit(UserFriend());
          break;
        case 'PENDING':
          emit(UserPending());
          break;
        case 'WAITING':
          emit(UserWaiting());
          break;
        case '':
          emit(UserRandom());
          break;
      }
    } on String catch (error) {
      emit(UserLoadingError(error));
    }
  }

  void sendRequest() async {
    try {
      friendId = await userRepository.sendRequest(userModel);
      emit(UserPending());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void cancelRequest() async {
    try {
      final String? friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userRepository.cancelRequest(userModel, friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void acceptRequest() async {
    try {
      final String? friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userRepository.acceptRequest(userModel, friendId);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void rejectRequest() async {
    try {
      final String? friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userRepository.rejectRequest(userModel, friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void unfriendUser() async {
    try {
      final String? friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userRepository.unfriendUser(userModel, friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }
}

@immutable
abstract class UserState {}

class UserLoading extends UserState {}

class UserMe extends UserState {}

class UserFriend extends UserState {}

class UserPending extends UserState {}

class UserWaiting extends UserState {}

class UserRandom extends UserState {}

class UserLoadingError extends UserState {
  final String error;

  UserLoadingError(this.error);
}

class UserButtonError extends UserState {
  final String error;

  UserButtonError(this.error);
}

class UserMenuError extends UserState {
  final String error;

  UserMenuError(this.error);
}