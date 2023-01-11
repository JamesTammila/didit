import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_post.freezed.dart';

part 'model_post.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String objectId,
    required String createdAt,
    required String mediaUri,
    required String caption,
    required String ownerUserId,
    required String ownerUsername,
    required String ownerPicUri,
    required String senderUserId,
    required String senderUsername,
    required String senderPicUri,
    required String senderMessage,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);
}