import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/model/model_user.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit() : super(Loading()) {
    fetchData();
  }

  fetchData() {
    const userModel = UserModel(
      objectId: '',
      createdAt: '',
      username: 'James',
      proPicUri: 'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
      friendState: 'ME',
      requestId: '',
    );
    emit(Loaded(userModel));
  }

  addFriend() {}
}

@immutable
abstract class ProfilePageState {}

class Loading extends ProfilePageState {}

class Loaded extends ProfilePageState {
  final UserModel userModel;

  Loaded(this.userModel);
}

class Error extends ProfilePageState {
  final String error;

  Error(this.error);
}