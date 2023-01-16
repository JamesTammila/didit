import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPageCubit extends Cubit<AuthPageState> {
  AuthPageCubit() : super(Initial());

  String? phoneNumber;
  bool isValid = false;

  void setNumber(String? phoneNumber) => this.phoneNumber = phoneNumber;

  void setValid(bool isValid) => this.isValid = isValid;

  void authenticate() async {
    if (isValid) {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint("VC: $credential");
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("VF: $e");
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint("CS: $verificationId $resendToken");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("CS: $verificationId");
        },
      );
    }
  }
}

@immutable
abstract class AuthPageState {}

class Initial extends AuthPageState {}

class Error extends AuthPageState {
  final String error;

  Error(this.error);
}