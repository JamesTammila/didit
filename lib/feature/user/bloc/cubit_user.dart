import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/model/model_friend.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository, this.userModel) : super(UserLoading());

  final UserRepository userRepository;
  final UserModel userModel;
  FriendModel? friendModel;

  void init() async {
    try {
      final Map<String, dynamic> data = await userRepository.getUser(userModel.objectId);
      final String friendId = data['friendRequestId'];
      final String friendState = data['friendState'];
      friendModel = FriendModel(objectId: friendId, user: userModel);
      switch (friendState) {
        case 'ME':
          emit(UserMe());
          break;
        case 'FRIEND':
          emit(UserFriend());
          break;
        case 'PENDING':
          emit(UserPending());
          break;
        case 'WAITING':
          emit(UserWaiting());
          break;
        case '':
          emit(UserRandom());
          break;
      }
    } on String catch (error) {
      emit(UserLoadingError(error));
    }
  }

  void sendRequest() async {
    try {
      friendModel = await userRepository.sendRequest(userModel);
      emit(UserPending());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void cancelRequest() async {
    try {
      final FriendModel? friendModel = this.friendModel;
      if (friendModel == null || friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.cancelRequest(friendModel);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void acceptRequest() async {
    try {
      final FriendModel? friendModel = this.friendModel;
      if (friendModel == null || friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.acceptRequest(friendModel);
      emit(UserFriend());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void rejectRequest() async {
    try {
      final FriendModel? friendModel = this.friendModel;
      if (friendModel == null || friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.rejectRequest(friendModel);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }

  void unfriendUser() async {
    try {
      final FriendModel? friendModel = this.friendModel;
      if (friendModel == null || friendModel.objectId.isEmpty) throw 'Error';
      await userRepository.unfriendUser(friendModel);
      emit(UserRandom());
    } on String catch (error) {
      emit(UserButtonError(error));
    }
  }
}

@immutable
abstract class UserState {}

class UserLoading extends UserState {}

class UserMe extends UserState {}

class UserFriend extends UserState {}

class UserPending extends UserState {}

class UserWaiting extends UserState {}

class UserRandom extends UserState {}

class UserLoadingError extends UserState {
  final String error;

  UserLoadingError(this.error);
}

class UserButtonError extends UserState {
  final String error;

  UserButtonError(this.error);
}

class UserMenuError extends UserState {
  final String error;

  UserMenuError(this.error);
}