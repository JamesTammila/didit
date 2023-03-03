import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:didit/client/client_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart()) {
    checkSession();
  }

  final AuthClient authClient = AuthClient();
  String? name;
  DateTime age = DateTime(2000, 1, 1);
  String displayAge = '1-1-2000';
  PhoneNumber? phoneNumber;
  String? smsCode;
  bool isValid = false;
  String? verificationId;

  void goStart() => emit(AuthStart());

  void goName() => emit(AuthName(name));

  void goAge() => emit(AuthAge(displayAge));

  void goNumber() => emit(AuthNumber(phoneNumber));

  void goCode() => emit(AuthCode());

  void setName(String? name) => this.name = name;

  void setAge(DateTime age) {
    displayAge = '${age.month}-${age.day}-${age.year}';
    this.age = age;
    emit(AuthAge(displayAge));
  }

  void setNumber(PhoneNumber? phoneNumber) => this.phoneNumber = phoneNumber;

  void setValid(bool isValid) => this.isValid = isValid;

  void setCode(String? smsCode) => this.smsCode = smsCode;

  void checkSession() async {
    try {
      await authClient.checkSession();
      emit(AuthLogin());
    } on String catch (error) {
      emit(AuthFailure(error));
    }
  }

  void verify() async {
    if (isValid) {
      final PhoneNumber? phoneNumber = this.phoneNumber;
      if (phoneNumber == null) return;
      final String? number = phoneNumber.phoneNumber;
      if (number == null) return;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
            final String? token = await userCredential.user?.getIdToken();
            if (token == null) return;
            await authClient.loginUser(token, number);
            emit(AuthLogin());
          } on String catch (error) {
            await authClient.loginError();
            emit(AuthFailure(error));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("VF: $e");
          emit(AuthFailure(e.code));
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          emit(AuthCode());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("TimedOut: $verificationId");
          emit(AuthFailure("Timeout: $verificationId"));
        },
      );
    }
  }

  void authenticate() async {
    final String? number = phoneNumber?.phoneNumber;
    final String? verificationId = this.verificationId;
    final String? smsCode = this.smsCode;
    if (number != null && verificationId != null && smsCode != null) {
      try {
        final PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final String? token = await userCredential.user?.getIdToken();
        if (token == null) return;
        await authClient.loginUser(token, number);
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

class AuthStart extends AuthState {}

class AuthName extends AuthState {
  final String? name;

  AuthName(this.name);
}

class AuthAge extends AuthState {
  final String displayAge;

  AuthAge(this.displayAge);
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