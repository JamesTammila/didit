import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_friend.dart';
import 'package:didit/mock_database.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsLoading()) {
    fetchFriends();
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void fetchFriends() async {
    try {
      /*if (state is! FriendsLoading) emit(FriendsLoading());
      List<FriendModel> friends = [];
      final data = await databaseClient.fetchFriends();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        friends.add(FriendModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(milliseconds: 500));
      List<FriendModel> friends = mockFriends;

      if (friends.isEmpty) {
        emit(FriendsEmpty());
      } else {
        emit(FriendsLoaded(friends));
      }
    } on String catch (error) {
      emit(FriendsError(error));
    }
  }
}

@immutable
abstract class FriendsState {}

class FriendsLoading extends FriendsState {}

class FriendsLoaded extends FriendsState {
  final List<FriendModel> friends;

  FriendsLoaded(this.friends);
}

class FriendsEmpty extends FriendsState {}

class FriendsError extends FriendsState {
  final String error;

  FriendsError(this.error);
}