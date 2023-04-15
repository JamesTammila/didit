import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class RequestItemCubit extends Cubit<RequestItemState> {
  RequestItemCubit(this.userRepository) : super(RequestItemInit());

  final UserRepository userRepository;

  void acceptRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.acceptRequest(friendModel);
    } on String catch (error) {
      emit(RequestItemError(error));
    }
  }

  void rejectRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.rejectRequest(friendModel);
    } on String catch (error) {
      emit(RequestItemError(error));
    }
  }
}

@immutable
abstract class RequestItemState {}

class RequestItemInit extends RequestItemState {}

class RequestItemError extends RequestItemState {
  final String error;

  RequestItemError(this.error);
}