import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_url.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpInit());

  final UrlClient urlClient = UrlClient();

  void openContact() async {
    try {
      await urlClient.openContact();
    } on PlatformException catch (error) {
      emit(HelpError(error.toString()));
    } on String catch (error) {
      emit(HelpError(error));
    }
  }
}

@immutable
abstract class HelpState {}

class HelpInit extends HelpState {}

class HelpError extends HelpState {
  final String error;

  HelpError(this.error);
}