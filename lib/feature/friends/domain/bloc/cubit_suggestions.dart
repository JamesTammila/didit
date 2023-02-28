import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/data/client/client_friends.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit() : super(SuggestionsLoading()) {
    fetchSuggestions();
  }

  final friendsClient = FriendsClient();

  void fetchSuggestions() async {
    try {
      /*if (state is! SuggestionsLoading) emit(SuggestionsLoading());
      List<UserModel> suggestions = [];
      final data = await friendsClient.fetchSuggestions();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        suggestions.add(UserModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(milliseconds: 500));
      List<UserModel> suggestions = mockSuggestions;

      if (suggestions.isEmpty) {
        emit(SuggestionsEmpty());
      } else {
        emit(SuggestionsLoaded(suggestions));
      }
    } on String catch (error) {
      emit(SuggestionsError(error));
    }
  }

  void sendRequest(UserModel userModel) async {
    try {
      await friendsClient.sendRequest(userModel.friendRequestId);
      // TODO: UI Remove Suggestion
    } on String catch (error) {
      emit(SuggestionsError(error));
    }
  }
}

@immutable
abstract class SuggestionsState {}

class SuggestionsLoading extends SuggestionsState {}

class SuggestionsLoaded extends SuggestionsState {
  final List<UserModel> suggestions;

  SuggestionsLoaded(this.suggestions);
}

class SuggestionsEmpty extends SuggestionsState {}

class SuggestionsError extends SuggestionsState {
  final String error;

  SuggestionsError(this.error);
}