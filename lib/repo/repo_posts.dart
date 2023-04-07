import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_post.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/util/mock_database.dart';

abstract class IPostRepository {
  Future<MatchModel?> getMatch();
  Future<void> getPosts();
  Future<void> uploadPost(String mediaId, File file);
  Future<void> deletePost(String mediaId);
}

class PostRepository implements IPostRepository {
  final PostClient postClient = PostClient();
  final Map<String, PostModel> posts = {};

  final BehaviorSubject<Map<String, PostModel>> postsSubject = BehaviorSubject<Map<String, PostModel>>();

  Stream<Map<String, PostModel>> get postsStream => postsSubject.stream;

  @override
  Future<MatchModel?> getMatch() async {
    final String data = await postClient.fetchMatch();
    if (data.isEmpty) return null;
    final Map<String, dynamic> jsonObject = json.decode(data);
    final MatchModel match = MatchModel.fromJson(jsonObject);
    //await Future.delayed(const Duration(seconds: 1));
    //const MatchModel match = mockMatch;
    return match;
  }

  @override
  Future<void> getPosts() async {
    posts.clear();
    final String data = await postClient.fetchPosts();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final PostModel post = PostModel.fromJson(jsonObject);
      posts.putIfAbsent(post.objectId, () => post);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //final Map<String, PostModel> posts = mockPosts;
    //this.posts.addAll(posts);
    postsSubject.add(posts);
  }

  @override
  Future<void> uploadPost(String mediaId, File file) async {
    await postClient.uploadPost(mediaId, file);
  }

  @override
  Future<void> deletePost(String mediaId) async {
    await postClient.deletePost(mediaId);
  }
}