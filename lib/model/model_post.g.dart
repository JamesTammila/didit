// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      caption: json['caption'] as String,
      isLiked: json['isLiked'] as bool,
      medias: (json['medias'] as List<dynamic>)
          .map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'caption': instance.caption,
      'isLiked': instance.isLiked,
      'medias': instance.medias,
    };
