import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:didit/client/client_account.dart';

class MatchingCubit extends Cubit<MatchingState> {
  MatchingCubit() : super(MatchingInit());

  final AccountClient accountClient = AccountClient();
  late final SharedPreferences sharedPreferences;
  bool isMatching = false;

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final bool? isMatching = sharedPreferences.getBool('isMatching');
    if (isMatching == null) {
      this.isMatching = false;
    } else {
      this.isMatching = isMatching;
    }
    emit(MatchingLoaded(this.isMatching));
  }
  
  void setMatching(bool isMatching) {
    this.isMatching = isMatching;
    emit(MatchingLoaded(this.isMatching));
  }
  
  void save() async {
    try {
      final bool isMatching = this.isMatching;
      await accountClient.saveMatching(isMatching);
      sharedPreferences.setBool('isMatching', isMatching);
      emit(MatchingSaved());
    } on String catch (error) {
      emit(MatchingError(error));
    }
  }
}

@immutable
abstract class MatchingState {}

class MatchingInit extends MatchingState {}

class MatchingLoaded extends MatchingState {
  final bool isMatching;

  MatchingLoaded(this.isMatching);
}

class MatchingSaved extends MatchingState {}

class MatchingError extends MatchingState {
  final String error;

  MatchingError(this.error);
}