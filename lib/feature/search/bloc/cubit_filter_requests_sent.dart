import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class SentRequestsFilterCubit extends Cubit<SentRequestsFilterState> {
  SentRequestsFilterCubit(this.userRepository) : super(SentRequestsFilterInit()) {
    subscription = userRepository.sentRequestsFilterStream.listen(
      (sentRequests) => emit(sentRequests.isEmpty
          ? SentRequestsFilterInit()
          : SentRequestsFilterLoaded(sentRequests)),
      onError: (error) => emit(SentRequestsFilterError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async => subscription.pause();

  void filterSentRequests(String searchInput) async {
    if (searchInput.isNotEmpty) {
      if (subscription.isPaused) subscription.resume();
      await userRepository.filterSentRequests(searchInput);
    } else {
      if (!subscription.isPaused) subscription.pause();
      emit(SentRequestsFilterInit());
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class SentRequestsFilterState {}

class SentRequestsFilterInit extends SentRequestsFilterState {}

class SentRequestsFilterLoaded extends SentRequestsFilterState {
  final Map<String, FriendModel> sentRequests;

  SentRequestsFilterLoaded(this.sentRequests);
}

class SentRequestsFilterError extends SentRequestsFilterState {
  final String error;

  SentRequestsFilterError(this.error);
}