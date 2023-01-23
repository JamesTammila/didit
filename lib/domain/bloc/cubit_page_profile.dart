import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/model/model_user.dart';

class ProfilePageCubit extends Cubit<ProfilePageState> {
  ProfilePageCubit(this.userModel) : super(Loading());

  final UserModel userModel;


}

@immutable
abstract class ProfilePageState {}

class Loading extends ProfilePageState {}

class Me extends ProfilePageState {}

class Friend extends ProfilePageState {}

class Random extends ProfilePageState {}

class Pending extends ProfilePageState {}

class Error extends ProfilePageState {
  final String error;

  Error(this.error);
}