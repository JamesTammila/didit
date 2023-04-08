// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FriendModel _$$_FriendModelFromJson(Map<String, dynamic> json) =>
    _$_FriendModel(
      objectId: json['objectId'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FriendModelToJson(_$_FriendModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'user': instance.user,
    };
