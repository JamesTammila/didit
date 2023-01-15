import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IDatabaseClient {
  Future<String> fetchPosts();
  Future<String> fetchFriends();
  Future<String> fetchFriendSuggestions();
  Future<String> fetchFriendRequests();
  Future<String> fetchSentFriendRequests();
  Future<String> fetchUser(String userId);
  Future<void> sendFriendRequest(String userId);
  Future<void> cancelFriendRequest(String userId);
  Future<void> acceptFriendRequest(String userId);
  Future<void> rejectFriendRequest(String userId);
  Future<void> friendUser(String userId);
  Future<void> unfriendUser(String userId);
  Future<void> reportUser(String userId);
  Future<void> blockUser(String userId);
  Future<void> getTaskUser();
  Future<void> sendTask();
  Future<void> reportTask();
  Future<void> post();
  Future<void> editProfile();
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
  Future<String> fetchUser(String userId) async {
    final response = await ParseCloudFunction("getUser")
        .executeObjectFunction<ParseObject>(parameters: {"userId": userId});
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
  Future<String> fetchFriendRequests() async {
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
  Future<String> fetchFriendSuggestions() async {
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
  Future<String> fetchSentFriendRequests() async {
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
  Future<void> acceptFriendRequest(String userId) {
    // TODO: implement acceptFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> blockUser(String userId) {
    // TODO: implement blockUser
    throw UnimplementedError();
  }

  @override
  Future<void> cancelFriendRequest(String userId) {
    // TODO: implement cancelFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> editProfile() {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<void> friendUser(String userId) {
    // TODO: implement friendUser
    throw UnimplementedError();
  }

  @override
  Future<void> getTaskUser() {
    // TODO: implement getTaskUser
    throw UnimplementedError();
  }

  @override
  Future<void> post() {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<void> rejectFriendRequest(String userId) {
    // TODO: implement rejectFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> reportTask() {
    // TODO: implement reportTask
    throw UnimplementedError();
  }

  @override
  Future<void> reportUser(String userId) {
    // TODO: implement reportUser
    throw UnimplementedError();
  }

  @override
  Future<void> sendFriendRequest(String userId) {
    // TODO: implement sendFriendRequest
    throw UnimplementedError();
  }

  @override
  Future<void> sendTask() {
    // TODO: implement sendTask
    throw UnimplementedError();
  }

  @override
  Future<void> unfriendUser(String userId) {
    // TODO: implement unfriendUser
    throw UnimplementedError();
  }
}