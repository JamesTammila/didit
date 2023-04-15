import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class FriendItemCubit extends Cubit<FriendItemState> {
  FriendItemCubit(this.userRepository) : super(FriendItemInit());

  final UserRepository userRepository;

  void unfriendUser(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.unfriendUser(friendModel);
    } on String catch (error) {
      emit(FriendItemError(error));
    }
  }
}

@immutable
abstract class FriendItemState {}

class FriendItemInit extends FriendItemState {}

class FriendItemError extends FriendItemState {
  final String error;

  FriendItemError(this.error);
}