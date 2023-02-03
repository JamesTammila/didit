import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(Initial()) {
    startingState();
  }

  final UserModel userModel;

  startingState() {
    switch (userModel.friendState) {
      case 'RANDOM':
        emit(Random());
        break;
      case 'FRIEND':
        emit(Friend());
        break;
      case 'PENDING':
        emit(Pending());
        break;
      case 'ME':
        emit(Me());
        break;
    }
  }

  addFriend() {}
}

@immutable
abstract class UserState {}

class Initial extends UserState {}

class Me extends UserState {}

class Friend extends UserState {}

class Random extends UserState {}

class Pending extends UserState {}

class Error extends UserState {
  final String error;

  Error(this.error);
}