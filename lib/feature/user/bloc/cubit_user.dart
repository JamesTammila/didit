import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_user.dart';
import 'package:didit/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(UserLoading()) {
    startingState();
  }

  final userClient = UserClient();
  UserModel userModel;
  String? friendId;

  void startingState() async {
    try {
      final data = await userClient.fetchProfile(userModel.objectId);
      final Map<String, dynamic> jsonObject = json.decode(data);
      final friendState = jsonObject['friendState'];
      friendId = jsonObject['friendRequestId'];
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
      final data = await userClient.sendRequest(userModel.objectId);
      final Map<String, dynamic> jsonObject = json.decode(data);
      friendId = jsonObject['friendRequestId'];
      emit(UserPending());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void cancelRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userClient.cancelRequest(friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void acceptRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userClient.acceptRequest(friendId);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void rejectRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userClient.rejectRequest(friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void unfriendUser() async {
    try {
      final friendId = this.friendId;
      if (friendId == null || friendId.isEmpty) throw 'Error';
      await userClient.unfriendUser(friendId);
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