import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.userRepository) : super(SearchLoading()) {
    subscription = userRepository.searchStream.listen(
      (search) {
        if (search.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchLoaded(search));
        }
      },
      onError: (error) => emit(SearchError(error.toString())),
      cancelOnError: true,
    );
    fetchSearch('');
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void fetchSearch(String text) async {
    try {
      subscription.pause();
      if (text.isEmpty) {
        final Map<String, UserModel> recent = await userRepository.getRecent();
        emit(SearchRecent(recent));
      } else {
        if (state is! SearchLoading) emit(SearchLoading());
        await userRepository.getSearch(text);
      }
      subscription.resume();
    } on String catch (error) {
      emit(SearchError(error));
    }
  }

  void addSuggestion(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void removeSuggestion(UserModel userModel) async {
    await userRepository.removeRecent(userModel);
    final Map<String, UserModel> recent = await userRepository.getRecent();
    emit(SearchRecent(recent));
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
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