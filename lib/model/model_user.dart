import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_user.freezed.dart';

part 'model_user.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String objectId,
    required String createdAt,
    required String username,
    required String name,
    required String bio,
    required int color,
    @JsonKey(name: 'proPic', nullable: true) Map<String, String>? proPic,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);

  String get getUrl => proPic?['url'] ?? '';
}