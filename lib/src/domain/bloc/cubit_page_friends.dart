import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/src/data/client/client_database.dart';
import 'package:didit/src/domain/model/model_user.dart';

class FriendsPageCubit extends Cubit<FriendsPageState> {
  FriendsPageCubit() : super(Loading());

  final DatabaseClient databaseClient = DatabaseClient();
}

@immutable
abstract class FriendsPageState {}

class Loading extends FriendsPageState {}

class Loaded extends FriendsPageState {
  final List<UserModel> friends;

  Loaded(this.friends);
}

class Empty extends FriendsPageState {}

class Error extends FriendsPageState {
  final String error;

  Error(this.error);
}