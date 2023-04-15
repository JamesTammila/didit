import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class SentRequestItemCubit extends Cubit<SentRequestItemState> {
  SentRequestItemCubit(this.userRepository) : super(SentRequestItemInit());

  final UserRepository userRepository;

  void cancelRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.cancelRequest(friendModel);
    } on String catch (error) {
      emit(SentRequestItemError(error));
    }
  }
}

@immutable
abstract class SentRequestItemState {}

class SentRequestItemInit extends SentRequestItemState {}

class SentRequestItemError extends SentRequestItemState {
  final String error;

  SentRequestItemError(this.error);
}