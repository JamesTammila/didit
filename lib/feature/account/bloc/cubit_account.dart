import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_account.dart';
import 'package:didit/client/client_auth.dart';
import 'package:didit/client/client_share.dart';
import 'package:didit/client/client_url.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountLoading()) {
    fetchData();
  }

  final AccountClient accountClient = AccountClient();
  final AuthClient authClient = AuthClient();
  final ShareClient shareClient = ShareClient();
  final UrlClient urlClient = UrlClient();

  fetchData() async {
    try {
      final Map<String, String> data = await accountClient.getProfile();
      emit(AccountLoaded(data));
    } on String catch (error) {
      emit(AccountError(error));
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
}

@immutable
abstract class AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final Map<String, String> data;

  AccountLoaded(this.data);
}

class AccountExit extends AccountState {}

class AccountError extends AccountState {
  final String error;

  AccountError(this.error);
}