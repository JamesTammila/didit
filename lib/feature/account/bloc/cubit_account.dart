import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_auth.dart';
import 'package:didit/client/client_share.dart';
import 'package:didit/client/client_url.dart';
import 'package:didit/repo/repo_account.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.accountRepository) : super(AccountLoading()){
    subscription = accountRepository.currentUserStream.listen(
      (currentUser) => emit(AccountLoaded(currentUser)),
      onError: (error) => emit(AccountError(error.toString())),
      cancelOnError: true,
    );
  }

  final AuthClient authClient = AuthClient();
  final ShareClient shareClient = ShareClient();
  final UrlClient urlClient = UrlClient();
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

  void shareLink() async {
    try {
      await shareClient.shareLink();
    } on PlatformException catch (error) {
      emit(AccountError(error.toString()));
    } on FormatException catch (error) {
      emit(AccountError(error.toString()));
    } on String catch (error) {
      emit(AccountError(error));
    }
  }

  void help() async {
    try {
      await urlClient.openWebsite();
    } on PlatformException catch (error) {
      emit(AccountError(error.toString()));
    } on String catch (error) {
      emit(AccountError(error));
    }
  }

  void logout() async {
    try {
      await authClient.logoutUser();
      emit(AccountExit());
    } on String catch (error) {
      emit(AccountError(error));
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

class AccountExit extends AccountState {}

class AccountError extends AccountState {
  final String error;

  AccountError(this.error);
}