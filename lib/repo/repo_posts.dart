import 'dart:convert';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_post.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/util/mock_database.dart';

abstract class IPostRepository {
  Future<MatchModel?> getMatch();
  Future<void> getPosts();
  Future<Map<String, UserModel>> getLikes(String postId);
  Future<void> uploadPost(String mediaId, File file);
  Future<void> deletePost(String mediaId);
  Future<void> likePost(String postId);
}

class PostRepository implements IPostRepository {
  final PostClient postClient = PostClient();
  final Map<String, PostModel> posts = {};

  final BehaviorSubject<Map<String, PostModel>> postsSubject = BehaviorSubject<Map<String, PostModel>>();

  Stream<Map<String, PostModel>> get postsStream => postsSubject.stream;

  @override
  Future<MatchModel?> getMatch() async {
    /*final String data = await postClient.fetchMatch();
    if (data.isEmpty) return null;
    final Map<String, dynamic> jsonObject = json.decode(data);
    final MatchModel match = MatchModel.fromJson(jsonObject);*/
    await Future.delayed(const Duration(seconds: 1));
    const MatchModel match = mockMatch;
    return match;
  }

  @override
  Future<void> getPosts() async {
    /*final Map<String, PostModel> posts = {};
    final String data = await postClient.fetchPosts();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final PostModel post = PostModel.fromJson(jsonObject);
      posts.putIfAbsent(post.objectId, () => post);
    }*/
    await Future.delayed(const Duration(seconds: 1));
    final Map<String, PostModel> posts = mockPosts;
    this.posts.addAll(posts);
    postsSubject.add(posts);
  }

  @override
  Future<Map<String, UserModel>> getLikes(String postId) async {
    final Map<String, UserModel> users = {};
    final String data = await postClient.fetchLikes(postId);
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel user = UserModel.fromJson(jsonObject);
      users.putIfAbsent(user.objectId, () => user);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //final Map<String, PostModel> posts = mockPosts;
    return users;
  }

  @override
  Future<void> uploadPost(String mediaId, File file) async {
    await postClient.uploadPost(mediaId, file);
  }

  @override
  Future<void> deletePost(String mediaId) async {
    await postClient.deletePost(mediaId);
  }

  @override
  Future<void> likePost(String postId) async {
    //await postClient.likePost(postId);
    await Future.delayed(const Duration(milliseconds: 100));
    final PostModel? postModel = posts[postId];
    if (postModel == null) return;
    final bool isLiked = postModel.isLiked;
    final PostModel updatedPost = postModel.copyWith(isLiked: !isLiked);
    posts.update(postId, (value) => updatedPost);
    postsSubject.add(posts);
  }
}