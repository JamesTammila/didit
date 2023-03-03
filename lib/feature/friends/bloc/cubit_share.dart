import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_friends.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit() : super(ShareInitial());

  final FriendsClient friendsClient = FriendsClient();

  void shareLink() async {
    try {
      await friendsClient.shareLink();
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