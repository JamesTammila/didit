import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IAuthClient {
  Future<void> checkSession();
  Future<void> loginUser(String accessToken, String id);
  Future<void> loginError();
}

class AuthClient implements IAuthClient {
  checkError(ParseResponse response) {
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
  Future<void> checkSession() async {
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final token = user?.sessionToken;
    if (token == null) throw "Token Null";
    final response = await ParseUser.getCurrentUserFromServer(token);
    if (response == null) throw "Response Null";
    checkError(response);
  }

  @override
  Future<void> loginUser(String accessToken, String id) async {
    final firstResponse = await ParseUser.loginWith('firebase', {
      'access_token': accessToken,
      'id': id,
    });
    checkError(firstResponse);
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final token = await FirebaseMessaging.instance.getToken().timeout(const Duration(seconds: 10));
    if (token == null) throw "Token Null";
    final installation = await ParseInstallation.currentInstallation().timeout(const Duration(seconds: 10));
    installation.set('pushType', 'gcm');
    installation.set('user', user);
    installation.set('deviceToken', token);
    final secondResponse = await installation.create();
    checkError(secondResponse);
  }

  @override
  Future<void> loginError() async {
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    await user?.logout();
  }
}