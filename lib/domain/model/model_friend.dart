import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/domain/model/model_user.dart';

part 'model_friend.freezed.dart';

part 'model_friend.g.dart';

@freezed
class FriendModel with _$FriendModel {
  const factory FriendModel({
    required String objectId,
    required String createdAt,
    required String state,
    required UserModel user,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, Object?> json) =>
      _$FriendModelFromJson(json);
}