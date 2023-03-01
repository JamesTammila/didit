import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/client_account.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountLoading()) {
    fetchData();
  }

  fetchData() {
    const userModel = mockMe;
    emit(AccountLoaded(userModel));
  }

  final accountClient = AccountClient();

  void shareLink() async {
    try {
      await accountClient.shareLink();
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
      await accountClient.openWebsite();
    } on PlatformException catch (error) {
      emit(AccountError(error.toString()));
    } on String catch (error) {
      emit(AccountError(error));
    }
  }

  void logout() async {
    try {
      await accountClient.logoutUser();
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