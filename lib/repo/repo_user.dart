import 'dart:async';
import 'dart:convert';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:didit/client/client_user.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/util/mock_database.dart';

abstract class IUserRepository {
  //Future<void> getSuggestions();
  Future<void> getFriends();
  Future<void> getRequests();
  Future<void> getSentRequests();
  Future<void> filterFriends(String text);
  Future<void> filterRequests(String text);
  Future<void> filterSentRequests(String text);
  Future<void> getSearch(String text);
  Future<void> getRecent();
  Future<void> clearRecent();
  Future<Map<String, dynamic>> getUser(String userId);
  Future<FriendModel> sendRequest(UserModel userModel);
  Future<void> cancelRequest(FriendModel friendModel);
  Future<void> acceptRequest(FriendModel friendModel);
  Future<void> rejectRequest(FriendModel friendModel);
  Future<void> unfriendUser(FriendModel friendModel);
  Future<void> insertRecent(UserModel userModel);
  Future<void> removeRecent(UserModel userModel);
}

class UserRepository implements IUserRepository {
  final UserClient userClient = UserClient();
  //final Map<String, FriendModel> suggestions = {};
  final Map<String, FriendModel> friends = {};
  final Map<String, FriendModel> requests = {};
  final Map<String, FriendModel> sentRequests = {};
  final Map<String, FriendModel> filteredFriends = {};
  final Map<String, FriendModel> filteredRequests = {};
  final Map<String, FriendModel> filteredSentRequests = {};
  final Map<String, UserModel> search = {};
  final Map<String, UserModel> recent = {};

  //final StreamController<Map<String, FriendModel>> suggestionsController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> friendsController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> requestsController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> sentRequestsController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> friendsFilterController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> requestsFilterController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, FriendModel>> sentRequestsFilterController = StreamController<Map<String, FriendModel>>.broadcast();
  final StreamController<Map<String, UserModel>> searchController = StreamController<Map<String, UserModel>>.broadcast();
  final StreamController<Map<String, UserModel>> recentController = StreamController<Map<String, UserModel>>.broadcast();

  //Stream<Map<String, FriendModel>> get suggestionsStream => suggestionsController.stream;
  Stream<Map<String, FriendModel>> get friendsStream => friendsController.stream;
  Stream<Map<String, FriendModel>> get requestsStream => requestsController.stream;
  Stream<Map<String, FriendModel>> get sentRequestsStream => sentRequestsController.stream;
  Stream<Map<String, FriendModel>> get friendsFilterStream => friendsFilterController.stream;
  Stream<Map<String, FriendModel>> get requestsFilterStream => requestsFilterController.stream;
  Stream<Map<String, FriendModel>> get sentRequestsFilterStream => sentRequestsFilterController.stream;
  Stream<Map<String, UserModel>> get searchStream => searchController.stream;
  Stream<Map<String, UserModel>> get recentStream => recentController.stream;

  /*@override
  Future<void> getSuggestions() async {
    suggestions.clear();
    final String data = await userClient.fetchSuggestions();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final FriendModel suggestion = FriendModel.fromJson(jsonObject);
      suggestions.putIfAbsent(suggestion.user.objectId, () => suggestion);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, FriendModel> suggestions = mockSuggestions;
    this.suggestions.addAll(suggestions);
    suggestionsController.add(this.suggestions);
  }*/

  @override
  Future<void> getFriends() async {
    friends.clear();
    final String data = await userClient.fetchFriends();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final FriendModel friend = FriendModel.fromJson(jsonObject);
      friends.putIfAbsent(friend.user.objectId, () => friend);
    }
    /*this.friends.clear();
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, FriendModel> friends = mockFriends;
    this.friends.addAll(friends);*/
    friendsController.add(friends);
  }

  @override
  Future<void> getRequests() async {
    requests.clear();
    final String data = await userClient.fetchRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final FriendModel request = FriendModel.fromJson(jsonObject);
      requests.putIfAbsent(request.user.objectId, () => request);
    }
    /*this.requests.clear();
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, FriendModel> requests = mockRequests;
    this.requests.addAll(requests);*/
    requestsController.add(requests);
  }

  @override
  Future<void> getSentRequests() async {
    sentRequests.clear();
    final String data = await userClient.fetchSentRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final FriendModel sentRequest = FriendModel.fromJson(jsonObject);
      sentRequests.putIfAbsent(sentRequest.user.objectId, () => sentRequest);
    }
    /*this.sentRequests.clear();
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, FriendModel> sentRequests = mockSentRequests;
    this.sentRequests.addAll(sentRequests);*/
    sentRequestsController.add(sentRequests);
  }

  @override
  Future<void> getSearch(String text) async {
    search.clear();
    final String data = await userClient.fetchSearch(text.toLowerCase());
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final UserModel user = UserModel.fromJson(jsonObject);
      search.putIfAbsent(user.objectId, () => user);
    }
    /*this.search.clear();
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> search = mockSearch;*/
    final ParseUser? user =
        await ParseUser.currentUser().timeout(const Duration(seconds: 10));
    if (user == null) throw 'User Null';
    search.removeWhere((key, value) =>
        friends.containsKey(key) ||
        requests.containsKey(key) ||
        sentRequests.containsKey(key) || key == user.objectId);
    //this.search.addAll(search);
    searchController.add(search);
  }

  @override
  Future<void> getRecent() async => recentController.add(recent);

  @override
  Future<void> clearRecent() async {
    recent.clear();
    recentController.add(recent);
  }

  @override
  Future<void> filterFriends(String text) async {
    /*final Map<String, FriendSearchModel> filteredFriends = Map.fromEntries(
        friends.entries
            .where((entry) => entry.value.user.username.toLowerCase().contains(text.toLowerCase()))
            .map((entry) => MapEntry(entry.key, FriendSearchModel(entry.value)))
            .whereType<MapEntry<String, FriendSearchModel>>());*/
    this.filteredFriends.clear();
    final Map<String, FriendModel> filteredFriends = Map.fromEntries(
        friends.entries.where((entry) => entry.value.user.username
            .toLowerCase()
            .contains(text.toLowerCase())));
    this.filteredFriends.addAll(filteredFriends);
    friendsFilterController.add(filteredFriends);
  }

  @override
  Future<void> filterRequests(String text) async {
    this.filteredRequests.clear();
    final Map<String, FriendModel> filteredRequests = Map.fromEntries(
        requests.entries.where((entry) => entry.value.user.username
            .toLowerCase()
            .contains(text.toLowerCase())));
    this.filteredRequests.addAll(filteredRequests);
    requestsFilterController.add(filteredRequests);
  }

  @override
  Future<void> filterSentRequests(String text) async {
    this.filteredSentRequests.clear();
    final Map<String, FriendModel> filteredSentRequests = Map.fromEntries(
        sentRequests.entries.where((entry) => entry.value.user.username
            .toLowerCase()
            .contains(text.toLowerCase())));
    this.filteredSentRequests.addAll(filteredSentRequests);
    sentRequestsFilterController.add(filteredSentRequests);
  }

  @override
  Future<Map<String, dynamic>> getUser(String userId) async {
    final String data = await userClient.fetchProfile(userId);
    final Map<String, dynamic> jsonObject = json.decode(data);
    return jsonObject;
  }

  @override
  Future<FriendModel> sendRequest(UserModel userModel) async {
    final String data = await userClient.sendRequest(userModel.objectId);
    final Map<String, dynamic> jsonObject = json.decode(data);
    final String friendId = jsonObject['friendRequestId'];
    final FriendModel friendModel = FriendModel(objectId: friendId, user: userModel);
    search.remove(friendModel.user.objectId);
    searchController.add(search);
    sentRequests.putIfAbsent(friendModel.user.objectId, () => friendModel);
    sentRequestsController.add(sentRequests);
    filteredSentRequests.putIfAbsent(friendModel.user.objectId, () => friendModel);
    sentRequestsFilterController.add(filteredSentRequests);
    return friendModel;
  }

  @override
  Future<void> cancelRequest(FriendModel friendModel) async {
    await userClient.cancelRequest(friendModel.objectId);
    sentRequests.remove(friendModel.user.objectId);
    sentRequestsController.add(sentRequests);
    filteredSentRequests.remove(friendModel.user.objectId);
    sentRequestsFilterController.add(filteredSentRequests);
    search.putIfAbsent(friendModel.user.objectId, () => friendModel.user);
    searchController.add(search);
  }

  @override
  Future<void> acceptRequest(FriendModel friendModel) async {
    await userClient.acceptRequest(friendModel.objectId);
    requests.remove(friendModel.user.objectId);
    requestsController.add(requests);
    friends.putIfAbsent(friendModel.user.objectId, () => friendModel);
    friendsController.add(friends);
    filteredRequests.remove(friendModel.user.objectId);
    requestsFilterController.add(filteredRequests);
    filteredFriends.putIfAbsent(friendModel.user.objectId, () => friendModel);
    friendsFilterController.add(filteredFriends);
  }

  @override
  Future<void> rejectRequest(FriendModel friendModel) async {
    await userClient.rejectRequest(friendModel.objectId);
    requests.remove(friendModel.user.objectId);
    requestsController.add(requests);
    filteredRequests.remove(friendModel.user.objectId);
    requestsFilterController.add(filteredRequests);
    search.putIfAbsent(friendModel.user.objectId, () => friendModel.user);
    searchController.add(search);
  }

  @override
  Future<void> unfriendUser(FriendModel friendModel) async {
    await userClient.unfriendUser(friendModel.objectId);
    friends.remove(friendModel.user.objectId);
    friendsController.add(friends);
    filteredFriends.remove(friendModel.user.objectId);
    friendsFilterController.add(filteredFriends);
    search.putIfAbsent(friendModel.user.objectId, () => friendModel.user);
    searchController.add(search);
  }

  @override
  Future<void> insertRecent(UserModel userModel) async {
    recent.putIfAbsent(userModel.objectId, () => userModel);
    recentController.add(recent);
  }

  @override
  Future<void> removeRecent(UserModel userModel) async {
    recent.remove(userModel.objectId);
    recentController.add(recent);
  }
}