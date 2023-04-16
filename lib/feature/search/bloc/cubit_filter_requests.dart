import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_friend.dart';

class RequestsFilterCubit extends Cubit<RequestsFilterState> {
  RequestsFilterCubit(this.userRepository) : super(RequestsFilterInit()) {
    subscription = userRepository.requestsFilterStream.listen(
      (requests) => emit(requests.isEmpty
          ? RequestsFilterInit()
          : RequestsFilterLoaded(requests)),
      onError: (error) => emit(RequestsFilterError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async => subscription.pause();

  void filterRequests(String searchInput) async {
    if (searchInput.isNotEmpty) {
      if (subscription.isPaused) subscription.resume();
      await userRepository.filterRequests(searchInput);
    } else {
      if (!subscription.isPaused) subscription.pause();
      emit(RequestsFilterInit());
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class RequestsFilterState {}

class RequestsFilterInit extends RequestsFilterState {}

class RequestsFilterLoaded extends RequestsFilterState {
  final Map<String, FriendModel> requests;

  RequestsFilterLoaded(this.requests);
}

class RequestsFilterError extends RequestsFilterState {
  final String error;

  RequestsFilterError(this.error);
}