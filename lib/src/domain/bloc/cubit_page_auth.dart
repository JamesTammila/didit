import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit() : super(Initial());

  String? phoneNumber;

  void setNumber(String? phoneNumber) => this.phoneNumber = phoneNumber;

  void authenticate() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {

      },
      verificationFailed: (FirebaseAuthException e) {

      },
      codeSent: (String verificationId, int? resendToken) {

      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }
}

@immutable
abstract class AuthPageState {}

class Initial extends AuthPageState {}

class Error extends AuthPageState {
  final String error;

  Error(this.error);
}