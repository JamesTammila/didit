import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.userRepository) : super(SearchInit()) {
    subscription = userRepository.searchStream.listen(
      (users) => emit(users.isEmpty ? SearchEmpty() : SearchLoaded(users)),
      onError: (error) => emit(SearchError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;
  Timer? timer;

  void init() async => subscription.pause();

  void fetchSearch(String searchInput) async {
    try {
      timer?.cancel();
      if (searchInput.isNotEmpty) {
        if (subscription.isPaused) subscription.resume();
        timer = Timer(const Duration(milliseconds: 500), () async {
          if (state is! SearchLoading) emit(SearchLoading());
          await userRepository.getSearch(searchInput);
        });
      } else {
        if (!subscription.isPaused) subscription.pause();
        emit(SearchInit());
      }
    } on String catch (error) {
      emit(SearchError(error));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class SearchState {}

class SearchInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final Map<String, UserModel> search;

  SearchLoaded(this.search);
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);
}