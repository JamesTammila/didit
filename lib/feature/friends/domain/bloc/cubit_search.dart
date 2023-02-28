import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/data/client/client_friends.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchLoading()) {
    fetchSearch('');
  }

  final friendsClient = FriendsClient();
  List<UserModel> suggestions = [];

  void fetchSearch(String text) async {
    try {
      debugPrint(text);
      if (text.isEmpty) {
        // ToDo Get Suggestions
        emit(SearchSuggestions(suggestions));
      } else {
        if (state is! SearchLoading) emit(SearchLoading());
        List<UserModel> search = [];
        final data = await friendsClient.fetchSearch(text.toLowerCase());
        List<dynamic> results = json.decode(data);
        //if (results[0]["result"] == null) throw "First Item NULL";
        List<dynamic> jsonObjects = json.decode(results[0]["result"]);
        for (var jsonObject in jsonObjects) {
          search.add(UserModel.fromJson(jsonObject));
        }

        //await Future.delayed(const Duration(milliseconds: 500));
        //List<UserModel> search = mockSearch;

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

  void addSuggestion(UserModel userModel) async => suggestions.add(userModel);

  void removeSuggestion(UserModel userModel) async {
    suggestions.remove(userModel);
    emit(SearchSuggestions(suggestions));
  }
}

@immutable
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<UserModel> search;

  SearchLoaded(this.search);
}

class SearchSuggestions extends SearchState {
  final List<UserModel> suggestions;

  SearchSuggestions(this.suggestions);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}