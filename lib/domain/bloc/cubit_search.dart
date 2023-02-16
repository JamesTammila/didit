import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/mock_database.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchLoading()) {
    fetchSearch('');
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void fetchSearch(String text) async {
    try {
      debugPrint(text);
      if (text.isEmpty) {

        List<UserModel> users = mockSuggestions;

        emit(SearchSuggestions(users));
      } else {
        if (state is! SearchLoading) emit(SearchLoading());
        /*List<UserModel> users = [];
        final data = await databaseClient.fetchSearch(text);
        List<dynamic> results = json.decode(data);
        //if (results[0]["result"] == null) throw "First Item NULL";
        List<dynamic> jsonObjects = json.decode(results[0]["result"]);
        for (var jsonObject in jsonObjects) {
          users.add(UserModel.fromJson(jsonObject));
        }*/

        await Future.delayed(const Duration(milliseconds: 500));
        List<UserModel> users = mockSearch;

        if (users.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(users));
        }
      }
    } on String catch (error) {
      emit(SearchError(error));
    }
  }
}

@immutable
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<UserModel> users;

  SearchLoaded(this.users);
}

class SearchSuggestions extends SearchState {
  final List<UserModel> users;

  SearchSuggestions(this.users);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}