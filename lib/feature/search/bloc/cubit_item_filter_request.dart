import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/model/model_user.dart';

class RequestFilterItemCubit extends Cubit<RequestFilterItemState> {
  RequestFilterItemCubit(this.userRepository) : super(RequestFilterItemInit());

  final UserRepository userRepository;

  void addRecent(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void acceptRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.acceptRequest(friendModel);
    } on String catch (error) {
      emit(RequestFilterItemError(error));
    }
  }

  void rejectRequest(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.rejectRequest(friendModel);
    } on String catch (error) {
      emit(RequestFilterItemError(error));
    }
  }
}

@immutable
abstract class RequestFilterItemState {}

class RequestFilterItemInit extends RequestFilterItemState {}

class RequestFilterItemError extends RequestFilterItemState {
  final String error;

  RequestFilterItemError(this.error);
}