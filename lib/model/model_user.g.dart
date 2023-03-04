// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      username: json['username'] as String,
      proPic: (json['proPic'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      bio: json['bio'] as String,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'username': instance.username,
      'proPic': instance.proPic,
      'bio': instance.bio,
    };
