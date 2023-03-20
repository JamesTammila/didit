import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:didit/client/error_parse.dart';

abstract class IAuthClient {
  Future<void> checkSession();
  Future<void> loginUser(Map<String, dynamic> data);
  Future<void> loginError();
  Future<void> logoutUser();
  Future<void> deleteUser();
}

class AuthClient implements IAuthClient {
  @override
  Future<void> checkSession() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final String? token = user.sessionToken;
    if (token == null) throw 'Token Null';
    final ParseResponse? response = await ParseUser.getCurrentUserFromServer(token);
    if (response == null) throw 'Response Null';
    checkError(response);
  }

  @override
  Future<void> loginUser(Map<String, dynamic> data) async {
    final ParseResponse firstResponse = await ParseUser.loginWith(
      'firebase',
      {'access_token': data['accessToken'], 'id': data['verificationId']},
      username: data['username'],
    );
    checkError(firstResponse);
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    user.set('name', data['name']);
    user.set('age', data['age']);
    final ParseResponse secondResponse = await user.save();
    checkError(secondResponse);
    final String? token = defaultTargetPlatform == TargetPlatform.iOS
        ? await FirebaseMessaging.instance.getAPNSToken()
        : await FirebaseMessaging.instance.getToken();
    if (token == null) throw 'Token Null';
    final ParseInstallation installation = await ParseInstallation.currentInstallation().timeout(const Duration(seconds: 10));
    installation.set('user', user);
    installation.set('deviceToken', token);
    final ParseResponse thirdResponse = await installation.create();
    checkError(thirdResponse);
  }

  @override
  Future<void> loginError() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    await user?.logout();
  }

  @override
  Future<void> logoutUser() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final ParseResponse response = await user.logout();
    checkError(response);
    await FirebaseMessaging.instance.deleteToken().timeout(const Duration(seconds: 10));
  }

  @override
  Future<void> deleteUser() async {
    final ParseResponse response = await ParseCloudFunction('deleteUser').execute();
    checkError(response);
    await logoutUser();
  }
}