// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TileStyle _$TileStyleFromJson(Map<String, dynamic> json) {
  return _TileStyle.fromJson(json);
}

/// @nodoc
mixin _$TileStyle {
  String get title => throw _privateConstructorUsedError;
  List<TileStyleGroup> get group => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileStyleCopyWith<TileStyle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileStyleCopyWith<$Res> {
  factory $TileStyleCopyWith(TileStyle value, $Res Function(TileStyle) then) =
      _$TileStyleCopyWithImpl<$Res, TileStyle>;
  @useResult
  $Res call({String title, List<TileStyleGroup> group});
}

/// @nodoc
class _$TileStyleCopyWithImpl<$Res, $Val extends TileStyle>
    implements $TileStyleCopyWith<$Res> {
  _$TileStyleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? group = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as List<TileStyleGroup>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileStyleImplCopyWith<$Res>
    implements $TileStyleCopyWith<$Res> {
  factory _$$TileStyleImplCopyWith(
          _$TileStyleImpl value, $Res Function(_$TileStyleImpl) then) =
      __$$TileStyleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<TileStyleGroup> group});
}

/// @nodoc
class __$$TileStyleImplCopyWithImpl<$Res>
    extends _$TileStyleCopyWithImpl<$Res, _$TileStyleImpl>
    implements _$$TileStyleImplCopyWith<$Res> {
  __$$TileStyleImplCopyWithImpl(
      _$TileStyleImpl _value, $Res Function(_$TileStyleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? group = null,
  }) {
    return _then(_$TileStyleImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value._group
          : group // ignore: cast_nullable_to_non_nullable
              as List<TileStyleGroup>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleImpl extends _TileStyle {
  const _$TileStyleImpl(
      {required this.title, required final List<TileStyleGroup> group})
      : _group = group,
        super._();

  factory _$TileStyleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleImplFromJson(json);

  @override
  final String title;
  final List<TileStyleGroup> _group;
  @override
  List<TileStyleGroup> get group {
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  @override
  String toString() {
    return 'TileStyle(title: $title, group: $group)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._group, _group));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_group));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleImplCopyWith<_$TileStyleImpl> get copyWith =>
      __$$TileStyleImplCopyWithImpl<_$TileStyleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleImplToJson(
      this,
    );
  }
}

abstract class _TileStyle extends TileStyle {
  const factory _TileStyle(
      {required final String title,
      required final List<TileStyleGroup> group}) = _$TileStyleImpl;
  const _TileStyle._() : super._();

  factory _TileStyle.fromJson(Map<String, dynamic> json) =
      _$TileStyleImpl.fromJson;

  @override
  String get title;
  @override
  List<TileStyleGroup> get group;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleImplCopyWith<_$TileStyleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TileStyleGroup _$TileStyleGroupFromJson(Map<String, dynamic> json) {
  return _TileStyleGroup.fromJson(json);
}

/// @nodoc
mixin _$TileStyleGroup {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileStyleGroupCopyWith<TileStyleGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileStyleGroupCopyWith<$Res> {
  factory $TileStyleGroupCopyWith(
          TileStyleGroup value, $Res Function(TileStyleGroup) then) =
      _$TileStyleGroupCopyWithImpl<$Res, TileStyleGroup>;
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class _$TileStyleGroupCopyWithImpl<$Res, $Val extends TileStyleGroup>
    implements $TileStyleGroupCopyWith<$Res> {
  _$TileStyleGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileStyleGroupImplCopyWith<$Res>
    implements $TileStyleGroupCopyWith<$Res> {
  factory _$$TileStyleGroupImplCopyWith(_$TileStyleGroupImpl value,
          $Res Function(_$TileStyleGroupImpl) then) =
      __$$TileStyleGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$TileStyleGroupImplCopyWithImpl<$Res>
    extends _$TileStyleGroupCopyWithImpl<$Res, _$TileStyleGroupImpl>
    implements _$$TileStyleGroupImplCopyWith<$Res> {
  __$$TileStyleGroupImplCopyWithImpl(
      _$TileStyleGroupImpl _value, $Res Function(_$TileStyleGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$TileStyleGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleGroupImpl extends _TileStyleGroup {
  const _$TileStyleGroupImpl({required this.id, required this.title})
      : super._();

  factory _$TileStyleGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'TileStyleGroup(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleGroupImplCopyWith<_$TileStyleGroupImpl> get copyWith =>
      __$$TileStyleGroupImplCopyWithImpl<_$TileStyleGroupImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleGroupImplToJson(
      this,
    );
  }
}

abstract class _TileStyleGroup extends TileStyleGroup {
  const factory _TileStyleGroup(
      {required final String id,
      required final String title}) = _$TileStyleGroupImpl;
  const _TileStyleGroup._() : super._();

  factory _TileStyleGroup.fromJson(Map<String, dynamic> json) =
      _$TileStyleGroupImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleGroupImplCopyWith<_$TileStyleGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomKey _$CustomKeyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'item':
      return _CustomKeyItem.fromJson(json);
    case 'layer':
      return _CustomKeyLayer.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'CustomKey', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$CustomKey {
  String get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) item,
    required TResult Function(String title, bool visible) layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? item,
    TResult? Function(String title, bool visible)? layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? item,
    TResult Function(String title, bool visible)? layer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CustomKeyItem value) item,
    required TResult Function(_CustomKeyLayer value) layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CustomKeyItem value)? item,
    TResult? Function(_CustomKeyLayer value)? layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CustomKeyItem value)? item,
    TResult Function(_CustomKeyLayer value)? layer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomKeyCopyWith<CustomKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomKeyCopyWith<$Res> {
  factory $CustomKeyCopyWith(CustomKey value, $Res Function(CustomKey) then) =
      _$CustomKeyCopyWithImpl<$Res, CustomKey>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$CustomKeyCopyWithImpl<$Res, $Val extends CustomKey>
    implements $CustomKeyCopyWith<$Res> {
  _$CustomKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomKeyItemImplCopyWith<$Res>
    implements $CustomKeyCopyWith<$Res> {
  factory _$$CustomKeyItemImplCopyWith(
          _$CustomKeyItemImpl value, $Res Function(_$CustomKeyItemImpl) then) =
      __$$CustomKeyItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title});
}

/// @nodoc
class __$$CustomKeyItemImplCopyWithImpl<$Res>
    extends _$CustomKeyCopyWithImpl<$Res, _$CustomKeyItemImpl>
    implements _$$CustomKeyItemImplCopyWith<$Res> {
  __$$CustomKeyItemImplCopyWithImpl(
      _$CustomKeyItemImpl _value, $Res Function(_$CustomKeyItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
  }) {
    return _then(_$CustomKeyItemImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomKeyItemImpl implements _CustomKeyItem {
  const _$CustomKeyItemImpl(this.title, {final String? $type})
      : $type = $type ?? 'item';

  factory _$CustomKeyItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomKeyItemImplFromJson(json);

  @override
  final String title;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CustomKey.item(title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomKeyItemImpl &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomKeyItemImplCopyWith<_$CustomKeyItemImpl> get copyWith =>
      __$$CustomKeyItemImplCopyWithImpl<_$CustomKeyItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) item,
    required TResult Function(String title, bool visible) layer,
  }) {
    return item(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? item,
    TResult? Function(String title, bool visible)? layer,
  }) {
    return item?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? item,
    TResult Function(String title, bool visible)? layer,
    required TResult orElse(),
  }) {
    if (item != null) {
      return item(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CustomKeyItem value) item,
    required TResult Function(_CustomKeyLayer value) layer,
  }) {
    return item(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CustomKeyItem value)? item,
    TResult? Function(_CustomKeyLayer value)? layer,
  }) {
    return item?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CustomKeyItem value)? item,
    TResult Function(_CustomKeyLayer value)? layer,
    required TResult orElse(),
  }) {
    if (item != null) {
      return item(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomKeyItemImplToJson(
      this,
    );
  }
}

abstract class _CustomKeyItem implements CustomKey {
  const factory _CustomKeyItem(final String title) = _$CustomKeyItemImpl;

  factory _CustomKeyItem.fromJson(Map<String, dynamic> json) =
      _$CustomKeyItemImpl.fromJson;

  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$CustomKeyItemImplCopyWith<_$CustomKeyItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomKeyLayerImplCopyWith<$Res>
    implements $CustomKeyCopyWith<$Res> {
  factory _$$CustomKeyLayerImplCopyWith(_$CustomKeyLayerImpl value,
          $Res Function(_$CustomKeyLayerImpl) then) =
      __$$CustomKeyLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, bool visible});
}

/// @nodoc
class __$$CustomKeyLayerImplCopyWithImpl<$Res>
    extends _$CustomKeyCopyWithImpl<$Res, _$CustomKeyLayerImpl>
    implements _$$CustomKeyLayerImplCopyWith<$Res> {
  __$$CustomKeyLayerImplCopyWithImpl(
      _$CustomKeyLayerImpl _value, $Res Function(_$CustomKeyLayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? visible = null,
  }) {
    return _then(_$CustomKeyLayerImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomKeyLayerImpl implements _CustomKeyLayer {
  const _$CustomKeyLayerImpl(this.title, this.visible, {final String? $type})
      : $type = $type ?? 'layer';

  factory _$CustomKeyLayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomKeyLayerImplFromJson(json);

  @override
  final String title;
  @override
  final bool visible;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'CustomKey.layer(title: $title, visible: $visible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomKeyLayerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.visible, visible) || other.visible == visible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, visible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomKeyLayerImplCopyWith<_$CustomKeyLayerImpl> get copyWith =>
      __$$CustomKeyLayerImplCopyWithImpl<_$CustomKeyLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) item,
    required TResult Function(String title, bool visible) layer,
  }) {
    return layer(title, visible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title)? item,
    TResult? Function(String title, bool visible)? layer,
  }) {
    return layer?.call(title, visible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? item,
    TResult Function(String title, bool visible)? layer,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(title, visible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CustomKeyItem value) item,
    required TResult Function(_CustomKeyLayer value) layer,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CustomKeyItem value)? item,
    TResult? Function(_CustomKeyLayer value)? layer,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CustomKeyItem value)? item,
    TResult Function(_CustomKeyLayer value)? layer,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomKeyLayerImplToJson(
      this,
    );
  }
}

abstract class _CustomKeyLayer implements CustomKey {
  const factory _CustomKeyLayer(final String title, final bool visible) =
      _$CustomKeyLayerImpl;

  factory _CustomKeyLayer.fromJson(Map<String, dynamic> json) =
      _$CustomKeyLayerImpl.fromJson;

  @override
  String get title;
  bool get visible;
  @override
  @JsonKey(ignore: true)
  _$$CustomKeyLayerImplCopyWith<_$CustomKeyLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
