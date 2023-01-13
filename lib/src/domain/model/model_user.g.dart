// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      username: json['username'] as String,
      proPicUri: json['proPicUri'] as String,
      friendState: json['friendState'] as String,
      requestId: json['requestId'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'username': instance.username,
      'proPicUri': instance.proPicUri,
      'friendState': instance.friendState,
      'requestId': instance.requestId,
    };
