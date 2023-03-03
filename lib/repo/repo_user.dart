import 'dart:convert';
import 'package:didit/client/client_friends.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/mock_database.dart';

abstract class IUserRepository {
  Future<Map<String, UserModel>> getSuggestions();
  Future<Map<String, UserModel>> getFriends();
  Future<Map<String, UserModel>> getRequests();
  Future<Map<String, UserModel>> getSentRequests();
  Future<Map<String, UserModel>> getSearch(String text);
  Future<Map<String, UserModel>> getRecent();
  Future<void> insertRecent(UserModel userModel);
  Future<void> removeRecent(UserModel userModel);
}

class UserRepository implements IUserRepository {
  final friendsClient = FriendsClient();
  final Map<String, UserModel> suggestions = {};
  final Map<String, UserModel> friends = {};
  final Map<String, UserModel> requests = {};
  final Map<String, UserModel> sentRequests = {};
  final Map<String, UserModel> recentSearch = {};

  @override
  Future<Map<String, UserModel>> getSuggestions() async {
    final data = await friendsClient.fetchSuggestions();
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final suggestion = UserModel.fromJson(jsonObject);
      suggestions.putIfAbsent(suggestion.objectId, () => suggestion);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //Map<String, UserModel> suggestions = mockSuggestions;
    return suggestions;
  }

  @override
  Future<Map<String, UserModel>> getFriends() async {
    final data = await friendsClient.fetchFriends();
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final friend = UserModel.fromJson(jsonObject);
      friends.putIfAbsent(friend.objectId, () => friend);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //Map<String, UserModel> friends = mockFriends;
    return friends;
  }

  @override
  Future<Map<String, UserModel>> getRequests() async {
    final data = await friendsClient.fetchRequests();
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final request = UserModel.fromJson(jsonObject);
      requests.putIfAbsent(request.objectId, () => request);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //Map<String, UserModel> requests = mockRequests;
    return requests;
  }

  @override
  Future<Map<String, UserModel>> getSentRequests() async {
    final data = await friendsClient.fetchSentRequests();
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final sentRequest = UserModel.fromJson(jsonObject);
      sentRequests.putIfAbsent(sentRequest.objectId, () => sentRequest);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //Map<String, UserModel> sentRequests = mockSentRequests;
    return sentRequests;
  }

  @override
  Future<Map<String, UserModel>> getSearch(String text) async {
    Map<String, UserModel> users = {};
    final data = await friendsClient.fetchSearch(text.toLowerCase());
    List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final user = UserModel.fromJson(jsonObject);
      users.putIfAbsent(user.objectId, () => user);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //Map<String, UserModel> users = mockSearch;
    return users;
  }

  @override
  Future<Map<String, UserModel>> getRecent() async {
    return recentSearch;
  }

  @override
  Future<void> insertRecent(UserModel userModel) async {
    recentSearch.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> removeRecent(UserModel userModel) async {
    recentSearch.remove(userModel.objectId);
  }
}