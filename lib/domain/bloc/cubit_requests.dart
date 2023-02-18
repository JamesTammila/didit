import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/mock_database.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsLoading()) {
    fetchRequests();
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void fetchRequests() async {
    try {
      /*if (state is! RequestsLoading) emit(RequestsLoading());
      List<UserModel> requests = [];
      final data = await databaseClient.fetchRequests();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        requests.add(UserModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(milliseconds: 500));
      List<UserModel> requests = mockRequests;

      if (requests.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestsLoaded(requests));
      }
    } on String catch (error) {
      emit(RequestsError(error));
    }
  }

  void acceptRequest(UserModel userModel) async {
    try {
      await databaseClient.acceptRequest(userModel.requestId);
      // TODO: UI Remove Request
    } on String catch (error) {
      emit(RequestsError(error));
    }
  }

  void rejectRequest(UserModel userModel) async {
    try {
      await databaseClient.rejectRequest(userModel.requestId);
      // TODO: UI Remove Request
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