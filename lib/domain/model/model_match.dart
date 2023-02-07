import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/domain/model/model_post.dart';

part 'model_match.freezed.dart';

part 'model_match.g.dart';

@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String objectId,
    required String createdAt,
    required String theme,
    required List<PostModel> posts,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, Object?> json) =>
      _$MatchModelFromJson(json);
}