import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit(this.userRepository) : super(SuggestionsLoading()) {
    fetchSuggestions();
  }

  final UserRepository userRepository;

  void fetchSuggestions() async {
    try {
      if (state is! SuggestionsLoading) emit(SuggestionsLoading());
      final suggestions = await userRepository.getSuggestions();
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
  final Map<String, UserModel> suggestions;

  SuggestionsLoaded(this.suggestions);
}

class SuggestionsEmpty extends SuggestionsState {}

class SuggestionsError extends SuggestionsState {
  final String error;

  SuggestionsError(this.error);
}