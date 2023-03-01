import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/common/client_permissions.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit() : super(AppSettingsStart());

  final PermissionsClient client = PermissionsClient();

  void openSettings() async {
    try {
      await client.openSettings();
    } on String catch (error) {
      emit(AppSettingsError(error));
    }
  }
}

@immutable
abstract class AppSettingsState {}

class AppSettingsStart extends AppSettingsState {}

class AppSettingsError extends AppSettingsState {
  final String error;

  AppSettingsError(this.error);
}