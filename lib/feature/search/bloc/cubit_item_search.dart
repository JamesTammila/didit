import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SearchItemCubit extends Cubit<SearchItemState> {
  SearchItemCubit(this.userRepository) : super(SearchItemInit());

  final UserRepository userRepository;

  void addRecent(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);
}

@immutable
abstract class SearchItemState {}

class SearchItemInit extends SearchItemState {}