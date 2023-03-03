import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:didit/client/error_parse.dart';

abstract class IPostClient {
  Future<String> fetchMatch();
  Future<String> fetchPosts();
  Future<void> uploadPost(File file);
  Future<void> likePost(String postId);
}

class PostClient implements IPostClient {
  @override
  Future<String> fetchMatch() async {
    final ParseResponse response = await ParseCloudFunction('getMatch').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchPosts() async {
    final ParseResponse response = await ParseCloudFunction('getPosts').execute();
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