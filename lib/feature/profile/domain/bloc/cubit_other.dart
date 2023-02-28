import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/profile/data/client/client_profile.dart';

class OtherCubit extends Cubit<OtherState> {
  OtherCubit() : super(OtherStart());

  final profileClient = ProfileClient();

  void deleteUser() async {
    try {
      await profileClient.deleteUser();
      emit(OtherExit());
    } on String catch (error) {
      emit(OtherError(error));
    }
  }
}

@immutable
abstract class OtherState {}

class OtherStart extends OtherState {}

class OtherExit extends OtherState {}

class OtherError extends OtherState {
  final String error;

  OtherError(this.error);
}