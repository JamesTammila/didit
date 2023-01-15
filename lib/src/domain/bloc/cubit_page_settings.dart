import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/src/data/client/client_auth.dart';
import 'package:didit/src/data/client/client_web.dart';

class SettingsPageCubit extends Cubit<SettingsPageState> {
  SettingsPageCubit() : super(Initial());

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
abstract class SettingsPageState {}

class Initial extends SettingsPageState {}

class Exit extends SettingsPageState {}

class Error extends SettingsPageState {
  final String error;

  Error(this.error);
}