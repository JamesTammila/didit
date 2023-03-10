import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_post.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/util/mock_database.dart';

abstract class IPostRepository {
  Future<PostModel?> getMatch();
  Future<void> getPosts();
  Future<void> likePost(String postId);
}

class PostRepository implements IPostRepository {
  final PostClient postClient = PostClient();
  final Map<String, PostModel> posts = {};

  final BehaviorSubject<Map<String, PostModel>> postsSubject = BehaviorSubject<Map<String, PostModel>>();

  Stream<Map<String, PostModel>> get postsStream => postsSubject.stream;

  @override
  Future<PostModel?> getMatch() async {
    final String data = await postClient.fetchMatch();
    if (data.isEmpty) return null;
    final Map<String, dynamic> jsonObject = json.decode(data);
    final PostModel match = PostModel.fromJson(jsonObject);
    //await Future.delayed(const Duration(seconds: 1));
    //const PostModel match = mockMatch;
    return match;
  }

  @override
  Future<void> getPosts() async {
    final Map<String, PostModel> posts = {};
    final String data = await postClient.fetchPosts();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final PostModel post = PostModel.fromJson(jsonObject);
      posts.putIfAbsent(post.objectId, () => post);
    }
    //await Future.delayed(const Duration(seconds: 1));
    //final Map<String, PostModel> posts = mockPosts;
    //this.posts.addAll(posts);
    postsSubject.add(posts);
  }

  @override
  Future<void> likePost(String postId) async {
    await postClient.likePost(postId);
  }
}