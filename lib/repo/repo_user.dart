import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_user.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/util/mock_database.dart';

abstract class IUserRepository {
  Future<Map<String, UserModel>> getSuggestions();
  Future<void> getFriends();
  Future<Map<String, UserModel>> getRequests();
  Future<Map<String, UserModel>> getSentRequests();
  Future<Map<String, UserModel>> getSearch(String text);
  Future<Map<String, UserModel>> getRecent();
  Future<void> insertFriend(UserModel userModel);
  Future<void> insertRequest(UserModel userModel);
  Future<void> insertSentRequest(UserModel userModel);
  Future<void> insertRecent(UserModel userModel);
  Future<void> removeFriend(UserModel userModel);
  Future<void> removeRequest(UserModel userModel);
  Future<void> removeSentRequest(UserModel userModel);
  Future<void> removeRecent(UserModel userModel);
}

class UserRepository implements IUserRepository {
  final UserClient userClient = UserClient();
  final Map<String, UserModel> suggestions = {};
  final Map<String, UserModel> friends = {};
  final Map<String, UserModel> requests = {};
  final Map<String, UserModel> sentRequests = {};
  final Map<String, UserModel> recentSearch = {};

  final BehaviorSubject<Map<String, UserModel>> suggestionsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> friendsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> requestsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> sentRequestsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> recentSearchSubject = BehaviorSubject<Map<String, UserModel>>();

  Stream<Map<String, UserModel>> get friendsStream => friendsSubject.stream;

  @override
  Future<Map<String, UserModel>> getSuggestions() async {
    /*final String data = await userClient.fetchSuggestions();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel suggestion = UserModel.fromJson(jsonObject);
      suggestions.putIfAbsent(suggestion.objectId, () => suggestion);
    }*/
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> suggestions = mockSuggestions;
    return suggestions;
  }

  @override
  Future<void> getFriends() async {
    /*final String data = await userClient.fetchFriends();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel friend = UserModel.fromJson(jsonObject);
      friends.putIfAbsent(friend.objectId, () => friend);
    }*/
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> friends = mockFriends;
    this.friends.addAll(friends);
    friendsSubject.add(this.friends);
  }

  @override
  Future<Map<String, UserModel>> getRequests() async {
    /*final String data = await userClient.fetchRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel request = UserModel.fromJson(jsonObject);
      requests.putIfAbsent(request.objectId, () => request);
    }*/
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> requests = mockRequests;
    return requests;
  }

  @override
  Future<Map<String, UserModel>> getSentRequests() async {
    /*final String data = await userClient.fetchSentRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel sentRequest = UserModel.fromJson(jsonObject);
      sentRequests.putIfAbsent(sentRequest.objectId, () => sentRequest);
    }*/
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> sentRequests = mockSentRequests;
    return sentRequests;
  }

  @override
  Future<Map<String, UserModel>> getSearch(String text) async {
    /*final Map<String, UserModel> users = {};
    final String data = await userClient.fetchSearch(text.toLowerCase());
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel user = UserModel.fromJson(jsonObject);
      users.putIfAbsent(user.objectId, () => user);
    }*/
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> users = mockSearch;
    return users;
  }

  @override
  Future<Map<String, UserModel>> getRecent() async {
    return recentSearch;
  }

  @override
  Future<void> insertFriend(UserModel userModel) async {
    friends.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> insertRequest(UserModel userModel) async {
    requests.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> insertSentRequest(UserModel userModel) async {
    sentRequests.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> insertRecent(UserModel userModel) async {
    recentSearch.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> removeFriend(UserModel userModel) async {
    friends.remove(userModel.objectId);
    //friendsSubject.add(friends);
  }

  @override
  Future<void> removeRequest(UserModel userModel) async {
    requests.remove(userModel.objectId);
  }

  @override
  Future<void> removeSentRequest(UserModel userModel) async {
    sentRequests.remove(userModel.objectId);
  }

  @override
  Future<void> removeRecent(UserModel userModel) async {
    recentSearch.remove(userModel.objectId);
  }
}