import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:didit/client/error_parse.dart';

abstract class IAccountClient {
  Future<void> saveProfile(Map<String, dynamic> data);
}

class AccountClient implements IAccountClient {
  @override
  Future<void> saveProfile(Map<String, dynamic> data) async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
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