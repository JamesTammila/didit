import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/mock_database.dart';

class SentRequestsCubit extends Cubit<SentRequestsState> {
  SentRequestsCubit() : super(SentRequestsLoading()) {
    fetchSentRequests();
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void fetchSentRequests() async {
    try {
      /*if (state is! SentRequestsLoading) emit(SentRequestsLoading());
      List<UserModel> sentRequests = [];
      final data = await databaseClient.fetchSentRequests();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        sentRequests.add(UserModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(milliseconds: 500));
      List<UserModel> sentRequests = mockSentRequests;

      if (sentRequests.isEmpty) {
        emit(SentRequestsEmpty());
      } else {
        emit(SentRequestsLoaded(sentRequests));
      }
    } on String catch (error) {
      emit(SentRequestsError(error));
    }
  }

  void cancelRequest(UserModel userModel) async {
    try {
      await databaseClient.cancelRequest(userModel.friendRequestId);
      // TODO: UI Remove Request
    } on String catch (error) {
      emit(SentRequestsError(error));
    }
  }
}

@immutable
abstract class SentRequestsState {}

class SentRequestsLoading extends SentRequestsState {}

class SentRequestsLoaded extends SentRequestsState {
  final List<UserModel> sentRequests;

  SentRequestsLoaded(this.sentRequests);
}

class SentRequestsEmpty extends SentRequestsState {}

class SentRequestsError extends SentRequestsState {
  final String error;

  SentRequestsError(this.error);
}