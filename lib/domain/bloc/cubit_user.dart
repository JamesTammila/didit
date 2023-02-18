import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(UserInitial()) {
    startingState();
  }

  final DatabaseClient databaseClient = DatabaseClient();
  final UserModel userModel;

  void startingState() {
    switch (userModel.friendState) {
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

  void sendRequest() async {
    try {
      await databaseClient.sendRequest(userModel.requestId);
      emit(UserPending());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void cancelRequest() async {
    try {
      await databaseClient.cancelRequest(userModel.requestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void unfriend() async {
    try {
      await databaseClient.unfriendUser(userModel.requestId);
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