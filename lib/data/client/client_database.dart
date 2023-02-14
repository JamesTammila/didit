import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IDatabaseClient {
  Future<String> fetchMatch();
  Future<String> fetchMatches();
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<String> fetchSearch(String text);
  Future<void> sendRequest(String requestId);
  Future<void> cancelRequest(String requestId);
  Future<void> acceptRequest(String requestId);
  Future<void> rejectRequest(String requestId);
  Future<void> reportUser(String userId);
  Future<void> blockUser(String userId);
  Future<void> unblockUser(String userId);
  Future<void> unfriendUser(String userId);
  Future<void> saveProfile(Map<String, dynamic> data);
  Future<void> uploadPost(File file);
}

class DatabaseClient implements IDatabaseClient {
  @override
  Future<String> fetchMatch() async {
    final response = await ParseCloudFunction("getMatch")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchMatches() async {
    final response = await ParseCloudFunction("getMatches")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchFriends() async {
    final response = await ParseCloudFunction("getFriends")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchSuggestions() async {
    final response = await ParseCloudFunction("getFriendSuggestions")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchRequests() async {
    final response = await ParseCloudFunction("getFriendRequests")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchSentRequests() async {
    final response = await ParseCloudFunction("getSentFriendRequests")
        .executeObjectFunction<ParseObject>();
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
    return response.results.toString();
  }

  @override
  Future<String> fetchSearch(String text) {
    // TODO: implement fetchSearch
    throw UnimplementedError();
  }

  @override
  Future<void> sendRequest(String requestId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> cancelRequest(String requestId) {
    // TODO: implement cancelFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> acceptRequest(String requestId) {
    // TODO: implement acceptFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> rejectRequest(String requestId) {
    // TODO: implement rejectFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> reportUser(String userId) {
    // TODO: implement reportUser
    throw UnimplementedError();
  }

  @override
  Future<void> blockUser(String userId) {
    // TODO: implement blockUser
    throw UnimplementedError();
  }

  @override
  Future<void> unblockUser(String userId) {
    // TODO: implement unblockUser
    throw UnimplementedError();
  }

  @override
  Future<void> unfriendUser(String userId) {
    // TODO: implement unfriendUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveProfile(Map<String, dynamic> data) async {
    final user = await ParseUser.currentUser()
        .timeout(const Duration(seconds: 1));
    if (user == null) throw "User Null";
    ParseFile parseFile = ParseFile(data['file']);
    final firstResponse = await parseFile.save();
    if (firstResponse.error != null) {
      switch (firstResponse.error?.code) {
        case ParseError.timeout: throw "Server Connection Timed Out";
        case ParseError.internalServerError: throw "Server Down";
        case ParseError.connectionFailed: throw "Server Connection Failed";
        case ParseError.validationError: throw "Server Validation Failed";
        case ParseError.invalidSessionToken: throw "Invalid User Session";
        case ParseError.sessionMissing: throw "Missing User Session";
        default: throw "Response Failed";
      }
    }
    user.set('proPic', parseFile);
    user.set('name', data['name']);
    user.set('bio', data['bio']);
    final secondResponse = await user.save();
    if (secondResponse.error != null) {
      switch (secondResponse.error?.code) {
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
  Future<void> uploadPost(File file) async {
    ParseFile parseFile = ParseFile(file);
    final firstResponse = await parseFile.save();
    if (firstResponse.error != null) {
      switch (firstResponse.error?.code) {
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
}