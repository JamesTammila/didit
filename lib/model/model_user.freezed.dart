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
  String get name => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'proPic', nullable: true)
  Map<String, String>? get proPic => throw _privateConstructorUsedError;

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
      String name,
      String bio,
      @JsonKey(name: 'proPic', nullable: true) Map<String, String>? proPic});
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
    Object? name = null,
    Object? bio = null,
    Object? proPic = freezed,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      proPic: freezed == proPic
          ? _value.proPic
          : proPic // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
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
      String name,
      String bio,
      @JsonKey(name: 'proPic', nullable: true) Map<String, String>? proPic});
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
    Object? name = null,
    Object? bio = null,
    Object? proPic = freezed,
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
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      proPic: freezed == proPic
          ? _value._proPic
          : proPic // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserModel extends _UserModel with DiagnosticableTreeMixin {
  const _$_UserModel(
      {required this.objectId,
      required this.createdAt,
      required this.username,
      required this.name,
      required this.bio,
      @JsonKey(name: 'proPic', nullable: true)
          final Map<String, String>? proPic})
      : _proPic = proPic,
        super._();

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String objectId;
  @override
  final String createdAt;
  @override
  final String username;
  @override
  final String name;
  @override
  final String bio;
  final Map<String, String>? _proPic;
  @override
  @JsonKey(name: 'proPic', nullable: true)
  Map<String, String>? get proPic {
    final value = _proPic;
    if (value == null) return null;
    if (_proPic is EqualUnmodifiableMapView) return _proPic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserModel(objectId: $objectId, createdAt: $createdAt, username: $username, name: $name, bio: $bio, proPic: $proPic)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserModel'))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('username', username))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('proPic', proPic));
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
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other._proPic, _proPic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, createdAt, username,
      name, bio, const DeepCollectionEquality().hash(_proPic));

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

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String objectId,
      required final String createdAt,
      required final String username,
      required final String name,
      required final String bio,
      @JsonKey(name: 'proPic', nullable: true)
          final Map<String, String>? proPic}) = _$_UserModel;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String get objectId;
  @override
  String get createdAt;
  @override
  String get username;
  @override
  String get name;
  @override
  String get bio;
  @override
  @JsonKey(name: 'proPic', nullable: true)
  Map<String, String>? get proPic;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
