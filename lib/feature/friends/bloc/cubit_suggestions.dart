import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit(this.userRepository) : super(SuggestionsLoading()) {
    /*subscription = userRepository.suggestionsStream.listen(
      (suggestions) {
        if (suggestions.isEmpty) {
          emit(SuggestionsEmpty());
        } else {
          emit(SuggestionsLoaded(suggestions));
        }
      },
      onError: (error) => emit(SuggestionsError(error.toString())),
      cancelOnError: true,
    );*/
  }

  final UserRepository userRepository;
  //late final StreamSubscription subscription;

  void init() async {
    /*try {
      subscription.pause();
      if (state is! SuggestionsLoading) emit(SuggestionsLoading());
      await userRepository.getSuggestions();
      subscription.resume();
    } catch (error) {
      emit(SuggestionsError(error.toString()));
    }*/
  }

  @override
  Future<void> close() async {
    //await subscription.cancel();
    return super.close();
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