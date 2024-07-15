import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'style.freezed.dart';
part 'style.g.dart';

@freezed
class TileStyle with _$TileStyle {
  const TileStyle._();
  const factory TileStyle({
    required String title,
    required List<TileStyleGroup> group,
    required List<TileStyleElement> list,
  }) = _TileStyle;

  factory TileStyle.fromJson(Map<String, dynamic> json) =>
      _$TileStyleFromJson(json);
}

@freezed
class TileStyleGroup with _$TileStyleGroup {
  const TileStyleGroup._();
  const factory TileStyleGroup({
    required String id,
    required String title,
    required List<int>? zoom,
    required List<dynamic>? filter,
  }) = _TileStyleGroup;

  factory TileStyleGroup.fromJson(Map<String, dynamic> json) =>
      _$TileStyleGroupFromJson(json);
}

@Freezed(unionKey: 'type')
class TileStyleElement with _$TileStyleElement {
  const factory TileStyleElement.item(
    String title,
    List<TileStyleElement> list,
    int? zIndex,
    List<dynamic>? filter,
  ) = TileStyleItem;
  const factory TileStyleElement.directory(
      String title, List<TileStyleElement> list) = TileStyleDirectory;
  const factory TileStyleElement.layer(
    String? title,
    bool? visible,
    int minzoom,
    int maxzoom,
    @JsonKey(name: 'source-layer') String? sourceLayer,
    List<TileStyleDraw>? list,
    List<dynamic>? filter,
  ) = TileStyleLayer;

  factory TileStyleElement.fromJson(Map<String, dynamic> json) =>
      _$TileStyleElementFromJson(json);
}

@freezed
class TileStyleDraw with _$TileStyleDraw {
  const TileStyleDraw._();
  const factory TileStyleDraw({
    required String type,
    required bool? visible,
    @JsonKey(name: 'source-layer') required String? sourceLayer,
    required Map<String, dynamic> info,
    required Map<String, dynamic> draw,
  }) = _TileStyleDraw;

  factory TileStyleDraw.fromJson(Map<String, dynamic> json) =>
      _$TileStyleDrawFromJson(json);
}

/// key is directory.Title/Item.Title
Map<String, TileStyleItem> getItemNamesFromStyle(TileStyle style) {
  final mapNameItem = Map<String, TileStyleItem>.new();
  for (var element in style.list) {
    if (element is TileStyleDirectory) {
      String itemName = element.title;
      for (var e in element.list) {
        if (e is TileStyleDirectory) {
          itemName += '/${e.title}';
          _addItemNameFromDirectory(e, mapNameItem, itemName);
        } else if (e is TileStyleItem) {
          mapNameItem['${itemName}/${e.title}'] = e;
        } else {
          // assert(false, 'not support directory hierarchy: ${item.title}');
        }
      }
    } else if (element is TileStyleItem) {
      mapNameItem[element.title] = element;
    } else {
      // assert(false, 'not support type: ${element.runtimeType}');
    }
  }

  return mapNameItem;
}

/// recursive
/// key is directory.Name/Item.Title
void _addItemNameFromDirectory(
  TileStyleDirectory directory,
  Map<String, TileStyleItem> mapNameItem,
  String itemName,
) {
  for (var element in directory.list) {
    if (element is TileStyleDirectory) {
      itemName += '/${element.title}';
      _addItemNameFromDirectory(element, mapNameItem, itemName);
    } else if (element is TileStyleItem) {
      mapNameItem['${itemName}/${element.title}'] = element;
    } else {
      // nop
    }
  }
}

TileStyleItem? getTileStyleItem(TileStyle style, String title) {
  final query = style.list
      .where((e) => e is TileStyleItem)
      .where((e) => e.title == title);

  if (query.isEmpty) {
    return null;
  }

  return query.first as TileStyleItem;
}

const defaultDraw = TileStyleDraw(
    type: '*',
    visible: true,
    sourceLayer: '*',
    info: {},
    draw: {'color': 'rgba(0, 0, 0, 1)'});

List<TileStyleDraw> getTileStyleDrawFromLayer(TileStyleLayer layer) {
  final draws = layer.list;
  if (draws == null) {
    return [defaultDraw];
  }

  return draws;
}
