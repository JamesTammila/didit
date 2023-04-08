import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/model/model_user.dart';

part 'model_friend.freezed.dart';

part 'model_friend.g.dart';

@freezed
class FriendModel with _$FriendModel {
  const FriendModel._();

  const factory FriendModel({
    required String objectId,
    required UserModel user,
  }) = _FriendModel;

  factory FriendModel.fromJson(Map<String, Object?> json) =>
      _$FriendModelFromJson(json);
}