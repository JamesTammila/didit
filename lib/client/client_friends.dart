import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_plus/share_plus.dart';

abstract class IFriendsClient {
  Future<String> fetchFriends();
  Future<String> fetchSuggestions();
  Future<String> fetchRequests();
  Future<String> fetchSentRequests();
  Future<String> fetchSearch(String text);
  Future<void> shareLink();
}

class FriendsClient implements IFriendsClient {
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
    final response = await ParseCloudFunction("getFriends").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSuggestions() async {
    final response = await ParseCloudFunction("getSuggestions").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchRequests() async {
    final response = await ParseCloudFunction("getWaiting").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSentRequests() async {
    final response = await ParseCloudFunction("getPending").execute();
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<String> fetchSearch(String text) async {
    final response = await ParseCloudFunction("searchUsers").execute(
      parameters: {'searchInput': text},
    );
    checkError(response);
    return response.result.toString();
  }

  @override
  Future<void> shareLink() async {
    await Share.share('https://dewdrop.app/');
  }
}