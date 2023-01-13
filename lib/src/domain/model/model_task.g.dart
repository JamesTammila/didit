// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskModel _$$_TaskModelFromJson(Map<String, dynamic> json) => _$_TaskModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      message: json['message'] as String,
      sender: UserModel.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: UserModel.fromJson(json['receiver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TaskModelToJson(_$_TaskModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'message': instance.message,
      'sender': instance.sender,
      'receiver': instance.receiver,
    };
