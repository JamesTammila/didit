import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:didit/client/client_post.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_media.dart';
import 'package:didit/util/mock_database.dart';

abstract class IPostRepository {
  Future<void> getMatch();
  Future<void> refreshMatch();
  Future<void> clearMatch();
  Future<PostModel?> retrieveMatch();
  Future<void> getPosts();
  Future<void> getMemories();
  Future<void> openMemories();
  Future<void> uploadPost(String mediaId, File file);
  Future<void> deletePost(PostModel postModel);
}

class PostRepository implements IPostRepository {
  final PostClient postClient = PostClient();
  PostModel? match;
  final Map<String, PostModel> posts = {};
  final Map<String, PostModel> memories = {};

  final StreamController<PostModel?> matchController = StreamController<PostModel?>.broadcast();
  final StreamController<Map<String, PostModel>> postsController = StreamController<Map<String, PostModel>>.broadcast();
  final StreamController<Map<String, PostModel>> memoriesController = StreamController<Map<String, PostModel>>.broadcast();

  Stream<PostModel?> get matchStream => matchController.stream;
  Stream<Map<String, PostModel>> get postsStream => postsController.stream;
  Stream<Map<String, PostModel>> get memoriesStream => memoriesController.stream;

  @override
  Future<void> getMatch() async {
    final String data = await postClient.fetchMatch();
    if (data.isEmpty) {
      match = null;
    } else {
      final Map<String, dynamic> jsonObject = json.decode(data);
      match = PostModel.fromJson(jsonObject);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //match = mockMatch;
    matchController.add(match);
  }

  @override
  Future<void> refreshMatch() async {
    final String data = await postClient.fetchMatch();
    if (data.isEmpty) {
      match = null;
    } else {
      final Map<String, dynamic> jsonObject = json.decode(data);
      match = PostModel.fromJson(jsonObject);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //match = mockMatch;
    matchController.add(match);
  }

  @override
  Future<void> clearMatch() async {
    match = null;
    matchController.add(match);
  }

  @override
  Future<PostModel?> retrieveMatch() async => match;

  @override
  Future<void> getPosts() async {
    posts.clear();
    final String data = await postClient.fetchPosts();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final PostModel post = PostModel.fromJson(jsonObject);
      posts.putIfAbsent(post.objectId, () => post);
    }
    /*await Future.delayed(const Duration(seconds: 1));
    final Map<String, PostModel> posts = mockPosts;
    this.posts.addAll(posts);*/
    postsController.add(posts);
  }

  @override
  Future<void> getMemories() async {
    memories.clear();
    final String data = await postClient.fetchMemories();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final PostModel memory = PostModel.fromJson(jsonObject);
      memories.putIfAbsent(memory.objectId, () => memory);
    }
    /*await Future.delayed(const Duration(milliseconds: 250));
    final Map<String, PostModel> memories = mockMemories;
    this.memories.addAll(memories);*/
    memoriesController.add(memories);
  }

  @override
  Future<void> openMemories() async => memoriesController.add(memories);

  @override
  Future<void> uploadPost(String mediaId, File file) async {
    await postClient.uploadPost(mediaId, file);
  }

  @override
  Future<void> deletePost(PostModel memory) async {
    final ParseUser? user = await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    final String? userId = user.objectId;
    if (userId == null) throw 'UserId Null';
    String? mediaId;
    for (MediaModel media in memory.medias) {
      if (userId == media.user.objectId) {
        mediaId = media.objectId;
        break;
      }
    }
    if (mediaId == null) throw 'MediaId Null';
    await postClient.deletePost(mediaId);
    memories.remove(memory.objectId);
    memoriesController.add(memories);
  }
}