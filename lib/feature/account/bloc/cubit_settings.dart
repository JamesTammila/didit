import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_auth.dart';
import 'package:didit/client/client_share.dart';
import 'package:didit/client/client_url.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInit());

  final AuthClient authClient = AuthClient();
  final ShareClient shareClient = ShareClient();
  final UrlClient urlClient = UrlClient();

  void shareLink() async {
    try {
      await shareClient.shareLink();
    } on PlatformException catch (error) {
      emit(SettingsError(error.toString()));
    } on FormatException catch (error) {
      emit(SettingsError(error.toString()));
    } on String catch (error) {
      emit(SettingsError(error));
    }
  }

  void help() async {
    try {
      await urlClient.openWebsite();
    } on PlatformException catch (error) {
      emit(SettingsError(error.toString()));
    } on String catch (error) {
      emit(SettingsError(error));
    }
  }

  void logout() async {
    try {
      await authClient.logoutUser();
      emit(SettingsExit());
    } on String catch (error) {
      emit(SettingsError(error));
    }
  }
}

@immutable
abstract class SettingsState {}

class SettingsInit extends SettingsState {}

class SettingsExit extends SettingsState {}

class SettingsError extends SettingsState {
  final String error;

  SettingsError(this.error);
}