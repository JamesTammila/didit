import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/model/model_user.dart';

class FriendFilterItemCubit extends Cubit<FriendFilterItemState> {
  FriendFilterItemCubit(this.userRepository) : super(FriendFilterItemInit());

  final UserRepository userRepository;

  void addRecent(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void unfriendUser(FriendModel friendModel) async {
    try {
      if (friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.unfriendUser(friendModel);
    } on String catch (error) {
      emit(FriendFilterItemError(error));
    }
  }
}

@immutable
abstract class FriendFilterItemState {}

class FriendFilterItemInit extends FriendFilterItemState {}

class FriendFilterItemError extends FriendFilterItemState {
  final String error;

  FriendFilterItemError(this.error);
}