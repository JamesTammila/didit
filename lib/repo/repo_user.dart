import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_user.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/util/mock_database.dart';

abstract class IUserRepository {
  //Future<void> getSuggestions();
  Future<void> getFriends();
  Future<void> getRequests();
  Future<void> getSentRequests();
  Future<void> getSearch(String text);
  Future<void> getRecent();
  Future<Map<String, dynamic>> getUser(String userId);
  Future<FriendModel> sendRequest(UserModel userModel);
  Future<void> cancelRequest(FriendModel friendModel);
  Future<void> acceptRequest(FriendModel friendModel);
  Future<void> rejectRequest(FriendModel friendModel);
  Future<void> unfriendUser(FriendModel friendModel);
  Future<void> insertFriend(FriendModel friendModel);
  Future<void> insertRequest(FriendModel friendModel);
  Future<void> insertSentRequest(FriendModel friendModel);
  Future<void> insertRecent(UserModel userModel);
  Future<void> removeFriend(FriendModel friendModel);
  Future<void> removeRequest(FriendModel friendModel);
  Future<void> removeSentRequest(FriendModel friendModel);
  Future<void> removeRecent(UserModel userModel);
}

class UserRepository implements IUserRepository {
  final UserClient userClient = UserClient();
  //final Map<String, UserModel> suggestions = {};
  final Map<String, FriendModel> friends = {};
  final Map<String, FriendModel> requests = {};
  final Map<String, FriendModel> sentRequests = {};
  final Map<String, UserModel> search = {};
  final Map<String, UserModel> recentSearch = {};

  //final BehaviorSubject<Map<String, UserModel>> suggestionsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, FriendModel>> friendsSubject = BehaviorSubject<Map<String, FriendModel>>();
  final BehaviorSubject<Map<String, FriendModel>> requestsSubject = BehaviorSubject<Map<String, FriendModel>>();
  final BehaviorSubject<Map<String, FriendModel>> sentRequestsSubject = BehaviorSubject<Map<String, FriendModel>>();
  final BehaviorSubject<Map<String, UserModel>> searchSubject = BehaviorSubject<Map<String, UserModel>>();

  //Stream<Map<String, UserModel>> get suggestionsStream => suggestionsSubject.stream;
  Stream<Map<String, FriendModel>> get friendsStream => friendsSubject.stream;
  Stream<Map<String, FriendModel>> get requestsStream => requestsSubject.stream;
  Stream<Map<String, FriendModel>> get sentRequestsStream => sentRequestsSubject.stream;
  Stream<Map<String, UserModel>> get searchStream => searchSubject.stream;

  /*@override
  Future<void> getSuggestions() async {
    suggestions.clear();
    final String data = await userClient.fetchSuggestions();
    final List<dynamic> jsonObjects = json.decode(data);
    for (final jsonObject in jsonObjects) {
      final UserModel suggestion = UserModel.fromJson(jsonObject);
      suggestions.putIfAbsent(suggestion.objectId, () => suggestion);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> suggestions = mockSuggestions;
    this.suggestions.addAll(suggestions);
    suggestionsSubject.add(this.suggestions);
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
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, FriendModel> friends = mockFriends;
    //this.friends.addAll(friends);
    friendsSubject.add(friends);
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
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, FriendModel> requests = mockRequests;
    //this.requests.addAll(requests);
    requestsSubject.add(requests);
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
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, FriendModel> sentRequests = mockSentRequests;
    //this.sentRequests.addAll(sentRequests);
    sentRequestsSubject.add(sentRequests);
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
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> search = mockSearch;
    searchSubject.add(search);
  }

  @override
  Future<void> getRecent() async => searchSubject.add(recentSearch);

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
    sentRequests.putIfAbsent(friendModel.user.objectId, () => friendModel);
    sentRequestsSubject.add(sentRequests);
    return friendModel;
  }

  @override
  Future<void> cancelRequest(FriendModel friendModel) async {
    await userClient.cancelRequest(friendModel.objectId);
    sentRequests.remove(friendModel.user.objectId);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> acceptRequest(FriendModel friendModel) async {
    await userClient.acceptRequest(friendModel.objectId);
    requests.remove(friendModel.user.objectId);
    requestsSubject.add(requests);
    friends.putIfAbsent(friendModel.user.objectId, () => friendModel);
    friendsSubject.add(friends);
  }

  @override
  Future<void> rejectRequest(FriendModel friendModel) async {
    await userClient.rejectRequest(friendModel.objectId);
    requests.remove(friendModel.user.objectId);
    requestsSubject.add(requests);
  }

  @override
  Future<void> unfriendUser(FriendModel friendModel) async {
    await userClient.unfriendUser(friendModel.objectId);
    friends.remove(friendModel.user.objectId);
    friendsSubject.add(friends);
  }

  @override
  Future<void> insertFriend(FriendModel friendModel) async {
    friends.putIfAbsent(friendModel.user.objectId, () => friendModel);
    friendsSubject.add(friends);
  }

  @override
  Future<void> insertRequest(FriendModel friendModel) async {
    requests.putIfAbsent(friendModel.user.objectId, () => friendModel);
    requestsSubject.add(requests);
  }

  @override
  Future<void> insertSentRequest(FriendModel friendModel) async {
    sentRequests.putIfAbsent(friendModel.user.objectId, () => friendModel);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> insertRecent(UserModel userModel) async {
    recentSearch.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> removeFriend(FriendModel friendModel) async {
    friends.remove(friendModel.user.objectId);
    friendsSubject.add(friends);
  }

  @override
  Future<void> removeRequest(FriendModel friendModel) async {
    requests.remove(friendModel.user.objectId);
    requestsSubject.add(requests);
  }

  @override
  Future<void> removeSentRequest(FriendModel friendModel) async {
    sentRequests.remove(friendModel.user.objectId);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> removeRecent(UserModel userModel) async {
    recentSearch.remove(userModel.objectId);
    searchSubject.add(recentSearch);
  }
}