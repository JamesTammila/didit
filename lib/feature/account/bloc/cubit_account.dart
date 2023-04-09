import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_account.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.accountRepository) : super(AccountLoading()){
    subscription = accountRepository.currentUserStream.listen(
      (currentUser) => emit(AccountLoaded(currentUser)),
      onError: (error) => emit(AccountError(error.toString())),
      cancelOnError: true,
    );
  }

  final AccountRepository accountRepository;
  late final StreamSubscription subscription;

  void init() async {
    try {
      subscription.pause();
      if (state is! AccountLoading) emit(AccountLoading());
      await accountRepository.getCurrentUser();
      subscription.resume();
    } catch (error) {
      emit(AccountError(error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await subscription.cancel();
    return super.close();
  }
}

@immutable
abstract class AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final Map<String, dynamic> data;

  AccountLoaded(this.data);
}

class AccountError extends AccountState {
  final String error;

  AccountError(this.error);
}