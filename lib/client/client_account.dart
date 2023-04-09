import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:didit/client/error_parse.dart';

abstract class IAccountClient {
  Future<Map<String, dynamic>> fetchProfile();
  Future<void> saveProfile(Map<String, dynamic> data);
  Future<void> saveMatching(bool isMatching);
}

class AccountClient implements IAccountClient {
  @override
  Future<Map<String, dynamic>> fetchProfile() async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final String username = user.get('username');
    final String name = user.get('name');
    final String bio = user.get('bio');
    final String color = user.get('color');
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
      'color': color,
    };
    /*return {
      'username': 'jessiejoh',
      'name': 'Jessie',
      'bio': '@jessiejohannson22',
      'url': 'https://i.pinimg.com/736x/78/4f/e8/784fe85e83e44328112af4298efdd9d6.jpg',
      'color': '0',
    };*/
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

  @override
  Future<void> saveMatching(bool isMatching) async {
    final ParseResponse response = await ParseCloudFunction('toggleMatching').execute(
      parameters: {'isMatching': isMatching},
    );
    checkError(response);
  }
}