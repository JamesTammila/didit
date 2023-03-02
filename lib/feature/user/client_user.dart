import 'package:flutter/cupertino.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class IUserClient {
  Future<String> fetchProfile(String userId);
  Future<String> sendRequest(String userId);
  Future<void> cancelRequest(String friendId);
  Future<void> acceptRequest(String friendId);
  Future<void> rejectRequest(String friendId);
  Future<void> unfriendUser(String friendId);
}

class UserClient implements IUserClient {
  @override
  Future<String> fetchProfile(String userId) async {
    final response = await ParseCloudFunction("getProfile")
        .executeObjectFunction<ParseObject>(parameters: {
      'userId': userId,
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
    debugPrint(response.results.toString());
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
    debugPrint(response.results.toString());
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
}