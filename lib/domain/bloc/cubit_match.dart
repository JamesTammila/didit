import 'package:didit/domain/model/model_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit(this.data) : super(MatchLoading()) {
    startingState();
  }

  final List data;

  void startingState() {
    final startingIndex = data[0];
    switch (startingIndex) {
      case 0:
        emit(MatchLoaded(const [0, 1, 2, 3], data[1]));
        break;
      case 1:
        emit(MatchLoaded(const [1, 2, 3, 0], data[1]));
        break;
      case 2:
        emit(MatchLoaded(const [2, 3, 0, 1], data[1]));
        break;
      case 3:
        emit(MatchLoaded(const [3, 0, 1, 2], data[1]));
        break;
    }
  }
}

@immutable
abstract class MatchState {}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final List<int> order;
  final MatchModel matchModel;

  MatchLoaded(this.order, this.matchModel);
}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}