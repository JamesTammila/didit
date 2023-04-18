import 'dart:async';

import 'package:didit/client/client_account.dart';

abstract class IAccountRepository {
  Future<Map<String, dynamic>> getProfile();
  Future<void> getCurrentUser();
  Future<void> saveProfile(Map<String, dynamic> data);
  Future<void> saveMatching(bool isMatching);
}

class AccountRepository implements IAccountRepository {
  final AccountClient accountClient = AccountClient();

  final StreamController<Map<String, dynamic>> currentUserController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get currentUserStream => currentUserController.stream;

  @override
  Future<Map<String, dynamic>> getProfile() async {
    final Map<String, dynamic> data = await accountClient.fetchProfile();
    return data;
  }

  @override
  Future<void> getCurrentUser() async {
    final Map<String, dynamic> data = await accountClient.fetchProfile();
    currentUserController.add(data);
  }

  @override
  Future<void> saveProfile(Map<String, dynamic> data) async {
    await accountClient.saveProfile(data);
    final Map<String, dynamic> updatedData = await accountClient.fetchProfile();
    currentUserController.add(updatedData);
  }

  @override
  Future<void> saveMatching(bool isMatching) async {
    await accountClient.saveMatching(isMatching);
  }
}