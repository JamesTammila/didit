import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchCubit extends Cubit<MatchState> {
  MatchCubit() : super(MatchInitial());



}

@immutable
abstract class MatchState {}

class MatchInitial extends MatchState {}

class MatchError extends MatchState {
  final String error;

  MatchError(this.error);
}