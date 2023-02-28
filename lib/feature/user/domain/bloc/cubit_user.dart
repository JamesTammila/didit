import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/data/client/client_user.dart';
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
      final data = await userClient.fetchState(userModel.objectId);
      final List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      final Map<String, dynamic> jsonObject = json.decode(results[0]["result"]);
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
      emit(UserError(error));
    }
  }

  void sendRequest() async {
    try {
      await userClient.sendRequest(userModel.objectId);
      emit(UserPending());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void cancelRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null) throw 'Error';
      await userClient.cancelRequest(friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void acceptRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null) throw 'Error';
      await userClient.acceptRequest(friendId);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void rejectRequest() async {
    try {
      final friendId = this.friendId;
      if (friendId == null) throw 'Error';
      await userClient.rejectRequest(friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void unfriend() async {
    try {
      final friendId = this.friendId;
      if (friendId == null) throw 'Error';
      await userClient.unfriendUser(friendId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
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

class UserError extends UserState {
  final String error;

  UserError(this.error);
}