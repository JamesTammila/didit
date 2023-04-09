import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_url.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutInit());

  final UrlClient urlClient = UrlClient();

  void openTerms() async {
    try {
      await urlClient.openTerms();
    } on PlatformException catch (error) {
      emit(AboutError(error.toString()));
    } on String catch (error) {
      emit(AboutError(error));
    }
  }

  void openPrivacy() async {
    try {
      await urlClient.openPrivacy();
    } on PlatformException catch (error) {
      emit(AboutError(error.toString()));
    } on String catch (error) {
      emit(AboutError(error));
    }
  }
}

@immutable
abstract class AboutState {}

class AboutInit extends AboutState {}

class AboutError extends AboutState {
  final String error;

  AboutError(this.error);
}