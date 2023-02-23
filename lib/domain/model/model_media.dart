import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/domain/model/model_friend.dart';

part 'model_media.freezed.dart';

part 'model_media.g.dart';

@freezed
class MediaModel with _$MediaModel {
  const factory MediaModel({
    required String objectId,
    required String createdAt,
    required String mediaUri,
    required FriendModel friend,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, Object?> json) =>
      _$MediaModelFromJson(json);
}