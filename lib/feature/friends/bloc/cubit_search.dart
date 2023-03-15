import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.userRepository) : super(SearchLoading()) {
    subscription = userRepository.searchStream.listen(
      (users) {
        if (searchInput.isEmpty) {
          emit(SearchRecent(users));
        } else {
          if (users.isEmpty) {
            emit(SearchEmpty());
          } else {
            emit(SearchLoaded(users));
          }
        }
      },
      onError: (error) => emit(SearchError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;
  String searchInput = '';

  void init() async {
    try {
      await userRepository.getRecent();
    } on String catch (error) {
      emit(SearchError(error));
    }
  }

  void fetchSearch(String searchInput) async {
    this.searchInput = searchInput;
    try {
      if (searchInput.isEmpty) {
        await userRepository.getRecent();
      } else {
        subscription.pause();
        if (state is! SearchLoading) emit(SearchLoading());
        await userRepository.getSearch(searchInput);
        subscription.resume();
      }
    } on String catch (error) {
      emit(SearchError(error));
    }
  }

  void addRecent(UserModel userModel) async =>
      await userRepository.insertRecent(userModel);

  void removeRecent(UserModel userModel) async =>
      await userRepository.removeRecent(userModel);

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