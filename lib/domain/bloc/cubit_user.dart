import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/model/model_user.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userModel) : super(UserInitial()) {
    startingState();
  }

  final UserModel userModel;

  startingState() {
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

  addFriend() {}
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