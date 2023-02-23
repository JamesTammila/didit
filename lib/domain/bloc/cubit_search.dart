import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_friend.dart';
import 'package:didit/mock_database.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchLoading()) {
    fetchSearch('');
  }

  final DatabaseClient databaseClient = DatabaseClient();
  List<FriendModel> suggestions = [];

  void fetchSearch(String text) async {
    try {
      debugPrint(text);
      if (text.isEmpty) {
        // ToDo Get Suggestions
        emit(SearchSuggestions(suggestions));
      } else {
        /*if (state is! SearchLoading) emit(SearchLoading());
        List<FriendModel> search = [];
        final data = await databaseClient.fetchSearch(text.toLowerCase());
        List<dynamic> results = json.decode(data);
        //if (results[0]["result"] == null) throw "First Item NULL";
        List<dynamic> jsonObjects = json.decode(results[0]["result"]);
        for (var jsonObject in jsonObjects) {
          search.add(FriendModel.fromJson(jsonObject));
        }*/

        await Future.delayed(const Duration(milliseconds: 500));
        List<FriendModel> search = mockSearch;

        if (search.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(search));
        }
      }
    } on String catch (error) {
      emit(SearchError(error));
    }
  }

  void addSuggestion(FriendModel friendModel) async => suggestions.add(friendModel);

  void removeSuggestion(FriendModel friendModel) async {
    suggestions.remove(friendModel);
    emit(SearchSuggestions(suggestions));
  }
}

@immutable
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<FriendModel> search;

  SearchLoaded(this.search);
}

class SearchSuggestions extends SearchState {
  final List<FriendModel> suggestions;

  SearchSuggestions(this.suggestions);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}