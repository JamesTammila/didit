import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IDatabaseClient {
  Future<String> fetchPosts();
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<void> sendRequest(String userId);
  Future<void> cancelRequest(String userId);
  Future<void> acceptRequest(String userId);
  Future<void> rejectRequest(String userId);
  Future<void> unfriendUser(String userId);
  Future<void> reportUser(String userId);
  Future<void> blockUser(String userId);
  Future<void> editProfile();
  Future<void> post();
}

class DatabaseClient implements IDatabaseClient {
  @override
  Future<String> fetchPosts() async {
    final response = await ParseCloudFunction("getPosts")
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
  Future<void> sendRequest(String userId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> cancelRequest(String userId) {
    // TODO: implement cancelFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> acceptRequest(String userId) {
    // TODO: implement acceptFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> rejectRequest(String userId) {
    // TODO: implement rejectFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> unfriendUser(String userId) {
    // TODO: implement unfriendUser
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
  Future<void> editProfile() {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<void> post() {
    // TODO: implement post
    throw UnimplementedError();
  }
}