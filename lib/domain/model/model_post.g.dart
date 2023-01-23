// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      mediaUri: json['mediaUri'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'mediaUri': instance.mediaUri,
      'user': instance.user,
    };
