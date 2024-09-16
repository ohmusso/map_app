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
      zoom: (json['zoom'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      filter: json['filter'] as List<dynamic>?,
    );

Map<String, dynamic> _$$TileStyleGroupImplToJson(
        _$TileStyleGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'zoom': instance.zoom,
      'filter': instance.filter,
    };

_$TileStyleItemImpl _$$TileStyleItemImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleItemImpl(
      json['title'] as String,
      (json['list'] as List<dynamic>)
          .map((e) => TileStyleElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['group'] as List<dynamic>).map((e) => e as String).toList(),
      (json['zIndex'] as num?)?.toInt(),
      json['filter'] as List<dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleItemImplToJson(_$TileStyleItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'list': instance.list,
      'group': instance.group,
      'zIndex': instance.zIndex,
      'filter': instance.filter,
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
      (json['minzoom'] as num).toInt(),
      (json['maxzoom'] as num).toInt(),
      json['source-layer'] as String?,
      (json['list'] as List<dynamic>?)
          ?.map((e) => TileStyleDraw.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['filter'] as List<dynamic>?,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$TileStyleLayerImplToJson(
        _$TileStyleLayerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'visible': instance.visible,
      'minzoom': instance.minzoom,
      'maxzoom': instance.maxzoom,
      'source-layer': instance.sourceLayer,
      'list': instance.list,
      'filter': instance.filter,
      'type': instance.$type,
    };

_$TileStyleDrawImpl _$$TileStyleDrawImplFromJson(Map<String, dynamic> json) =>
    _$TileStyleDrawImpl(
      type: json['type'] as String,
      visible: json['visible'] as bool?,
      sourceLayer: json['source-layer'] as String?,
      minzoom: (json['minzoom'] as num?)?.toInt(),
      maxzoom: (json['maxzoom'] as num?)?.toInt(),
      info: json['info'] as Map<String, dynamic>,
      draw: json['draw'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$TileStyleDrawImplToJson(_$TileStyleDrawImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'visible': instance.visible,
      'source-layer': instance.sourceLayer,
      'minzoom': instance.minzoom,
      'maxzoom': instance.maxzoom,
      'info': instance.info,
      'draw': instance.draw,
    };
