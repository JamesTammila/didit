// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MediaModel _$MediaModelFromJson(Map<String, dynamic> json) {
  return _MediaModel.fromJson(json);
}

/// @nodoc
mixin _$MediaModel {
  String get objectId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get mediaUri => throw _privateConstructorUsedError;
  FriendModel get friend => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MediaModelCopyWith<MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaModelCopyWith<$Res> {
  factory $MediaModelCopyWith(
          MediaModel value, $Res Function(MediaModel) then) =
      _$MediaModelCopyWithImpl<$Res, MediaModel>;
  @useResult
  $Res call(
      {String objectId, String createdAt, String mediaUri, FriendModel friend});

  $FriendModelCopyWith<$Res> get friend;
}

/// @nodoc
class _$MediaModelCopyWithImpl<$Res, $Val extends MediaModel>
    implements $MediaModelCopyWith<$Res> {
  _$MediaModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? mediaUri = null,
    Object? friend = null,
  }) {
    return _then(_value.copyWith(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUri: null == mediaUri
          ? _value.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as String,
      friend: null == friend
          ? _value.friend
          : friend // ignore: cast_nullable_to_non_nullable
              as FriendModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FriendModelCopyWith<$Res> get friend {
    return $FriendModelCopyWith<$Res>(_value.friend, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MediaModelCopyWith<$Res>
    implements $MediaModelCopyWith<$Res> {
  factory _$$_MediaModelCopyWith(
          _$_MediaModel value, $Res Function(_$_MediaModel) then) =
      __$$_MediaModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String objectId, String createdAt, String mediaUri, FriendModel friend});

  @override
  $FriendModelCopyWith<$Res> get friend;
}

/// @nodoc
class __$$_MediaModelCopyWithImpl<$Res>
    extends _$MediaModelCopyWithImpl<$Res, _$_MediaModel>
    implements _$$_MediaModelCopyWith<$Res> {
  __$$_MediaModelCopyWithImpl(
      _$_MediaModel _value, $Res Function(_$_MediaModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? mediaUri = null,
    Object? friend = null,
  }) {
    return _then(_$_MediaModel(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      mediaUri: null == mediaUri
          ? _value.mediaUri
          : mediaUri // ignore: cast_nullable_to_non_nullable
              as String,
      friend: null == friend
          ? _value.friend
          : friend // ignore: cast_nullable_to_non_nullable
              as FriendModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaModel with DiagnosticableTreeMixin implements _MediaModel {
  const _$_MediaModel(
      {required this.objectId,
      required this.createdAt,
      required this.mediaUri,
      required this.friend});

  factory _$_MediaModel.fromJson(Map<String, dynamic> json) =>
      _$$_MediaModelFromJson(json);

  @override
  final String objectId;
  @override
  final String createdAt;
  @override
  final String mediaUri;
  @override
  final FriendModel friend;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MediaModel(objectId: $objectId, createdAt: $createdAt, mediaUri: $mediaUri, friend: $friend)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MediaModel'))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('mediaUri', mediaUri))
      ..add(DiagnosticsProperty('friend', friend));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaModel &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.mediaUri, mediaUri) ||
                other.mediaUri == mediaUri) &&
            (identical(other.friend, friend) || other.friend == friend));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, objectId, createdAt, mediaUri, friend);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MediaModelCopyWith<_$_MediaModel> get copyWith =>
      __$$_MediaModelCopyWithImpl<_$_MediaModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MediaModelToJson(
      this,
    );
  }
}

abstract class _MediaModel implements MediaModel {
  const factory _MediaModel(
      {required final String objectId,
      required final String createdAt,
      required final String mediaUri,
      required final FriendModel friend}) = _$_MediaModel;

  factory _MediaModel.fromJson(Map<String, dynamic> json) =
      _$_MediaModel.fromJson;

  @override
  String get objectId;
  @override
  String get createdAt;
  @override
  String get mediaUri;
  @override
  FriendModel get friend;
  @override
  @JsonKey(ignore: true)
  _$$_MediaModelCopyWith<_$_MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
