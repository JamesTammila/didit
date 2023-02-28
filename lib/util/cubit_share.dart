import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/util/client_web.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit() : super(ShareInitial());

  final WebClient webClient = WebClient();

  void shareLink() async {
    try {
      await webClient.shareLink();
    } on PlatformException catch (error) {
      emit(ShareError(error.toString()));
    } on FormatException catch (error) {
      emit(ShareError(error.toString()));
    } on String catch (error) {
      emit(ShareError(error));
    }
  }
}

@immutable
abstract class ShareState {}

class ShareInitial extends ShareState {}

class ShareError extends ShareState {
  final String error;

  ShareError(this.error);
}