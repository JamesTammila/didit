import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:didit/client/error_parse.dart';

abstract class IPostClient {
  Future<String> fetchMatch();
  Future<String> fetchPosts();
  Future<String> fetchMemories();
  Future<void> uploadPost(String mediaId, File file);
  Future<void> deletePost(String mediaId);
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
  Future<String> fetchMemories() async {
    final ParseResponse response = await ParseCloudFunction('getMemories').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<void> uploadPost(String mediaId, File file) async {
    final ParseFile parseFile = ParseFile(file);
    final ParseResponse firstResponse = await parseFile.save();
    checkError(firstResponse);
    ParseObject media = ParseObject('PostParticipants')..objectId = mediaId;
    media.set('media', parseFile);
    final ParseResponse secondResponse = await media.save();
    checkError(secondResponse);
  }

  @override
  Future<void> deletePost(String mediaId) async {
    final ParseResponse response = await ParseCloudFunction('deletePostParticipant').execute(
      parameters: {'postParticipantId': mediaId},
    );
    checkError(response);
  }
}