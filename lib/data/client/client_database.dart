import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IDatabaseClient {
  Future<String> fetchMatch();
  Future<String> fetchPosts();
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<String> fetchSearch(String text);
  Future<void> sendRequest(String requestId);
  Future<void> cancelRequest(String requestId);
  Future<void> acceptRequest(String requestId);
  Future<void> rejectRequest(String requestId);
  Future<void> unfriendUser(String requestId);
  Future<void> reportUser(String userId);
  Future<void> blockUser(String userId);
  Future<void> unblockUser(String userId);
  Future<void> likePost(String postId);
  Future<void> reportPost(String postId);
  Future<void> uploadPost(File file);
  Future<void> saveProfile(Map<String, dynamic> data);
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
  Future<String> fetchSearch(String text) async {
    final response = await ParseCloudFunction("getSearch")
        .executeObjectFunction<ParseObject>(parameters: {'text': text});
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
  Future<void> sendRequest(String requestId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
          "friendRequestId": requestId,
          "action": "REQUEST"
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
  Future<void> cancelRequest(String requestId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
          "friendRequestId": requestId,
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
  Future<void> acceptRequest(String requestId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
          "friendRequestId": requestId,
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
  Future<void> rejectRequest(String requestId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
          "friendRequestId": requestId,
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
  Future<void> unfriendUser(String requestId) async {
    final response = await ParseCloudFunction("friendRequestAction")
        .executeObjectFunction<ParseObject>(parameters: {
          "friendRequestId": requestId,
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
}