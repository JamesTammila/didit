import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/data/client/client_database.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/mock_database.dart';

class MatchesCubit extends Cubit<MatchesState> {
  MatchesCubit() : super(MatchesLoading()) {
    fetchMatches();
  }

  final DatabaseClient databaseClient = DatabaseClient();

  void fetchMatches() async {
    try {
      if (state is! MatchesLoading) emit(MatchesLoading());
      /*List<PostModel> matches = [];
      final data = await databaseClient.fetchPosts();
      List<dynamic> results = json.decode(data);
      //if (results[0]["result"] == null) throw "First Item NULL";
      List<dynamic> jsonObjects = json.decode(results[0]["result"]);
      for (var jsonObject in jsonObjects) {
        matches.add(PostModel.fromJson(jsonObject));
      }*/

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> matches = mockPosts;

      if (matches.isEmpty) {
        emit(MatchesEmpty());
      } else {
        emit(MatchesLoaded(matches));
      }
    } on String catch (error) {
      emit(MatchesError(error));
    }
  }
}

@immutable
abstract class MatchesState {}

class MatchesLoading extends MatchesState {}

class MatchesLoaded extends MatchesState {
  final List<PostModel> matches;

  MatchesLoaded(this.matches);
}

class MatchesEmpty extends MatchesState {}

class MatchesError extends MatchesState {
  final String error;

  MatchesError(this.error);
}