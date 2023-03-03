import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IHomeClient {
  Future<String> fetchMatch();
  Future<String> fetchPosts();
  Future<void> uploadPost(File file);
  Future<void> likePost(String postId);
}

class HomeClient implements IHomeClient {
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
  Future<String> fetchMatch() async {
    final ParseResponse response = await ParseCloudFunction("getMatch").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchPosts() async {
    final ParseResponse response = await ParseCloudFunction("getPosts").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<void> uploadPost(File file) async {
    final ParseFile parseFile = ParseFile(file);
    final ParseResponse firstResponse = await parseFile.save();
    checkError(firstResponse);
  }

  @override
  Future<void> likePost(String matchId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }
}