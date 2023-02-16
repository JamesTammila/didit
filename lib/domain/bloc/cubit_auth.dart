import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthStart());

  String? name;
  DateTime age = DateTime(2000, 1, 1);
  String displayAge = '1-1-2000';
  PhoneNumber? phoneNumber;
  int? code;
  bool isValid = false;

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

  void setCode(String? code) {
    if (code == null) return;
    this.code = int.parse(code);
    debugPrint(code.toString());
  }

  void authenticate() async {
    if (isValid) {
      final phoneNumber = this.phoneNumber;
      if (phoneNumber == null) return;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          debugPrint("VC: $credential");
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("VF: $e");
          emit(AuthFailure(e.code));
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint("CS: $verificationId $resendToken");

          /*final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly'
          ]);

          signInGoogle() async {
            GoogleSignInAccount account = await _googleSignIn.signIn();
            GoogleSignInAuthentication authentication =
                await account.authentication;
            await ParseUser.loginWith(
                'google',
                google(authentication.accessToken!, _googleSignIn.currentUser!.id, authentication.idToken!));
          }*/
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("CS: $verificationId");
          emit(AuthFailure("Timeout: $verificationId"));
        },
      );
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

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}