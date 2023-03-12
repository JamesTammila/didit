import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:didit/client/error_parse.dart';

abstract class IAccountClient {
  Future<Map<String, String>> getProfile();
  Future<void> saveProfile(Map<String, dynamic> data);
}

class AccountClient implements IAccountClient {
  @override
  Future<Map<String, String>> getProfile() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final String username = user.get('username');
    final String name = user.get('name');
    final String bio = user.get('bio');
    final String url;
    if (user.containsKey('proPic')) {
      url = user.get('proPic')['url'];
    } else {
      url = '';
    }
    return {
      'username': username,
      'name': name,
      'bio': bio,
      'url': url,
    };
  }

  @override
  Future<void> saveProfile(Map<String, dynamic> data) async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final File? file = data['file'];
    if (file != null) {
      if (file.path.isNotEmpty) {
        final ParseFile parseFile = ParseFile(data['file']);
        final ParseResponse firstResponse = await parseFile.save();
        checkError(firstResponse);
        user.set('proPic', parseFile);
      } else {
        user.unset('proPic');
      }
    }
    user.set('name', data['name']);
    user.set('bio', data['bio']);
    final ParseResponse secondResponse = await user.save();
    checkError(secondResponse);
  }
}