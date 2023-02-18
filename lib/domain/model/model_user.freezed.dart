// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get objectId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get proPicUri => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get friendState => throw _privateConstructorUsedError;
  String get requestId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String objectId,
      String createdAt,
      String username,
      String proPicUri,
      String bio,
      String friendState,
      String requestId});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? username = null,
    Object? proPicUri = null,
    Object? bio = null,
    Object? friendState = null,
    Object? requestId = null,
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
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      proPicUri: null == proPicUri
          ? _value.proPicUri
          : proPicUri // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      friendState: null == friendState
          ? _value.friendState
          : friendState // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String objectId,
      String createdAt,
      String username,
      String proPicUri,
      String bio,
      String friendState,
      String requestId});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? username = null,
    Object? proPicUri = null,
    Object? bio = null,
    Object? friendState = null,
    Object? requestId = null,
  }) {
    return _then(_$_UserModel(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      proPicUri: null == proPicUri
          ? _value.proPicUri
          : proPicUri // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      friendState: null == friendState
          ? _value.friendState
          : friendState // ignore: cast_nullable_to_non_nullable
              as String,
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel with DiagnosticableTreeMixin implements _UserModel {
  const _$_UserModel(
      {required this.objectId,
      required this.createdAt,
      required this.username,
      required this.proPicUri,
      required this.bio,
      required this.friendState,
      required this.requestId});

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String objectId;
  @override
  final String createdAt;
  @override
  final String username;
  @override
  final String proPicUri;
  @override
  final String bio;
  @override
  final String friendState;
  @override
  final String requestId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserModel(objectId: $objectId, createdAt: $createdAt, username: $username, proPicUri: $proPicUri, bio: $bio, friendState: $friendState, requestId: $requestId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserModel'))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('proPicUri', proPicUri))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('friendState', friendState))
      ..add(DiagnosticsProperty('requestId', requestId));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.proPicUri, proPicUri) ||
                other.proPicUri == proPicUri) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.friendState, friendState) ||
                other.friendState == friendState) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, createdAt, username,
      proPicUri, bio, friendState, requestId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String objectId,
      required final String createdAt,
      required final String username,
      required final String proPicUri,
      required final String bio,
      required final String friendState,
      required final String requestId}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get objectId;
  @override
  String get createdAt;
  @override
  String get username;
  @override
  String get proPicUri;
  @override
  String get bio;
  @override
  String get friendState;
  @override
  String get requestId;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
