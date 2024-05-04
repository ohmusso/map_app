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

_$TileStyleDirectoryImpl _$$TileStyleDirectoryImplFromJson(
        Map<String, dynamic> json) =>
    _$TileStyleDirectoryImpl(
      json['title'] as String,
      (json['list'] as List<dynamic>)
          .map((e) => TileStyleElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleDirectoryImplToJson(
        _$TileStyleDirectoryImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'list': instance.list,
      'type': instance.$type,
    };

_$TileStyleLayerImpl _$$TileStyleLayerImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleLayerImpl(
      json['title'] as String?,
      json['visible'] as bool?,
      (json['list'] as List<dynamic>?)
          ?.map((e) => TileStyleDraw.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleLayerImplToJson(
        _$TileStyleLayerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'visible': instance.visible,
      'list': instance.list,
      'type': instance.$type,
    };

_$TileStyleDrawImpl _$$TileStyleDrawImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleDrawImpl(
      type: json['type'] as String,
      visible: json['visible'] as bool?,
      sourceLayer: json['source-layer'] as String?,
      draw: json['draw'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$TileStyleDrawImplToJson(_$TileStyleDrawImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'visible': instance.visible,
      'source-layer': instance.sourceLayer,
      'draw': instance.draw,
    };
