import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IAuthClient {
  Future<void> loginError();
  Future<void> checkSession();
  Future<void> loginUser(String accessToken, String id);
  Future<void> logoutUser();
  Future<void> deleteUser();
}

class AuthClient implements IAuthClient {
  @override
  Future<void> loginError() async {
    final user = await ParseUser.currentUser()
        .timeout(const Duration(seconds: 1));
    await user?.logout();
  }

  @override
  Future<void> checkSession() async {
    final user = await ParseUser.currentUser()
        .timeout(const Duration(seconds: 1));
    if (user == null) throw "User Null";
    final token = user?.sessionToken;
    if (token == null) throw "Token Null";
    final response = await ParseUser.getCurrentUserFromServer(token);
    if (response == null) throw "Response Null";
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
  }

  @override
  Future<void> loginUser(String accessToken, String id) async {
    final firstResponse = await ParseUser.loginWith('firebase', {
      'access_token': accessToken,
      'id': id,
    });
    if (firstResponse.error != null) {
      switch (firstResponse.error?.code) {
        case ParseError.timeout: throw "Server Connection Timed Out";
        case ParseError.internalServerError: throw "Server Down";
        case ParseError.connectionFailed: throw "Server Connection Failed";
        case ParseError.validationError: throw "Server Validation Failed";
        case ParseError.accountAlreadyLinked: throw "Account Already Linked";
        case ParseError.invalidSessionToken: throw "Invalid User Session";
        case ParseError.sessionMissing: throw "Missing User Session";
        default: throw "Response Failed";
      }
    }
    final user = await ParseUser.currentUser()
        .timeout(const Duration(seconds: 1));
    if (user == null) throw "User Null";
    final token = await FirebaseMessaging.instance.getToken()
        .timeout(const Duration(seconds: 1));
    if (token == null) throw "Token Null";
    final installation = await ParseInstallation.currentInstallation()
        .timeout(const Duration(seconds: 1));
    installation.set('pushType', 'gcm');
    installation.set('user', user);
    installation.set('deviceToken', token);
    final secondResponse = await installation.create();
    if (secondResponse.error != null) {
      switch (secondResponse.error?.code) {
        case ParseError.timeout: throw "Server Connection Timed Out";
        case ParseError.internalServerError: throw "Server Down";
        case ParseError.connectionFailed: throw "Server Connection Failed";
        case ParseError.validationError: throw "Server Validation Failed";
        case ParseError.invalidSessionToken: throw "Invalid User Session";
        case ParseError.sessionMissing: throw "Missing User Session";
        default: throw "Response Failed";
      }
    }
  }

  @override
  Future<void> logoutUser() async {
    final user = await ParseUser.currentUser()
        .timeout(const Duration(seconds: 1));
    if (user == null) throw "User Null";
    final response = await user.logout();
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
    await FirebaseMessaging.instance.deleteToken()
        .timeout(const Duration(seconds: 5));
  }

  @override
  Future<void> deleteUser() async {
    final response = await ParseCloudFunction("deleteUser").executeObjectFunction();
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
    await logoutUser();
  }
}