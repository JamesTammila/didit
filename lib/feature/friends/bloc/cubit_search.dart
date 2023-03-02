import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.userRepository) : super(SearchLoading()) {
    fetchSearch('');
  }

  final UserRepository userRepository;

  void fetchSearch(String text) async {
    try {
      if (text.isEmpty) {
        final recent = await userRepository.getRecent();
        emit(SearchRecent(recent));
      } else {
        if (state is! SearchLoading) emit(SearchLoading());
        final search = await userRepository.getSearch(text);
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

  void addSuggestion(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void removeSuggestion(UserModel userModel) async {
    await userRepository.removeRecent(userModel);
    final recent = await userRepository.getRecent();
    emit(SearchRecent(recent));
  }
}

@immutable
abstract class SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final Map<String, UserModel> search;

  SearchLoaded(this.search);
}

class SearchRecent extends SearchState {
  final Map<String, UserModel> recent;

  SearchRecent(this.recent);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}