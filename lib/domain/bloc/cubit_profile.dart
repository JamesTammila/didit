import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_auth.dart';
import 'package:didit/data/client/client_web.dart';
import 'package:didit/domain/model/model_user.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(Loading()) {
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

  final AuthClient authClient = AuthClient();
  final WebClient webClient = WebClient();

  void help() async {
    try {
      await webClient.openWebsite();
    } on PlatformException catch (error) {
      emit(Error(error.toString()));
    } on String catch (error) {
      emit(Error(error));
    }
  }

  void logout() async {
    try {
      await authClient.logoutUser();
      emit(Exit());
    } on TimeoutException {
      emit(Error("Operation Timed Out"));
    } on String catch (error) {
      emit(Error(error));
    }
  }

  void delete() async {
    try {
      await authClient.deleteAccount();
      emit(Exit());
    } on TimeoutException {
      emit(Error("Operation Timed Out"));
    } on String catch (error) {
      emit(Error(error));
    }
  }
}

@immutable
abstract class ProfileState {}

class Loading extends ProfileState {}

class Loaded extends ProfileState {
  final UserModel userModel;

  Loaded(this.userModel);
}

class Exit extends ProfileState {}

class Error extends ProfileState {
  final String error;

  Error(this.error);
}