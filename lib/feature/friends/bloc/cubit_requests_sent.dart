import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class SentRequestsCubit extends Cubit<SentRequestsState> {
  SentRequestsCubit(this.userRepository) : super(SentRequestsLoading()) {
    subscription = userRepository.sentRequestsStream.listen(
          (friends) {
        if (friends.isEmpty) {
          emit(SentRequestsEmpty());
        } else {
          emit(SentRequestsLoaded(friends));
        }
      },
      onError: (error) => emit(SentRequestsError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! SentRequestsLoading) emit(SentRequestsLoading());
      await userRepository.getSentRequests();
      subscription.resume();
    } catch (error) {
      emit(SentRequestsError(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class SentRequestsState {}

class SentRequestsLoading extends SentRequestsState {}

class SentRequestsLoaded extends SentRequestsState {
  final Map<String, UserModel> sentRequests;

  SentRequestsLoaded(this.sentRequests);
}

class SentRequestsEmpty extends SentRequestsState {}

class SentRequestsError extends SentRequestsState {
  final String error;

  SentRequestsError(this.error);
}