import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/mock_database.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit() : super(SuggestionsLoading()) {
    getSuggestions();
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void getSuggestions() async {
    try {
      /*if (state is! SuggestionsLoading) emit(SuggestionsLoading());
      List<UserModel> suggestions = [];
      final data = await databaseClient.fetchSuggestions();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        suggestions.add(UserModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 1));
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