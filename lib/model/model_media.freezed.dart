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
  @JsonKey(name: 'media', nullable: true)
  Map<String, String>? get media => throw _privateConstructorUsedError;
  UserModel get user => throw _privateConstructorUsedError;

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
      {String objectId,
      String createdAt,
      @JsonKey(name: 'media', nullable: true) Map<String, String>? media,
      UserModel user});

  $UserModelCopyWith<$Res> get user;
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
    Object? media = freezed,
    Object? user = null,
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
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res> get user {
    return $UserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
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
      {String objectId,
      String createdAt,
      @JsonKey(name: 'media', nullable: true) Map<String, String>? media,
      UserModel user});

  @override
  $UserModelCopyWith<$Res> get user;
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
    Object? media = freezed,
    Object? user = null,
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
      media: freezed == media
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MediaModel extends _MediaModel with DiagnosticableTreeMixin {
  const _$_MediaModel(
      {required this.objectId,
      required this.createdAt,
      @JsonKey(name: 'media', nullable: true) final Map<String, String>? media,
      required this.user})
      : _media = media,
        super._();

  factory _$_MediaModel.fromJson(Map<String, dynamic> json) =>
      _$$_MediaModelFromJson(json);

  @override
  final String objectId;
  @override
  final String createdAt;
  final Map<String, String>? _media;
  @override
  @JsonKey(name: 'media', nullable: true)
  Map<String, String>? get media {
    final value = _media;
    if (value == null) return null;
    if (_media is EqualUnmodifiableMapView) return _media;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final UserModel user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MediaModel(objectId: $objectId, createdAt: $createdAt, media: $media, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MediaModel'))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('media', media))
      ..add(DiagnosticsProperty('user', user));
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
            const DeepCollectionEquality().equals(other._media, _media) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, createdAt,
      const DeepCollectionEquality().hash(_media), user);

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

abstract class _MediaModel extends MediaModel {
  const factory _MediaModel(
      {required final String objectId,
      required final String createdAt,
      @JsonKey(name: 'media', nullable: true) final Map<String, String>? media,
      required final UserModel user}) = _$_MediaModel;
  const _MediaModel._() : super._();

  factory _MediaModel.fromJson(Map<String, dynamic> json) =
      _$_MediaModel.fromJson;

  @override
  String get objectId;
  @override
  String get createdAt;
  @override
  @JsonKey(name: 'media', nullable: true)
  Map<String, String>? get media;
  @override
  UserModel get user;
  @override
  @JsonKey(ignore: true)
  _$$_MediaModelCopyWith<_$_MediaModel> get copyWith =>
      throw _privateConstructorUsedError;
}
