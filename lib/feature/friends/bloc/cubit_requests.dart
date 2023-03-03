import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit(this.userRepository) : super(RequestsLoading()) {
    fetchRequests();
  }

  final UserRepository userRepository;

  void fetchRequests() async {
    try {
      if (state is! RequestsLoading) emit(RequestsLoading());
      final Map<String, UserModel> requests = await userRepository.getRequests();
      if (requests.isEmpty) {
        emit(RequestsEmpty());
      } else {
        emit(RequestsLoaded(requests));
      }
    } on String catch (error) {
      emit(RequestsError(error));
    }
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