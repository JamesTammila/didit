import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/model/model_user.dart';

class RecentCubit extends Cubit<RecentState> {
  RecentCubit(this.userRepository) : super(RecentInit()) {
    subscription = userRepository.recentStream.listen(
      (recent) => emit(RecentLoaded(recent)),
      onError: (error) => emit(RecentError(error.toString())),
      cancelOnError: true,
    );
  }

  final UserRepository userRepository;
  late final StreamSubscription subscription;

  void init() async => await userRepository.getRecent();

  void fetchRecent(String searchInput) async {
    if (searchInput.isEmpty) {
      if (subscription.isPaused) subscription.resume();
      await userRepository.getRecent();
    } else {
      if (!subscription.isPaused) subscription.pause();
      emit(RecentInit());
    }
  }

  void clearRecent() async => await userRepository.clearRecent();

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class RecentState {}

class RecentInit extends RecentState {}

class RecentLoaded extends RecentState {
  final Map<String, UserModel> recent;

  RecentLoaded(this.recent);
}

class RecentError extends RecentState {
  final String error;

  RecentError(this.error);
}