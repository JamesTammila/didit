import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_auth.dart';

class OtherCubit extends Cubit<OtherState> {
  OtherCubit() : super(OtherStart());

  final AuthClient authClient = AuthClient();

  void deleteUser() async {
    try {
      await authClient.deleteUser();
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