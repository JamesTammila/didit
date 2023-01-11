// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      mediaUri: json['mediaUri'] as String,
      caption: json['caption'] as String,
      ownerUserId: json['ownerUserId'] as String,
      ownerUsername: json['ownerUsername'] as String,
      ownerPicUri: json['ownerPicUri'] as String,
      senderUserId: json['senderUserId'] as String,
      senderUsername: json['senderUsername'] as String,
      senderPicUri: json['senderPicUri'] as String,
      senderMessage: json['senderMessage'] as String,
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'mediaUri': instance.mediaUri,
      'caption': instance.caption,
      'ownerUserId': instance.ownerUserId,
      'ownerUsername': instance.ownerUsername,
      'ownerPicUri': instance.ownerPicUri,
      'senderUserId': instance.senderUserId,
      'senderUsername': instance.senderUsername,
      'senderPicUri': instance.senderPicUri,
      'senderMessage': instance.senderMessage,
    };
