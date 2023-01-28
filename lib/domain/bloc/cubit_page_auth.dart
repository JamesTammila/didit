import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
          emit(Error(e.code));
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
          emit(Error("Timeout: $verificationId"));
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