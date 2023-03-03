import 'dart:convert';
import 'package:didit/client/client_home.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/mock_database.dart';

abstract class IPostRepository {
  Future<PostModel> getMatch();
  Future<Map<String, PostModel>> getPosts();
}

class PostRepository implements IPostRepository {
  final homeClient = HomeClient();

  @override
  Future<PostModel> getMatch() async {
    /*final data = await homeClient.fetchMatch();
    final Map<String, dynamic> jsonObject = json.decode(data);
    final match = PostModel.fromJson(jsonObject);*/
    await Future.delayed(const Duration(seconds: 1));
    const match = mockMatch;
    return match;
  }

  @override
  Future<Map<String, PostModel>> getPosts() async {
    /*Map<String, PostModel> posts = {};
    final data = await homeClient.fetchPosts();
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final post = PostModel.fromJson(jsonObject);
      posts.putIfAbsent(post.objectId, () => post);
    }*/
    await Future.delayed(const Duration(seconds: 1));
    final posts = mockPosts;
    return posts;
  }
}