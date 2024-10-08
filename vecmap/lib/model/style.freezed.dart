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
  List<int>? get zoom => throw _privateConstructorUsedError;
  List<dynamic>? get filter => throw _privateConstructorUsedError;

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
  $Res call({String id, String title, List<int>? zoom, List<dynamic>? filter});
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
    Object? zoom = freezed,
    Object? filter = freezed,
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
      zoom: freezed == zoom
          ? _value.zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
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
  $Res call({String id, String title, List<int>? zoom, List<dynamic>? filter});
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
    Object? zoom = freezed,
    Object? filter = freezed,
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
      zoom: freezed == zoom
          ? _value._zoom
          : zoom // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      filter: freezed == filter
          ? _value._filter
          : filter // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleGroupImpl extends _TileStyleGroup
    with DiagnosticableTreeMixin {
  const _$TileStyleGroupImpl(
      {required this.id,
      required this.title,
      required final List<int>? zoom,
      required final List<dynamic>? filter})
      : _zoom = zoom,
        _filter = filter,
        super._();

  factory _$TileStyleGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleGroupImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<int>? _zoom;
  @override
  List<int>? get zoom {
    final value = _zoom;
    if (value == null) return null;
    if (_zoom is EqualUnmodifiableListView) return _zoom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _filter;
  @override
  List<dynamic>? get filter {
    final value = _filter;
    if (value == null) return null;
    if (_filter is EqualUnmodifiableListView) return _filter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleGroup(id: $id, title: $title, zoom: $zoom, filter: $filter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleGroup'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('zoom', zoom))
      ..add(DiagnosticsProperty('filter', filter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._zoom, _zoom) &&
            const DeepCollectionEquality().equals(other._filter, _filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      const DeepCollectionEquality().hash(_zoom),
      const DeepCollectionEquality().hash(_filter));

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
      required final String title,
      required final List<int>? zoom,
      required final List<dynamic>? filter}) = _$TileStyleGroupImpl;
  const _TileStyleGroup._() : super._();

  factory _TileStyleGroup.fromJson(Map<String, dynamic> json) =
      _$TileStyleGroupImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<int>? get zoom;
  @override
  List<dynamic>? get filter;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleGroupImplCopyWith<_$TileStyleGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TileStyleElement _$TileStyleElementFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'item':
      return TileStyleItem.fromJson(json);
    case 'directory':
      return TileStyleDirectory.fromJson(json);
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
  List<Object>? get list => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)
        item,
    required TResult Function(String title, List<TileStyleElement> list)
        directory,
    required TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)
        layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult? Function(String title, List<TileStyleElement> list)? directory,
    TResult? Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult Function(String title, List<TileStyleElement> list)? directory,
    TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleDirectory value) directory,
    required TResult Function(TileStyleLayer value) layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleDirectory value)? directory,
    TResult? Function(TileStyleLayer value)? layer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleDirectory value)? directory,
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
  $Res call(
      {String title,
      List<TileStyleElement> list,
      List<String> group,
      int? zIndex,
      List<dynamic>? filter});
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
    Object? group = null,
    Object? zIndex = freezed,
    Object? filter = freezed,
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
      null == group
          ? _value._group
          : group // ignore: cast_nullable_to_non_nullable
              as List<String>,
      freezed == zIndex
          ? _value.zIndex
          : zIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == filter
          ? _value._filter
          : filter // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleItemImpl
    with DiagnosticableTreeMixin
    implements TileStyleItem {
  const _$TileStyleItemImpl(this.title, final List<TileStyleElement> list,
      final List<String> group, this.zIndex, final List<dynamic>? filter,
      {final String? $type})
      : _list = list,
        _group = group,
        _filter = filter,
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

  final List<String> _group;
  @override
  List<String> get group {
    if (_group is EqualUnmodifiableListView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_group);
  }

  @override
  final int? zIndex;
  final List<dynamic>? _filter;
  @override
  List<dynamic>? get filter {
    final value = _filter;
    if (value == null) return null;
    if (_filter is EqualUnmodifiableListView) return _filter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleElement.item(title: $title, list: $list, group: $group, zIndex: $zIndex, filter: $filter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleElement.item'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('group', group))
      ..add(DiagnosticsProperty('zIndex', zIndex))
      ..add(DiagnosticsProperty('filter', filter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            (identical(other.zIndex, zIndex) || other.zIndex == zIndex) &&
            const DeepCollectionEquality().equals(other._filter, _filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_group),
      zIndex,
      const DeepCollectionEquality().hash(_filter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleItemImplCopyWith<_$TileStyleItemImpl> get copyWith =>
      __$$TileStyleItemImplCopyWithImpl<_$TileStyleItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)
        item,
    required TResult Function(String title, List<TileStyleElement> list)
        directory,
    required TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)
        layer,
  }) {
    return item(title, list, group, zIndex, filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult? Function(String title, List<TileStyleElement> list)? directory,
    TResult? Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
  }) {
    return item?.call(title, list, group, zIndex, filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult Function(String title, List<TileStyleElement> list)? directory,
    TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
    required TResult orElse(),
  }) {
    if (item != null) {
      return item(title, list, group, zIndex, filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleDirectory value) directory,
    required TResult Function(TileStyleLayer value) layer,
  }) {
    return item(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleDirectory value)? directory,
    TResult? Function(TileStyleLayer value)? layer,
  }) {
    return item?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleDirectory value)? directory,
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
      final String title,
      final List<TileStyleElement> list,
      final List<String> group,
      final int? zIndex,
      final List<dynamic>? filter) = _$TileStyleItemImpl;

  factory TileStyleItem.fromJson(Map<String, dynamic> json) =
      _$TileStyleItemImpl.fromJson;

  @override
  String get title;
  @override
  List<TileStyleElement> get list;
  List<String> get group;
  int? get zIndex;
  List<dynamic>? get filter;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleItemImplCopyWith<_$TileStyleItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TileStyleDirectoryImplCopyWith<$Res>
    implements $TileStyleElementCopyWith<$Res> {
  factory _$$TileStyleDirectoryImplCopyWith(_$TileStyleDirectoryImpl value,
          $Res Function(_$TileStyleDirectoryImpl) then) =
      __$$TileStyleDirectoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<TileStyleElement> list});
}

/// @nodoc
class __$$TileStyleDirectoryImplCopyWithImpl<$Res>
    extends _$TileStyleElementCopyWithImpl<$Res, _$TileStyleDirectoryImpl>
    implements _$$TileStyleDirectoryImplCopyWith<$Res> {
  __$$TileStyleDirectoryImplCopyWithImpl(_$TileStyleDirectoryImpl _value,
      $Res Function(_$TileStyleDirectoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? list = null,
  }) {
    return _then(_$TileStyleDirectoryImpl(
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
class _$TileStyleDirectoryImpl
    with DiagnosticableTreeMixin
    implements TileStyleDirectory {
  const _$TileStyleDirectoryImpl(this.title, final List<TileStyleElement> list,
      {final String? $type})
      : _list = list,
        $type = $type ?? 'directory';

  factory _$TileStyleDirectoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleDirectoryImplFromJson(json);

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
    return 'TileStyleElement.directory(title: $title, list: $list)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleElement.directory'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('list', list));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleDirectoryImpl &&
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
  _$$TileStyleDirectoryImplCopyWith<_$TileStyleDirectoryImpl> get copyWith =>
      __$$TileStyleDirectoryImplCopyWithImpl<_$TileStyleDirectoryImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)
        item,
    required TResult Function(String title, List<TileStyleElement> list)
        directory,
    required TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)
        layer,
  }) {
    return directory(title, list);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult? Function(String title, List<TileStyleElement> list)? directory,
    TResult? Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
  }) {
    return directory?.call(title, list);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult Function(String title, List<TileStyleElement> list)? directory,
    TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
    required TResult orElse(),
  }) {
    if (directory != null) {
      return directory(title, list);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleDirectory value) directory,
    required TResult Function(TileStyleLayer value) layer,
  }) {
    return directory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleDirectory value)? directory,
    TResult? Function(TileStyleLayer value)? layer,
  }) {
    return directory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleDirectory value)? directory,
    TResult Function(TileStyleLayer value)? layer,
    required TResult orElse(),
  }) {
    if (directory != null) {
      return directory(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleDirectoryImplToJson(
      this,
    );
  }
}

abstract class TileStyleDirectory implements TileStyleElement {
  const factory TileStyleDirectory(
          final String title, final List<TileStyleElement> list) =
      _$TileStyleDirectoryImpl;

  factory TileStyleDirectory.fromJson(Map<String, dynamic> json) =
      _$TileStyleDirectoryImpl.fromJson;

  @override
  String get title;
  @override
  List<TileStyleElement> get list;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleDirectoryImplCopyWith<_$TileStyleDirectoryImpl> get copyWith =>
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
  $Res call(
      {String? title,
      bool? visible,
      int minzoom,
      int maxzoom,
      @JsonKey(name: 'source-layer') String? sourceLayer,
      List<TileStyleDraw>? list,
      List<dynamic>? filter});
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
    Object? minzoom = null,
    Object? maxzoom = null,
    Object? sourceLayer = freezed,
    Object? list = freezed,
    Object? filter = freezed,
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
      null == minzoom
          ? _value.minzoom
          : minzoom // ignore: cast_nullable_to_non_nullable
              as int,
      null == maxzoom
          ? _value.maxzoom
          : maxzoom // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == sourceLayer
          ? _value.sourceLayer
          : sourceLayer // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<TileStyleDraw>?,
      freezed == filter
          ? _value._filter
          : filter // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleLayerImpl
    with DiagnosticableTreeMixin
    implements TileStyleLayer {
  const _$TileStyleLayerImpl(
      this.title,
      this.visible,
      this.minzoom,
      this.maxzoom,
      @JsonKey(name: 'source-layer') this.sourceLayer,
      final List<TileStyleDraw>? list,
      final List<dynamic>? filter,
      {final String? $type})
      : _list = list,
        _filter = filter,
        $type = $type ?? 'layer';

  factory _$TileStyleLayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleLayerImplFromJson(json);

  @override
  final String? title;
  @override
  final bool? visible;
  @override
  final int minzoom;
  @override
  final int maxzoom;
  @override
  @JsonKey(name: 'source-layer')
  final String? sourceLayer;
  final List<TileStyleDraw>? _list;
  @override
  List<TileStyleDraw>? get list {
    final value = _list;
    if (value == null) return null;
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _filter;
  @override
  List<dynamic>? get filter {
    final value = _filter;
    if (value == null) return null;
    if (_filter is EqualUnmodifiableListView) return _filter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleElement.layer(title: $title, visible: $visible, minzoom: $minzoom, maxzoom: $maxzoom, sourceLayer: $sourceLayer, list: $list, filter: $filter)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleElement.layer'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('visible', visible))
      ..add(DiagnosticsProperty('minzoom', minzoom))
      ..add(DiagnosticsProperty('maxzoom', maxzoom))
      ..add(DiagnosticsProperty('sourceLayer', sourceLayer))
      ..add(DiagnosticsProperty('list', list))
      ..add(DiagnosticsProperty('filter', filter));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleLayerImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.minzoom, minzoom) || other.minzoom == minzoom) &&
            (identical(other.maxzoom, maxzoom) || other.maxzoom == maxzoom) &&
            (identical(other.sourceLayer, sourceLayer) ||
                other.sourceLayer == sourceLayer) &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            const DeepCollectionEquality().equals(other._filter, _filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      visible,
      minzoom,
      maxzoom,
      sourceLayer,
      const DeepCollectionEquality().hash(_list),
      const DeepCollectionEquality().hash(_filter));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleLayerImplCopyWith<_$TileStyleLayerImpl> get copyWith =>
      __$$TileStyleLayerImplCopyWithImpl<_$TileStyleLayerImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)
        item,
    required TResult Function(String title, List<TileStyleElement> list)
        directory,
    required TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)
        layer,
  }) {
    return layer(title, visible, minzoom, maxzoom, sourceLayer, list, filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult? Function(String title, List<TileStyleElement> list)? directory,
    TResult? Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
  }) {
    return layer?.call(
        title, visible, minzoom, maxzoom, sourceLayer, list, filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title, List<TileStyleElement> list,
            List<String> group, int? zIndex, List<dynamic>? filter)?
        item,
    TResult Function(String title, List<TileStyleElement> list)? directory,
    TResult Function(
            String? title,
            bool? visible,
            int minzoom,
            int maxzoom,
            @JsonKey(name: 'source-layer') String? sourceLayer,
            List<TileStyleDraw>? list,
            List<dynamic>? filter)?
        layer,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(title, visible, minzoom, maxzoom, sourceLayer, list, filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TileStyleItem value) item,
    required TResult Function(TileStyleDirectory value) directory,
    required TResult Function(TileStyleLayer value) layer,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TileStyleItem value)? item,
    TResult? Function(TileStyleDirectory value)? directory,
    TResult? Function(TileStyleLayer value)? layer,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TileStyleItem value)? item,
    TResult Function(TileStyleDirectory value)? directory,
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
  const factory TileStyleLayer(
      final String? title,
      final bool? visible,
      final int minzoom,
      final int maxzoom,
      @JsonKey(name: 'source-layer') final String? sourceLayer,
      final List<TileStyleDraw>? list,
      final List<dynamic>? filter) = _$TileStyleLayerImpl;

  factory TileStyleLayer.fromJson(Map<String, dynamic> json) =
      _$TileStyleLayerImpl.fromJson;

  @override
  String? get title;
  bool? get visible;
  int get minzoom;
  int get maxzoom;
  @JsonKey(name: 'source-layer')
  String? get sourceLayer;
  @override
  List<TileStyleDraw>? get list;
  List<dynamic>? get filter;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleLayerImplCopyWith<_$TileStyleLayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TileStyleDraw _$TileStyleDrawFromJson(Map<String, dynamic> json) {
  return _TileStyleDraw.fromJson(json);
}

/// @nodoc
mixin _$TileStyleDraw {
  String get type => throw _privateConstructorUsedError;
  bool? get visible => throw _privateConstructorUsedError;
  @JsonKey(name: 'source-layer')
  String? get sourceLayer => throw _privateConstructorUsedError;
  int? get minzoom => throw _privateConstructorUsedError;
  int? get maxzoom => throw _privateConstructorUsedError;
  Map<String, dynamic> get info => throw _privateConstructorUsedError;
  Map<String, dynamic> get draw => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TileStyleDrawCopyWith<TileStyleDraw> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TileStyleDrawCopyWith<$Res> {
  factory $TileStyleDrawCopyWith(
          TileStyleDraw value, $Res Function(TileStyleDraw) then) =
      _$TileStyleDrawCopyWithImpl<$Res, TileStyleDraw>;
  @useResult
  $Res call(
      {String type,
      bool? visible,
      @JsonKey(name: 'source-layer') String? sourceLayer,
      int? minzoom,
      int? maxzoom,
      Map<String, dynamic> info,
      Map<String, dynamic> draw});
}

/// @nodoc
class _$TileStyleDrawCopyWithImpl<$Res, $Val extends TileStyleDraw>
    implements $TileStyleDrawCopyWith<$Res> {
  _$TileStyleDrawCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? visible = freezed,
    Object? sourceLayer = freezed,
    Object? minzoom = freezed,
    Object? maxzoom = freezed,
    Object? info = null,
    Object? draw = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      visible: freezed == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
      sourceLayer: freezed == sourceLayer
          ? _value.sourceLayer
          : sourceLayer // ignore: cast_nullable_to_non_nullable
              as String?,
      minzoom: freezed == minzoom
          ? _value.minzoom
          : minzoom // ignore: cast_nullable_to_non_nullable
              as int?,
      maxzoom: freezed == maxzoom
          ? _value.maxzoom
          : maxzoom // ignore: cast_nullable_to_non_nullable
              as int?,
      info: null == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      draw: null == draw
          ? _value.draw
          : draw // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TileStyleDrawImplCopyWith<$Res>
    implements $TileStyleDrawCopyWith<$Res> {
  factory _$$TileStyleDrawImplCopyWith(
          _$TileStyleDrawImpl value, $Res Function(_$TileStyleDrawImpl) then) =
      __$$TileStyleDrawImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      bool? visible,
      @JsonKey(name: 'source-layer') String? sourceLayer,
      int? minzoom,
      int? maxzoom,
      Map<String, dynamic> info,
      Map<String, dynamic> draw});
}

/// @nodoc
class __$$TileStyleDrawImplCopyWithImpl<$Res>
    extends _$TileStyleDrawCopyWithImpl<$Res, _$TileStyleDrawImpl>
    implements _$$TileStyleDrawImplCopyWith<$Res> {
  __$$TileStyleDrawImplCopyWithImpl(
      _$TileStyleDrawImpl _value, $Res Function(_$TileStyleDrawImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? visible = freezed,
    Object? sourceLayer = freezed,
    Object? minzoom = freezed,
    Object? maxzoom = freezed,
    Object? info = null,
    Object? draw = null,
  }) {
    return _then(_$TileStyleDrawImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      visible: freezed == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool?,
      sourceLayer: freezed == sourceLayer
          ? _value.sourceLayer
          : sourceLayer // ignore: cast_nullable_to_non_nullable
              as String?,
      minzoom: freezed == minzoom
          ? _value.minzoom
          : minzoom // ignore: cast_nullable_to_non_nullable
              as int?,
      maxzoom: freezed == maxzoom
          ? _value.maxzoom
          : maxzoom // ignore: cast_nullable_to_non_nullable
              as int?,
      info: null == info
          ? _value._info
          : info // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      draw: null == draw
          ? _value._draw
          : draw // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TileStyleDrawImpl extends _TileStyleDraw with DiagnosticableTreeMixin {
  const _$TileStyleDrawImpl(
      {required this.type,
      required this.visible,
      @JsonKey(name: 'source-layer') required this.sourceLayer,
      required this.minzoom,
      required this.maxzoom,
      required final Map<String, dynamic> info,
      required final Map<String, dynamic> draw})
      : _info = info,
        _draw = draw,
        super._();

  factory _$TileStyleDrawImpl.fromJson(Map<String, dynamic> json) =>
      _$$TileStyleDrawImplFromJson(json);

  @override
  final String type;
  @override
  final bool? visible;
  @override
  @JsonKey(name: 'source-layer')
  final String? sourceLayer;
  @override
  final int? minzoom;
  @override
  final int? maxzoom;
  final Map<String, dynamic> _info;
  @override
  Map<String, dynamic> get info {
    if (_info is EqualUnmodifiableMapView) return _info;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_info);
  }

  final Map<String, dynamic> _draw;
  @override
  Map<String, dynamic> get draw {
    if (_draw is EqualUnmodifiableMapView) return _draw;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_draw);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TileStyleDraw(type: $type, visible: $visible, sourceLayer: $sourceLayer, minzoom: $minzoom, maxzoom: $maxzoom, info: $info, draw: $draw)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TileStyleDraw'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('visible', visible))
      ..add(DiagnosticsProperty('sourceLayer', sourceLayer))
      ..add(DiagnosticsProperty('minzoom', minzoom))
      ..add(DiagnosticsProperty('maxzoom', maxzoom))
      ..add(DiagnosticsProperty('info', info))
      ..add(DiagnosticsProperty('draw', draw));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TileStyleDrawImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.sourceLayer, sourceLayer) ||
                other.sourceLayer == sourceLayer) &&
            (identical(other.minzoom, minzoom) || other.minzoom == minzoom) &&
            (identical(other.maxzoom, maxzoom) || other.maxzoom == maxzoom) &&
            const DeepCollectionEquality().equals(other._info, _info) &&
            const DeepCollectionEquality().equals(other._draw, _draw));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      visible,
      sourceLayer,
      minzoom,
      maxzoom,
      const DeepCollectionEquality().hash(_info),
      const DeepCollectionEquality().hash(_draw));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TileStyleDrawImplCopyWith<_$TileStyleDrawImpl> get copyWith =>
      __$$TileStyleDrawImplCopyWithImpl<_$TileStyleDrawImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TileStyleDrawImplToJson(
      this,
    );
  }
}

abstract class _TileStyleDraw extends TileStyleDraw {
  const factory _TileStyleDraw(
      {required final String type,
      required final bool? visible,
      @JsonKey(name: 'source-layer') required final String? sourceLayer,
      required final int? minzoom,
      required final int? maxzoom,
      required final Map<String, dynamic> info,
      required final Map<String, dynamic> draw}) = _$TileStyleDrawImpl;
  const _TileStyleDraw._() : super._();

  factory _TileStyleDraw.fromJson(Map<String, dynamic> json) =
      _$TileStyleDrawImpl.fromJson;

  @override
  String get type;
  @override
  bool? get visible;
  @override
  @JsonKey(name: 'source-layer')
  String? get sourceLayer;
  @override
  int? get minzoom;
  @override
  int? get maxzoom;
  @override
  Map<String, dynamic> get info;
  @override
  Map<String, dynamic> get draw;
  @override
  @JsonKey(ignore: true)
  _$$TileStyleDrawImplCopyWith<_$TileStyleDrawImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
