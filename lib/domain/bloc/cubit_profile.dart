import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_auth.dart';
import 'package:didit/data/client/client_web.dart';
import 'package:didit/domain/model/model_user.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
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
    emit(ProfileLoaded(userModel));
  }

  final AuthClient authClient = AuthClient();
  final WebClient webClient = WebClient();

  void shareLink() async {
    try {
      await webClient.shareLink();
    } on PlatformException catch (error) {
      emit(ProfileError(error.toString()));
    } on FormatException catch (error) {
      emit(ProfileError(error.toString()));
    } on String catch (error) {
      emit(ProfileError(error));
    }
  }

  void help() async {
    try {
      await webClient.openWebsite();
    } on PlatformException catch (error) {
      emit(ProfileError(error.toString()));
    } on String catch (error) {
      emit(ProfileError(error));
    }
  }

  void logout() async {
    try {
      await authClient.logoutUser();
      emit(ProfileExit());
    } on TimeoutException {
      emit(ProfileError("Operation Timed Out"));
    } on String catch (error) {
      emit(ProfileError(error));
    }
  }

  void delete() async {
    try {
      await authClient.deleteAccount();
      emit(ProfileExit());
    } on TimeoutException {
      emit(ProfileError("Operation Timed Out"));
    } on String catch (error) {
      emit(ProfileError(error));
    }
  }
}

@immutable
abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel userModel;

  ProfileLoaded(this.userModel);
}

class ProfileExit extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}