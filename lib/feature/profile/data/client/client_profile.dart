import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class IProfileClient {
  Future<void> saveProfile(Map<String, dynamic> data);
  Future<void> logoutUser();
  Future<void> deleteUser();
}

class ProfileClient implements IProfileClient {
  @override
  Future<void> saveProfile(Map<String, dynamic> data) async {
    final user =
        await ParseUser.currentUser().timeout(const Duration(seconds: 1));
    if (user == null) throw "User Null";
    ParseFile parseFile = ParseFile(data['file']);
    final firstResponse = await parseFile.save();
    if (firstResponse.error != null) {
      switch (firstResponse.error?.code) {
        case ParseError.timeout:throw "Server Connection Timed Out";
        case ParseError.internalServerError:throw "Server Down";
        case ParseError.connectionFailed:throw "Server Connection Failed";
        case ParseError.validationError:throw "Server Validation Failed";
        case ParseError.invalidSessionToken:throw "Invalid User Session";
        case ParseError.sessionMissing:throw "Missing User Session";
        default:throw "Response Failed";
      }
    }
    user.set('proPic', parseFile);
    user.set('name', data['name']);
    user.set('bio', data['bio']);
    final secondResponse = await user.save();
    if (secondResponse.error != null) {
      switch (secondResponse.error?.code) {
        case ParseError.timeout:throw "Server Connection Timed Out";
        case ParseError.internalServerError:throw "Server Down";
        case ParseError.connectionFailed:throw "Server Connection Failed";
        case ParseError.validationError:throw "Server Validation Failed";
        case ParseError.invalidSessionToken:throw "Invalid User Session";
        case ParseError.sessionMissing:throw "Missing User Session";
        default:throw "Response Failed";
      }
    }
  }

  @override
  Future<void> logoutUser() async {
    final user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
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
    await FirebaseMessaging.instance.deleteToken().timeout(const Duration(seconds: 10));
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