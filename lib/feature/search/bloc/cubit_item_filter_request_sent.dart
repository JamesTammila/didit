import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/model/model_user.dart';

class SentRequestFilterItemCubit extends Cubit<SentRequestFilterItemState> {
  SentRequestFilterItemCubit(this.userRepository) : super(SentRequestFilterItemInit());

  final UserRepository userRepository;

  void addRecent(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void cancelRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.cancelRequest(friendModel);
    } on String catch (error) {
      emit(SentRequestFilterItemError(error));
    }
  }
}

@immutable
abstract class SentRequestFilterItemState {}

class SentRequestFilterItemInit extends SentRequestFilterItemState {}

class SentRequestFilterItemError extends SentRequestFilterItemState {
  final String error;

  SentRequestFilterItemError(this.error);
}