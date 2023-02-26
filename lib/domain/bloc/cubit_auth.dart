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

  void setCode(String? smsCode) {
    if (smsCode == null) return;
    this.smsCode = smsCode;
    debugPrint(smsCode.toString());
  }

  void verify() async {
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
          this.verificationId = verificationId;
          emit(AuthCode());
          debugPrint("CS: $verificationId $resendToken");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint("CS: $verificationId");
          emit(AuthFailure("Timeout: $verificationId"));
        },
      );
    }
  }

  void authenticate() async {
    final phoneNumber = this.phoneNumber;
    final verificationId = this.verificationId;
    final smsCode = this.smsCode;
    if (phoneNumber != null && verificationId != null && smsCode != null) {

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final usercred = await FirebaseAuth.instance.signInWithCredential(credential);
      String? token = await usercred.user?.getIdToken();

      final response = await ParseUser.loginWith('firebase', {
        'access_token' : token,
        'id' : phoneNumber.phoneNumber,
      });

      if (response.error != null) {
        switch (response.error?.code) {
          case ParseError.timeout: throw "Server Connection Timed Out";
          case ParseError.internalServerError: throw "Server Down";
          case ParseError.connectionFailed: throw "Server Connection Failed";
          case ParseError.validationError: throw "Server Validation Failed";
          case ParseError.invalidSessionToken: throw "Invalid User Session";
          case ParseError.sessionMissing: throw "Missing User Session";
          default: throw "Response Failed";
        }
      }
      emit(AuthLogin());
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