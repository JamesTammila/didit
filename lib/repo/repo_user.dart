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
  final FriendsClient friendsClient = FriendsClient();
  final Map<String, UserModel> suggestions = {};
  final Map<String, UserModel> friends = {};
  final Map<String, UserModel> requests = {};
  final Map<String, UserModel> sentRequests = {};
  final Map<String, UserModel> recentSearch = {};

  @override
  Future<Map<String, UserModel>> getSuggestions() async {
    final String data = await friendsClient.fetchSuggestions();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel suggestion = UserModel.fromJson(jsonObject);
      suggestions.putIfAbsent(suggestion.objectId, () => suggestion);
    }
    /*await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> suggestions = mockSuggestions;*/
    return suggestions;
  }

  @override
  Future<Map<String, UserModel>> getFriends() async {
    final String data = await friendsClient.fetchFriends();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel friend = UserModel.fromJson(jsonObject);
      friends.putIfAbsent(friend.objectId, () => friend);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> friends = mockFriends;
    return friends;
  }

  @override
  Future<Map<String, UserModel>> getRequests() async {
    final String data = await friendsClient.fetchRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel request = UserModel.fromJson(jsonObject);
      requests.putIfAbsent(request.objectId, () => request);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> requests = mockRequests;
    return requests;
  }

  @override
  Future<Map<String, UserModel>> getSentRequests() async {
    final String data = await friendsClient.fetchSentRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel sentRequest = UserModel.fromJson(jsonObject);
      sentRequests.putIfAbsent(sentRequest.objectId, () => sentRequest);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> sentRequests = mockSentRequests;
    return sentRequests;
  }

  @override
  Future<Map<String, UserModel>> getSearch(String text) async {
    final Map<String, UserModel> users = {};
    final String data = await friendsClient.fetchSearch(text.toLowerCase());
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel user = UserModel.fromJson(jsonObject);
      users.putIfAbsent(user.objectId, () => user);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> users = mockSearch;
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