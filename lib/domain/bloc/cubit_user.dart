import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_friend.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.friendModel) : super(UserInitial()) {
    startingState();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  final FriendModel friendModel;

  void startingState() {
    switch (friendModel.state) {
      case 'RANDOM':
        emit(UserRandom());
        break;
      case 'FRIEND':
        emit(UserFriend());
        break;
      case 'PENDING':
        emit(UserPending());
        break;
      case 'ME':
        emit(UserMe());
        break;
    }
  }

  void reportUser() async {
    try {
      await databaseClient.reportUser(friendModel.user.objectId);
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void blockUser() async {
    try {
      await databaseClient.blockUser(friendModel.user.objectId);
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void sendRequest() async {
    try {
      await databaseClient.sendRequest(friendModel.objectId);
      emit(UserPending());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void cancelRequest() async {
    try {
      await databaseClient.cancelRequest(friendModel.objectId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void unfriend() async {
    try {
      await databaseClient.unfriendUser(friendModel.objectId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }
}

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserMe extends UserState {}

class UserFriend extends UserState {}

class UserRandom extends UserState {}

class UserPending extends UserState {}

class UserError extends UserState {
  final String error;

  UserError(this.error);
}