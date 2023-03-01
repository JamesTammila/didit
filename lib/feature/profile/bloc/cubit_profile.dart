import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/profile/client_profile.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
    fetchData();
  }

  fetchData() {
    const userModel = mockMe;
    emit(ProfileLoaded(userModel));
  }

  final profileClient = ProfileClient();

  void shareLink() async {
    try {
      await profileClient.shareLink();
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
      await profileClient.openWebsite();
    } on PlatformException catch (error) {
      emit(ProfileError(error.toString()));
    } on String catch (error) {
      emit(ProfileError(error));
    }
  }

  void logout() async {
    try {
      await profileClient.logoutUser();
      emit(ProfileExit());
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