import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/client/client_auth.dart';
import 'package:didit/client/client_account.dart';
import 'package:didit/client/client_share.dart';
import 'package:didit/client/client_url.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/util/mock_database.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountLoading()) {
    fetchData();
  }

  final AuthClient authClient = AuthClient();
  final AccountClient accountClient = AccountClient();
  final ShareClient shareClient = ShareClient();
  final UrlClient urlClient = UrlClient();

  fetchData() {
    const UserModel userModel = mockMe;
    emit(AccountLoaded(userModel));
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
  final UserModel userModel;

  AccountLoaded(this.userModel);
}

class AccountExit extends AccountState {}

class AccountError extends AccountState {
  final String error;

  AccountError(this.error);
}