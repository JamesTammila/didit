import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit(this.userRepository) : super(RequestsLoading()) {
    subscription = userRepository.requestsStream.listen(
      (requests) {
        if (requests.isEmpty) {
          emit(RequestsEmpty());
        } else {
          emit(RequestsLoaded(requests));
        }
      },
      onError: (error) => emit(RequestsError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! RequestsLoading) emit(RequestsLoading());
      await userRepository.getRequests();
      subscription.resume();
    } catch (error) {
      emit(RequestsError(error.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      await userRepository.getRequests();
    } catch (error) {
      emit(RequestsError(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final Map<String, UserModel> requests;

  RequestsLoaded(this.requests);
}

class RequestsEmpty extends RequestsState {}

class RequestsError extends RequestsState {
  final String error;

  RequestsError(this.error);
}