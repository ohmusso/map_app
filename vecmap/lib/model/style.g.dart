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
    );

Map<String, dynamic> _$$TileStyleImplToJson(_$TileStyleImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'group': instance.group,
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

_$CustomKeyItemImpl _$$CustomKeyItemImplFromJson(Map<String, dynamic> json) =>
    _$CustomKeyItemImpl(
      json['title'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CustomKeyItemImplToJson(_$CustomKeyItemImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.$type,
    };

_$CustomKeyLayerImpl _$$CustomKeyLayerImplFromJson(Map<String, dynamic> json) =>
    _$CustomKeyLayerImpl(
      json['title'] as String,
      json['visible'] as bool,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$CustomKeyLayerImplToJson(
        _$CustomKeyLayerImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'visible': instance.visible,
      'type': instance.$type,
    };
