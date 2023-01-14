import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageCubit extends Cubit<FriendsPageState> {
  ProfilePageCubit() : super(Loading());
}

@immutable
abstract class FriendsPageState {}

class Loading extends FriendsPageState {}

class Me extends FriendsPageState {}

class Friend extends FriendsPageState {}

class Random extends FriendsPageState {}

class Pending extends FriendsPageState {}

class Error extends FriendsPageState {
  final String error;

  Error(this.error);
}