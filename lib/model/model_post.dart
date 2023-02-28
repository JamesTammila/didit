import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/model/model_media.dart';

part 'model_post.freezed.dart';

part 'model_post.g.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String objectId,
    required String createdAt,
    required String theme,
    required List<MediaModel> medias,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);
}