// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TileStyleImpl _$$TileStyleImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleImpl(
      title: json['title'] as String,
      group: (json['group'] as List<dynamic>)
          .map((e) => TileStyleGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
      list: (json['list'] as List<dynamic>)
          .map((e) => TileStyleElement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TileStyleImplToJson(_$TileStyleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'group': instance.group,
      'list': instance.list,
    };

_$TileStyleGroupImpl _$$TileStyleGroupImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleGroupImpl(
      id: json['id'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$TileStyleGroupImplToJson(
        _$TileStyleGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };

_$TileStyleItemImpl _$$TileStyleItemImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleItemImpl(
      json['title'] as String,
      (json['list'] as List<dynamic>)
          .map((e) => TileStyleElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleItemImplToJson(_$TileStyleItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'list': instance.list,
      'type': instance.$type,
    };

_$TileStyleLayerImpl _$$TileStyleLayerImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleLayerImpl(
      json['title'] as String?,
      json['visible'] as bool?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleLayerImplToJson(
        _$TileStyleLayerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'visible': instance.visible,
      'type': instance.$type,
    };
