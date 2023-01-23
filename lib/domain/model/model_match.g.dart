// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MatchModel _$$_MatchModelFromJson(Map<String, dynamic> json) =>
    _$_MatchModel(
      objectId: json['objectId'] as String,
      createdAt: json['createdAt'] as String,
      theme: json['theme'] as String,
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MatchModelToJson(_$_MatchModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'createdAt': instance.createdAt,
      'theme': instance.theme,
      'posts': instance.posts,
    };
