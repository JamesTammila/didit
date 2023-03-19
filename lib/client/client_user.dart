import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:didit/client/error_parse.dart';

abstract class IUserClient {
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<String> fetchSearch(String text);
  Future<String> fetchLikes(String postId);
  Future<String> fetchProfile(String userId);
  Future<String> sendRequest(String userId);
  Future<void> cancelRequest(String friendId);
  Future<void> acceptRequest(String friendId);
  Future<void> rejectRequest(String friendId);
  Future<void> unfriendUser(String friendId);
}

class UserClient implements IUserClient {
  @override
  Future<String> fetchFriends() async {
    final ParseResponse response = await ParseCloudFunction('getFriends').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSuggestions() async {
    final ParseResponse response = await ParseCloudFunction('getSuggestions').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchRequests() async {
    final ParseResponse response = await ParseCloudFunction('getWaiting').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSentRequests() async {
    final ParseResponse response = await ParseCloudFunction('getPending').execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSearch(String text) async {
    final ParseResponse response = await ParseCloudFunction('searchUsers').execute(
      parameters: {'searchInput': text},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchLikes(String postId) async {
    final ParseResponse response = await ParseCloudFunction('getLikes').execute(
      parameters: {'postId': postId},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchProfile(String userId) async {
    final ParseResponse response = await ParseCloudFunction('getProfile').execute(
      parameters: {'userId': userId},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> sendRequest(String userId) async {
    final ParseResponse response = await ParseCloudFunction('friendRequestAction').execute(
      parameters: {'userId': userId, 'action': 'REQUEST'},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<void> cancelRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction('friendRequestAction').execute(
      parameters: {'friendRequestId': friendId, 'action': 'REMOVE'},
    );
    checkError(response);
  }

  @override
  Future<void> acceptRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction('friendRequestAction').execute(
      parameters: {'friendRequestId': friendId, 'action': 'ACCEPT'},
    );
    checkError(response);
  }

  @override
  Future<void> rejectRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction('friendRequestAction').execute(
      parameters: {'friendRequestId': friendId, 'action': 'REMOVE'},
    );
    checkError(response);
  }

  @override
  Future<void> unfriendUser(String friendId) async {
    final ParseResponse response = await ParseCloudFunction('friendRequestAction').execute(
      parameters: {'friendRequestId': friendId, 'action': 'REMOVE'},
    );
    checkError(response);
  }
}