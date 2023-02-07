// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) {
  return _MatchModel.fromJson(json);
}

/// @nodoc
mixin _$MatchModel {
  String get objectId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  List<PostModel> get posts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchModelCopyWith<MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) then) =
      _$MatchModelCopyWithImpl<$Res, MatchModel>;
  @useResult
  $Res call(
      {String objectId, String createdAt, String theme, List<PostModel> posts});
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? theme = null,
    Object? posts = null,
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
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MatchModelCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$$_MatchModelCopyWith(
          _$_MatchModel value, $Res Function(_$_MatchModel) then) =
      __$$_MatchModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String objectId, String createdAt, String theme, List<PostModel> posts});
}

/// @nodoc
class __$$_MatchModelCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$_MatchModel>
    implements _$$_MatchModelCopyWith<$Res> {
  __$$_MatchModelCopyWithImpl(
      _$_MatchModel _value, $Res Function(_$_MatchModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectId = null,
    Object? createdAt = null,
    Object? theme = null,
    Object? posts = null,
  }) {
    return _then(_$_MatchModel(
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MatchModel with DiagnosticableTreeMixin implements _MatchModel {
  const _$_MatchModel(
      {required this.objectId,
      required this.createdAt,
      required this.theme,
      required final List<PostModel> posts})
      : _posts = posts;

  factory _$_MatchModel.fromJson(Map<String, dynamic> json) =>
      _$$_MatchModelFromJson(json);

  @override
  final String objectId;
  @override
  final String createdAt;
  @override
  final String theme;
  final List<PostModel> _posts;
  @override
  List<PostModel> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MatchModel(objectId: $objectId, createdAt: $createdAt, theme: $theme, posts: $posts)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MatchModel'))
      ..add(DiagnosticsProperty('objectId', objectId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('theme', theme))
      ..add(DiagnosticsProperty('posts', posts));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MatchModel &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectId, createdAt, theme,
      const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MatchModelCopyWith<_$_MatchModel> get copyWith =>
      __$$_MatchModelCopyWithImpl<_$_MatchModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MatchModelToJson(
      this,
    );
  }
}

abstract class _MatchModel implements MatchModel {
  const factory _MatchModel(
      {required final String objectId,
      required final String createdAt,
      required final String theme,
      required final List<PostModel> posts}) = _$_MatchModel;

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$_MatchModel.fromJson;

  @override
  String get objectId;
  @override
  String get createdAt;
  @override
  String get theme;
  @override
  List<PostModel> get posts;
  @override
  @JsonKey(ignore: true)
  _$$_MatchModelCopyWith<_$_MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}
