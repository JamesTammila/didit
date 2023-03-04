// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MediaModel _$$_MediaModelFromJson(Map<String, dynamic> json) =>
    _$_MediaModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      media: (json['media'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MediaModelToJson(_$_MediaModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'media': instance.media,
      'user': instance.user,
    };
