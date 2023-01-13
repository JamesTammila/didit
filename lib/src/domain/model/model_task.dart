import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:didit/src/domain/model/model_user.dart';

part 'model_task.freezed.dart';

part 'model_task.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String objectId,
    required String createdAt,
    required String message,
    required UserModel sender,
    required UserModel receiver,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, Object?> json) =>
      _$TaskModelFromJson(json);
}