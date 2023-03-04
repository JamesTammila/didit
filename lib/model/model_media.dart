import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/model/model_user.dart';

part 'model_media.freezed.dart';

part 'model_media.g.dart';

@freezed
class MediaModel with _$MediaModel {
  const MediaModel._();

  const factory MediaModel({
    required String objectId,
    required String createdAt,
    @JsonKey(name: 'media', nullable: true) Map<String, String>? media,
    required UserModel user,
  }) = _MediaModel;

  factory MediaModel.fromJson(Map<String, Object?> json) =>
      _$MediaModelFromJson(json);

  String get getUrl => media?['url'] ?? '';
}