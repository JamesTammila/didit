import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/data/client/client_friends.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsLoading()) {
    fetchRequests();
  }

  final friendsClient = FriendsClient();

  void fetchRequests() async {
    try {
      if (state is! RequestsLoading) emit(RequestsLoading());
      List<UserModel> requests = [];
      final data = await friendsClient.fetchRequests();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        requests.add(UserModel.fromJson(jsonObject));
      }

      //await Future.delayed(const Duration(milliseconds: 500));
      //List<UserModel> requests = mockRequests;

      if (requests.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestsLoaded(requests));
      }
    } on String catch (error) {
      emit(RequestsError(error));
    }
  }
}

@immutable
abstract class RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<UserModel> requests;

  RequestsLoaded(this.requests);
}

class RequestsEmpty extends RequestsState {}

class RequestsError extends RequestsState {
  final String error;

  RequestsError(this.error);
}