import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/data/client/client_home.dart';
import 'package:didit/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(UserInitial()) {
    startingState();
  }

  final homeClient = HomeClient();
  UserModel userModel;

  void startingState() async {
    try {
      //if (state is! MatchLoading) emit(MatchLoading());
      final data = await homeClient.fetchState(userModel.objectId);
      final List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      final Map<String, dynamic> jsonObject = json.decode(results[0]["result"]);
      userModel = UserModel.fromJson(jsonObject);
      switch (userModel.friendState) {
        case '':
          emit(UserRandom());
          break;
        case 'FRIEND':
          emit(UserFriend());
          break;
        case 'PENDING':
          emit(UserPending());
          break;
        case 'WAITING':
          emit(UserPending());
          break;
        case 'ME':
          emit(UserMe());
          break;
      }
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void reportUser() async {
    try {
      await homeClient.reportUser(userModel.objectId);
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void blockUser() async {
    try {
      await homeClient.blockUser(userModel.objectId);
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void sendRequest() async {
    try {
      await homeClient.sendRequest(userModel.objectId);
      emit(UserPending());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void cancelRequest() async {
    try {
      await homeClient.cancelRequest(userModel.friendRequestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void acceptRequest() async {
    try {
      await homeClient.acceptRequest(userModel.friendRequestId);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void rejectRequest() async {
    try {
      await homeClient.rejectRequest(userModel.friendRequestId);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserError(error));
    }
  }

  void unfriend() async {
    try {
      await homeClient.unfriendUser(userModel.friendRequestId);
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