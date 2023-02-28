import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IHomeClient {
  Future<String> fetchMatch();
  Future<String> fetchPosts();
  Future<String> sendRequest(String userId);
  Future<void> cancelRequest(String friendId);
  Future<void> acceptRequest(String friendId);
  Future<void> rejectRequest(String friendId);
  Future<void> unfriendUser(String friendId);
  Future<void> reportUser(String userId);
  Future<void> blockUser(String userId);
  Future<void> unblockUser(String userId);
  Future<void> likePost(String postId);
  Future<void> reportPost(String postId);
  Future<void> uploadPost(File file);
}

class HomeClient implements IHomeClient {
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
  Future<String> sendRequest(String userId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
      'userId': userId,
      'action': 'REQUEST'
    });
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
  Future<void> cancelRequest(String friendId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
      "friendRequestId": friendId,
      "action": "REMOVE"
    });
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
  Future<void> acceptRequest(String friendId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
      "friendRequestId": friendId,
      "action": "ACCEPT"
    });
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
  Future<void> rejectRequest(String friendId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
      "friendRequestId": friendId,
      "action": "REJECT"
    });
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
  Future<void> unfriendUser(String friendId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
      "friendRequestId": friendId,
      "action": "REMOVE"
    });
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
  Future<void> reportUser(String userId) async {
    // TODO: implement reportUser
    throw UnimplementedError();
  }

  @override
  Future<void> blockUser(String userId) async {
    // TODO: implement blockUser
    throw UnimplementedError();
  }

  @override
  Future<void> unblockUser(String userId) async {
    // TODO: implement unblockUser
    throw UnimplementedError();
  }

  @override
  Future<void> likePost(String matchId) {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<void> reportPost(String postId) {
    // TODO: implement reportPost
    throw UnimplementedError();
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