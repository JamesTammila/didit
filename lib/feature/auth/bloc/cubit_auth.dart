import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:didit/client/client_auth.dart';
import 'package:didit/client/client_url.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthIntro());

  final AuthClient authClient = AuthClient();
  final UrlClient urlClient = UrlClient();
  String? username;
  String name = '';
  DateTime age = DateTime(2000, 1, 1);
  PhoneNumber phoneNumber = PhoneNumber(isoCode: 'SE', phoneNumber: '');
  String? smsCode;
  bool isValid = false;
  String? verificationId;
  String? token;

  void init() async {
    try {
      await authClient.checkSession();
      emit(AuthLogin());
    } on String {
      emit(AuthFailure('SESSION'));
    }
  }

  void goIntro() => emit(AuthIntro());

  void goName() => emit(AuthName(name));

  void goAge() => emit(AuthAge(age));

  void goNumber() => emit(AuthNumber(phoneNumber));

  void goCode() => emit(AuthCode());

  void goUsername() => emit(AuthUsername(username));

  void setUsername(String? username) => this.username = username;

  void setName(String name) => this.name = name;

  void setAge(DateTime age) {
    this.age = age;
    emit(AuthAge(age));
  }

  void setNumber(PhoneNumber phoneNumber) => this.phoneNumber = phoneNumber;

  void setValid(bool isValid) => this.isValid = isValid;

  void setCode(String? smsCode) => this.smsCode = smsCode;

  void openTerms() async {
    try {
      await urlClient.openTerms();
    } on PlatformException catch (error) {
      emit(AuthFailure(error.toString()));
    } on String catch (error) {
      emit(AuthFailure(error));
    }
  }

  void openPrivacy() async {
    try {
      await urlClient.openPrivacy();
    } on PlatformException catch (error) {
      emit(AuthFailure(error.toString()));
    } on String catch (error) {
      emit(AuthFailure(error));
    }
  }

  void verify() async {
    if (isValid) {
      final PhoneNumber phoneNumber = this.phoneNumber;
      final String? number = phoneNumber.phoneNumber;
      if (number == null || number.isEmpty) return;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            token = await userCredential.user?.getIdToken();
            emit(AuthUsername(username));
          } on FirebaseAuthException catch (error) {
            await authClient.loginError();
            emit(AuthFailure(error.code));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('VerificationFailed: ' + e.toString());
          emit(AuthFailure(e.code));
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          emit(AuthCode());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(AuthFailure('Code timed out!'));
        },
        timeout: const Duration(seconds: 30),
      );
    }
  }

  void checkCode() async {
    final String? verificationId = this.verificationId;
    final String? smsCode = this.smsCode;
    if (verificationId == null || smsCode == null) return;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      token = await userCredential.user?.getIdToken();
      emit(AuthUsername(username));
    } on FirebaseAuthException catch (error) {
      emit(AuthFailure(error.code));
    }
  }

  void authenticate() async {
    final String? token = this.token;
    final String? number = phoneNumber.phoneNumber;
    final String? username = this.username;
    final String name = this.name;
    final DateTime age = this.age;
    if (token != null &&
        number != null &&
        username != null) {
      final trimmedUsername = username.replaceAll(RegExp(r'[^a-zA-Z]+'), '');
      final trimmedName = name
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .trim()
          .replaceAll(RegExp(r'\s+'), ' ');
      try {
        if (trimmedUsername.isEmpty) throw 'Please choose a username.';
        final DateTime dateOnly = DateTime.utc(age.year, age.month, age.day);
        await authClient.loginUser({
          'accessToken': token,
          'verificationId': number,
          'username' : trimmedUsername,
          'name' : trimmedName,
          'age' : dateOnly,
        });
        emit(AuthLogin());
      } on String catch (error) {
        await authClient.loginError();
        emit(AuthFailure(error));
      }
    }
  }
}

@immutable
abstract class AuthState {}

class AuthIntro extends AuthState {}

class AuthUsername extends AuthState {
  final String? username;

  AuthUsername(this.username);
}

class AuthName extends AuthState {
  final String? name;

  AuthName(this.name);
}

class AuthAge extends AuthState {
  final DateTime age;

  AuthAge(this.age);
}

class AuthNumber extends AuthState {
  final PhoneNumber? phoneNumber;

  AuthNumber(this.phoneNumber);
}

class AuthCode extends AuthState {}

class AuthLogin extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}