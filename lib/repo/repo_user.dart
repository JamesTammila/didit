import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:didit/client/client_user.dart';
import 'package:didit/util/generator_color.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/util/mock_database.dart';

abstract class IUserRepository {
  //Future<void> getSuggestions();
  Future<void> getFriends();
  Future<void> getRequests();
  Future<void> getSentRequests();
  Future<Map<String, UserModel>> getSearch(String text);
  Future<Map<String, UserModel>> getRecent();
  Future<Map<String, dynamic>> getUser(UserModel userModel);
  Future<String> sendRequest(UserModel userModel);
  Future<void> cancelRequest(UserModel userModel, String friendId);
  Future<void> acceptRequest(UserModel userModel, String friendId);
  Future<void> rejectRequest(UserModel userModel, String friendId);
  Future<void> unfriendUser(UserModel userModel, String friendId);
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
  //final Map<String, UserModel> suggestions = {};
  final Map<String, UserModel> friends = {};
  final Map<String, UserModel> requests = {};
  final Map<String, UserModel> sentRequests = {};
  final Map<String, UserModel> recentSearch = {};

  //final BehaviorSubject<Map<String, UserModel>> suggestionsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> friendsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> requestsSubject = BehaviorSubject<Map<String, UserModel>>();
  final BehaviorSubject<Map<String, UserModel>> sentRequestsSubject = BehaviorSubject<Map<String, UserModel>>();

  //Stream<Map<String, UserModel>> get suggestionsStream => suggestionsSubject.stream;
  Stream<Map<String, UserModel>> get friendsStream => friendsSubject.stream;
  Stream<Map<String, UserModel>> get requestsStream => requestsSubject.stream;
  Stream<Map<String, UserModel>> get sentRequestsStream => sentRequestsSubject.stream;

  /*@override
  Future<void> getSuggestions() async {
    final String data = await userClient.fetchSuggestions();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel suggestion = UserModel.fromJson(jsonObject);
      final UserModel updatedSuggestion = suggestion.copyWith(color: generateColor());
      suggestions.putIfAbsent(updatedSuggestion.objectId, () => updatedSuggestion);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    final Map<String, UserModel> suggestions = mockSuggestions;
    this.suggestions.addAll(suggestions);
    suggestionsSubject.add(this.suggestions);
  }*/

  @override
  Future<void> getFriends() async {
    final String data = await userClient.fetchFriends();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel friend = UserModel.fromJson(jsonObject);
      final UserModel updatedFriend = friend.copyWith(color: generateColor());
      friends.putIfAbsent(updatedFriend.objectId, () => updatedFriend);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> friends = mockFriends;
    //this.friends.addAll(friends);
    friendsSubject.add(friends);
  }

  @override
  Future<void> getRequests() async {
    final String data = await userClient.fetchRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel request = UserModel.fromJson(jsonObject);
      final UserModel updatedRequest = request.copyWith(color: generateColor());
      requests.putIfAbsent(updatedRequest.objectId, () => updatedRequest);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> requests = mockRequests;
    //this.requests.addAll(requests);
    requestsSubject.add(requests);
  }

  @override
  Future<void> getSentRequests() async {
    sentRequests.clear();
    final String data = await userClient.fetchSentRequests();
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel sentRequest = UserModel.fromJson(jsonObject);
      final UserModel updatedSentRequest = sentRequest.copyWith(color: generateColor());
      sentRequests.putIfAbsent(updatedSentRequest.objectId, () => updatedSentRequest);
    }
    //await Future.delayed(const Duration(milliseconds: 500));
    //final Map<String, UserModel> sentRequests = mockSentRequests;
    //this.sentRequests.addAll(sentRequests);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<Map<String, UserModel>> getSearch(String text) async {
    final Map<String, UserModel> users = {};
    final String data = await userClient.fetchSearch(text.toLowerCase());
    final List<dynamic> jsonObjects = json.decode(data);
    for (var jsonObject in jsonObjects) {
      final UserModel user = UserModel.fromJson(jsonObject);
      final UserModel updatedUser = user.copyWith(color: generateColor());
      users.putIfAbsent(updatedUser.objectId, () => updatedUser);
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
  Future<Map<String, dynamic>> getUser(UserModel userModel) async {
    final String data = await userClient.fetchProfile(userModel.objectId);
    final Map<String, dynamic> jsonObject = json.decode(data);
    return jsonObject;
  }

  @override
  Future<String> sendRequest(UserModel userModel) async {
    final String data = await userClient.sendRequest(userModel.objectId);
    final Map<String, dynamic> jsonObject = json.decode(data);
    final String friendId = jsonObject['friendRequestId'];
    sentRequests.putIfAbsent(userModel.objectId, () => userModel);
    sentRequestsSubject.add(sentRequests);
    return friendId;
  }

  @override
  Future<void> cancelRequest(UserModel userModel, String friendId) async {
    await userClient.cancelRequest(friendId);
    sentRequests.remove(userModel.objectId);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> acceptRequest(UserModel userModel, String friendId) async {
    await userClient.acceptRequest(friendId);
    requests.remove(userModel.objectId);
    requestsSubject.add(requests);
    friends.putIfAbsent(userModel.objectId, () => userModel);
    friendsSubject.add(friends);
  }

  @override
  Future<void> rejectRequest(UserModel userModel, String friendId) async {
    await userClient.rejectRequest(friendId);
    requests.remove(userModel.objectId);
    requestsSubject.add(requests);
  }

  @override
  Future<void> unfriendUser(UserModel userModel, String friendId) async {
    await userClient.unfriendUser(friendId);
    friends.remove(userModel.objectId);
    friendsSubject.add(friends);
  }

  @override
  Future<void> insertFriend(UserModel userModel) async {
    friends.putIfAbsent(userModel.objectId, () => userModel);
    friendsSubject.add(friends);
  }

  @override
  Future<void> insertRequest(UserModel userModel) async {
    requests.putIfAbsent(userModel.objectId, () => userModel);
    requestsSubject.add(requests);
  }

  @override
  Future<void> insertSentRequest(UserModel userModel) async {
    sentRequests.putIfAbsent(userModel.objectId, () => userModel);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> insertRecent(UserModel userModel) async {
    recentSearch.putIfAbsent(userModel.objectId, () => userModel);
  }

  @override
  Future<void> removeFriend(UserModel userModel) async {
    friends.remove(userModel.objectId);
    friendsSubject.add(friends);
  }

  @override
  Future<void> removeRequest(UserModel userModel) async {
    requests.remove(userModel.objectId);
    requestsSubject.add(requests);
  }

  @override
  Future<void> removeSentRequest(UserModel userModel) async {
    sentRequests.remove(userModel.objectId);
    sentRequestsSubject.add(sentRequests);
  }

  @override
  Future<void> removeRecent(UserModel userModel) async {
    recentSearch.remove(userModel.objectId);
  }
}