import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IAccountClient {
  Future<void> saveProfile(Map<String, dynamic> data);
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
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw "User Null";
    final ParseFile parseFile = ParseFile(data['file']);
    final ParseResponse firstResponse = await parseFile.save();
    checkError(firstResponse);
    user.set('proPic', parseFile);
    user.set('name', data['name']);
    user.set('bio', data['bio']);
    final ParseResponse secondResponse = await user.save();
    checkError(secondResponse);
  }
}