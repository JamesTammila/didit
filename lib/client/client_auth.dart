import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IAuthClient {
  Future<void> checkSession();
  Future<void> loginUser(String accessToken, String id);
  Future<void> loginError();
  Future<void> logoutUser();
  Future<void> deleteUser();
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
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final String? token = user.sessionToken;
    if (token == null) throw "Token Null";
    final ParseResponse? response = await ParseUser.getCurrentUserFromServer(token);
    if (response == null) throw "Response Null";
    checkError(response);
  }

  @override
  Future<void> loginUser(String accessToken, String id) async {
    final ParseResponse firstResponse = await ParseUser.loginWith('firebase', {
      'access_token': accessToken,
      'id': id,
    });
    checkError(firstResponse);
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final String? token = await FirebaseMessaging.instance.getToken().timeout(const Duration(seconds: 10));
    if (token == null) throw "Token Null";
    final ParseInstallation installation = await ParseInstallation.currentInstallation().timeout(const Duration(seconds: 10));
    installation.set('pushType', 'gcm');
    installation.set('user', user);
    installation.set('deviceToken', token);
    final ParseResponse secondResponse = await installation.create();
    checkError(secondResponse);
  }

  @override
  Future<void> loginError() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    await user?.logout();
  }

  @override
  Future<void> logoutUser() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final ParseResponse response = await user.logout();
    checkError(response);
    await FirebaseMessaging.instance.deleteToken().timeout(const Duration(seconds: 10));
  }

  @override
  Future<void> deleteUser() async {
    final ParseResponse response = await ParseCloudFunction("deleteUser").execute();
    checkError(response);
    await logoutUser();
  }
}