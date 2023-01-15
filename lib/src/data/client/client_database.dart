import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IDatabaseClient {
  Future<String> fetchPosts();
  Future<String> fetchFriends();
  Future<String> fetchFriendSuggestions();
  Future<String> fetchFriendRequests();
  Future<String> fetchSentFriendRequests();
  Future<String> fetchUser(String userId);
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
  Future<String> fetchFriendRequests() {
    // TODO: implement fetchFriendRequests
    throw UnimplementedError();
  }

  @override
  Future<String> fetchFriendSuggestions() {
    // TODO: implement fetchFriendSuggestions
    throw UnimplementedError();
  }

  @override
  Future<String> fetchSentFriendRequests() {
    // TODO: implement fetchSentFriendRequests
    throw UnimplementedError();
  }
}