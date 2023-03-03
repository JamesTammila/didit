import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IUserClient {
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<String> fetchSearch(String text);
  Future<String> fetchProfile(String userId);
  Future<String> sendRequest(String userId);
  Future<void> cancelRequest(String friendId);
  Future<void> acceptRequest(String friendId);
  Future<void> rejectRequest(String friendId);
  Future<void> unfriendUser(String friendId);
}

class UserClient implements IUserClient {
  checkError(ParseResponse response) {
    if (response.error != null) {
      switch (response.error?.code) {
        case ParseError.timeout: throw "Server Connection Timed Out";
        case ParseError.internalServerError: throw "Server Down";
        case ParseError.connectionFailed: throw "Server Connection Failed";
        case ParseError.validationError: throw "Server Validation Failed";
        case ParseError.invalidSessionToken: throw "Invalid User Session";
        case ParseError.sessionMissing: throw "Missing User Session";
        default: throw "Response Failed";
      }
    }
  }

  @override
  Future<String> fetchFriends() async {
    final ParseResponse response = await ParseCloudFunction("getFriends").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSuggestions() async {
    final ParseResponse response = await ParseCloudFunction("getSuggestions").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchRequests() async {
    final ParseResponse response = await ParseCloudFunction("getWaiting").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSentRequests() async {
    final ParseResponse response = await ParseCloudFunction("getPending").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSearch(String text) async {
    final ParseResponse response = await ParseCloudFunction("searchUsers").execute(
      parameters: {'searchInput': text},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchProfile(String userId) async {
    final ParseResponse response = await ParseCloudFunction("getProfile").execute(
      parameters: {'userId': userId},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> sendRequest(String userId) async {
    final ParseResponse response = await ParseCloudFunction("friendRequestAction").execute(
      parameters: {'userId': userId, 'action': 'REQUEST'},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<void> cancelRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction("friendRequestAction").execute(
      parameters: {"friendRequestId": friendId, "action": "REMOVE"},
    );
    checkError(response);
  }

  @override
  Future<void> acceptRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction("friendRequestAction").execute(
      parameters: {"friendRequestId": friendId, "action": "ACCEPT"},
    );
    checkError(response);
  }

  @override
  Future<void> rejectRequest(String friendId) async {
    final ParseResponse response = await ParseCloudFunction("friendRequestAction").execute(
      parameters: {"friendRequestId": friendId, "action": "REMOVE"},
    );
    checkError(response);
  }

  @override
  Future<void> unfriendUser(String friendId) async {
    final ParseResponse response = await ParseCloudFunction("friendRequestAction").execute(
      parameters: {"friendRequestId": friendId, "action": "REMOVE"},
    );
    checkError(response);
  }
}