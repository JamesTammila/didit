import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_user.freezed.dart';

part 'model_user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String objectId,
    required String createdAt,
    required String username,
    required String proPicUri,
    required String bio,
    required String friendRequestId,
    required String friendState,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}