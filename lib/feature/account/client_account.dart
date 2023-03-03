import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IAccountClient {
  Future<void> saveProfile(Map<String, dynamic> data);
  Future<void> shareLink();
  Future<void> openWebsite();
  Future<void> logoutUser();
  Future<void> deleteUser();
}

class AccountClient implements IAccountClient {
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
  Future<void> saveProfile(Map<String, dynamic> data) async {
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    ParseFile parseFile = ParseFile(data['file']);
    final firstResponse = await parseFile.save();
    checkError(firstResponse);
    user.set('proPic', parseFile);
    user.set('name', data['name']);
    user.set('bio', data['bio']);
    final secondResponse = await user.save();
    checkError(secondResponse);
  }

  @override
  Future<void> shareLink() async {
    await Share.share('https://dewdrop.app/');
  }

  @override
  Future<void> openWebsite() async {
    if (!await launchUrl(Uri.parse('https://dewdrop.app/'))) {
      throw 'Could not connect to https://dewdrop.app/.';
    }
  }

  @override
  Future<void> logoutUser() async {
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final response = await user.logout();
    checkError(response);
    await FirebaseMessaging.instance.deleteToken().timeout(const Duration(seconds: 10));
  }

  @override
  Future<void> deleteUser() async {
    final response = await ParseCloudFunction("deleteUser").execute();
    checkError(response);
    await logoutUser();
  }
}