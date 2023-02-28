import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/data/client/client_user.dart';
import 'package:didit/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(UserStart()) {
    startingState();
  }

  final userClient = UserClient();
  UserModel userModel;

  void startingState() async {
    try {
      switch (userModel.friendState) {
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
      await userClient.cancelRequest(userModel.friendRequestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void acceptRequest() async {
    try {
      await userClient.acceptRequest(userModel.friendRequestId);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void rejectRequest() async {
    try {
      await userClient.rejectRequest(userModel.friendRequestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void unfriend() async {
    try {
      await userClient.unfriendUser(userModel.friendRequestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }
}

@immutable
abstract class UserState {}

class UserStart extends UserState {}

class UserMe extends UserState {}

class UserFriend extends UserState {}

class UserPending extends UserState {}

class UserWaiting extends UserState {}

class UserRandom extends UserState {}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}