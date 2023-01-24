import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/model/model_user.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit(this.userModel) : super(Initial()) {
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

  addFriend() {

  }
}

@immutable
abstract class ProfilePageState {}

class Initial extends ProfilePageState {}

class Me extends ProfilePageState {}

class Friend extends ProfilePageState {}

class Random extends ProfilePageState {}

class Pending extends ProfilePageState {}

class Error extends ProfilePageState {
  final String error;

  Error(this.error);
}