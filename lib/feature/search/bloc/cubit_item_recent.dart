import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class RecentItemCubit extends Cubit<RecentItemState> {
  RecentItemCubit(this.userRepository) : super(RecentItemInit());

  final UserRepository userRepository;

  void removeRecent(UserModel userModel) async =>
      await userRepository.removeRecent(userModel);
}

@immutable
abstract class RecentItemState {}

class RecentItemInit extends RecentItemState {}