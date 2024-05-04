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
  List<TileStyleElement> get list => throw _privateConstructorUsedError;

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
  $Res call(
      {String title, List<TileStyleGroup> group, List<TileStyleElement> list});
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
    Object? list = null,
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
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TileStyleElement>,
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
  $Res call(
      {String title, List<TileStyleGroup> group, List<TileStyleElement> list});
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
    Object? list = null,
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
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TileStyleElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleImpl extends _TileStyle with DiagnosticableTreeMixin {
  const _$TileStyleImpl(
      {required this.title,
      required final List<TileStyleGroup> group,
      required final List<TileStyleElement> list})
      : _group = group,
        _list = list,
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

  final List<TileStyleElement> _list;
  @override
  List<TileStyleElement> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyle(title: $title, group: $group, list: $list)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyle'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('list', list));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_group),
      const DeepCollectionEquality().hash(_list));

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
      required final List<TileStyleGroup> group,
      required final List<TileStyleElement> list}) = _$TileStyleImpl;
  const _TileStyle._() : super._();

  factory _TileStyle.fromJson(Map<String, dynamic> json) =
      _$TileStyleImpl.fromJson;

  @override
  String get title;
  @override
  List<TileStyleGroup> get group;
  @override
  List<TileStyleElement> get list;
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
class _$TileStyleGroupImpl extends _TileStyleGroup
    with DiagnosticableTreeMixin {
  const _$TileStyleGroupImpl({required this.id, required this.title})
      : super._();

  factory _$TileStyleGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleGroup(id: $id, title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleGroup'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title));
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

TileStyleElement _$TileStyleElementFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'item':
      return TileStyleItem.fromJson(json);
    case 'layer':
      return TileStyleLayer.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'TileStyleElement',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$TileStyleElement {
  String? get title => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list) item,
    required TResult Function(String? title, bool? visible) layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list)? item,
    TResult? Function(String? title, bool? visible)? layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list)? item,
    TResult Function(String? title, bool? visible)? layer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleLayer value) layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleLayer value)? layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleLayer value)? layer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileStyleElementCopyWith<TileStyleElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileStyleElementCopyWith<$Res> {
  factory $TileStyleElementCopyWith(
          TileStyleElement value, $Res Function(TileStyleElement) then) =
      _$TileStyleElementCopyWithImpl<$Res, TileStyleElement>;
  @useResult
  $Res call({String title});
}

/// @nodoc
class _$TileStyleElementCopyWithImpl<$Res, $Val extends TileStyleElement>
    implements $TileStyleElementCopyWith<$Res> {
  _$TileStyleElementCopyWithImpl(this._value, this._then);

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
          ? _value.title!
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileStyleItemImplCopyWith<$Res>
    implements $TileStyleElementCopyWith<$Res> {
  factory _$$TileStyleItemImplCopyWith(
          _$TileStyleItemImpl value, $Res Function(_$TileStyleItemImpl) then) =
      __$$TileStyleItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<TileStyleElement> list});
}

/// @nodoc
class __$$TileStyleItemImplCopyWithImpl<$Res>
    extends _$TileStyleElementCopyWithImpl<$Res, _$TileStyleItemImpl>
    implements _$$TileStyleItemImplCopyWith<$Res> {
  __$$TileStyleItemImplCopyWithImpl(
      _$TileStyleItemImpl _value, $Res Function(_$TileStyleItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? list = null,
  }) {
    return _then(_$TileStyleItemImpl(
      null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TileStyleElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleItemImpl
    with DiagnosticableTreeMixin
    implements TileStyleItem {
  const _$TileStyleItemImpl(this.title, final List<TileStyleElement> list,
      {final String? $type})
      : _list = list,
        $type = $type ?? 'item';

  factory _$TileStyleItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleItemImplFromJson(json);

  @override
  final String title;
  final List<TileStyleElement> _list;
  @override
  List<TileStyleElement> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleElement.item(title: $title, list: $list)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleElement.item'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('list', list));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleItemImplCopyWith<_$TileStyleItemImpl> get copyWith =>
      __$$TileStyleItemImplCopyWithImpl<_$TileStyleItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list) item,
    required TResult Function(String? title, bool? visible) layer,
  }) {
    return item(title, list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list)? item,
    TResult? Function(String? title, bool? visible)? layer,
  }) {
    return item?.call(title, list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list)? item,
    TResult Function(String? title, bool? visible)? layer,
    required TResult orElse(),
  }) {
    if (item != null) {
      return item(title, list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleLayer value) layer,
  }) {
    return item(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleLayer value)? layer,
  }) {
    return item?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleLayer value)? layer,
    required TResult orElse(),
  }) {
    if (item != null) {
      return item(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleItemImplToJson(
      this,
    );
  }
}

abstract class TileStyleItem implements TileStyleElement {
  const factory TileStyleItem(
          final String title, final List<TileStyleElement> list) =
      _$TileStyleItemImpl;

  factory TileStyleItem.fromJson(Map<String, dynamic> json) =
      _$TileStyleItemImpl.fromJson;

  @override
  String get title;
  List<TileStyleElement> get list;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleItemImplCopyWith<_$TileStyleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TileStyleLayerImplCopyWith<$Res>
    implements $TileStyleElementCopyWith<$Res> {
  factory _$$TileStyleLayerImplCopyWith(_$TileStyleLayerImpl value,
          $Res Function(_$TileStyleLayerImpl) then) =
      __$$TileStyleLayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? title, bool? visible});
}

/// @nodoc
class __$$TileStyleLayerImplCopyWithImpl<$Res>
    extends _$TileStyleElementCopyWithImpl<$Res, _$TileStyleLayerImpl>
    implements _$$TileStyleLayerImplCopyWith<$Res> {
  __$$TileStyleLayerImplCopyWithImpl(
      _$TileStyleLayerImpl _value, $Res Function(_$TileStyleLayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? visible = freezed,
  }) {
    return _then(_$TileStyleLayerImpl(
      freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleLayerImpl
    with DiagnosticableTreeMixin
    implements TileStyleLayer {
  const _$TileStyleLayerImpl(this.title, this.visible, {final String? $type})
      : $type = $type ?? 'layer';

  factory _$TileStyleLayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleLayerImplFromJson(json);

  @override
  final String? title;
  @override
  final bool? visible;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleElement.layer(title: $title, visible: $visible)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleElement.layer'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('visible', visible));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleLayerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.visible, visible) || other.visible == visible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, visible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleLayerImplCopyWith<_$TileStyleLayerImpl> get copyWith =>
      __$$TileStyleLayerImplCopyWithImpl<_$TileStyleLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list) item,
    required TResult Function(String? title, bool? visible) layer,
  }) {
    return layer(title, visible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list)? item,
    TResult? Function(String? title, bool? visible)? layer,
  }) {
    return layer?.call(title, visible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list)? item,
    TResult Function(String? title, bool? visible)? layer,
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
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleLayer value) layer,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleLayer value)? layer,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleLayer value)? layer,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleLayerImplToJson(
      this,
    );
  }
}

abstract class TileStyleLayer implements TileStyleElement {
  const factory TileStyleLayer(final String? title, final bool? visible) =
      _$TileStyleLayerImpl;

  factory TileStyleLayer.fromJson(Map<String, dynamic> json) =
      _$TileStyleLayerImpl.fromJson;

  @override
  String? get title;
  bool? get visible;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleLayerImplCopyWith<_$TileStyleLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
