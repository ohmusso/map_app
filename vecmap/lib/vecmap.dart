library vecmap;

import 'dart:math';
import 'package:flutter/material.dart';

import 'proto/vectile/vector_tile.pb.dart';
export 'proto/vectile/vector_tile.pb.dart';

import 'package:vecmap/model/style.dart';
export 'model/style.dart';

export 'vecmap_webapi.dart';

enum GeometryCommandType {
  moveTo(name: 'MoveTo', id: 1),
  lineTo(name: 'LineTo', id: 2),
  closePath(name: 'ClosePath', id: 7);

  const GeometryCommandType({required this.name, required this.id});

  final String name;
  final int id;

  static GeometryCommandType byId(int id) {
    for (var value in GeometryCommandType.values) {
      if (id == value.id) return value;
    }
    throw ArgumentError.value(id, "id", "No enum value with that id");
  }
}

class GeometryCommand {
  static const maskId = 0x7;
  static const shiftCount = 3;
  GeometryCommand(this.commandType, this.commandParameters);

  static GeometryCommandType getCommandType(int commandInteger) {
    var id = commandInteger & maskId;
    return GeometryCommandType.byId(id);
  }

  static int getCommandCount(int commandInteger) {
    return commandInteger >> shiftCount;
  }

  static int decodeZigzag(int parameterInteger) {
    // zigzag decode fomula
    //  - (parameterInteger >> 1) ^ (-(parameterInteger & 1)
    // can not use xor operator '^'. see bellow.
    // https://stackoverflow.com/questions/17427976/bitwise-operations-wrong-result-in-dart2js/17433485#17433485
    final int ret;
    if ((parameterInteger & 1) == 1) {
      // bit 0 is 1
      ret = -(parameterInteger >> 1) - 1;
    } else {
      // bit 0 is 0
      ret = parameterInteger >> 1;
    }
    return ret;
  }

  static List<GeometryCommand> newCommands(List<int> geometory) {
    List<GeometryCommand> commands = [];
    for (var i = 0; i < geometory.length; /* count in body */) {
      /* comannd */
      final type = getCommandType(geometory[i]);
      final count = getCommandCount(geometory[i]);
      i++;

      if (type == GeometryCommandType.closePath) {
        /* new command and add with no parameter */
        final command = GeometryCommand(type, List<Point<int>>.empty());
        commands.add(command);
      } else {
        /* parameters */
        final params = List<Point<int>>.generate(count, (index) {
          final geometoryIndex = i + (index * 2);
          // zigzag decode fomula: ((ParameterInteger >> 1) ^ (-(ParameterInteger & 1)))
          final dx = decodeZigzag(geometory[geometoryIndex]);
          final dy = decodeZigzag(geometory[geometoryIndex + 1]);
          return Point(dx, dy);
        });
        i += count * 2;

        /* new command and add */
        final command = GeometryCommand(type, params);
        commands.add(command);
      }
    }

    return commands;
  }

  final GeometryCommandType commandType;
  final List<Point<int>> commandParameters;
}

class DrawStyleGenerator {
  final TileStyle tileStyle;

  DrawStyleGenerator(this.tileStyle);

  /// key is source-layer
  VecmapDrawStyle genVecmapDrawStyle() {
    final groupIds = genGroupIds(tileStyle);
    final mapDrawStyles = _genMapDrawStyle(tileStyle);

    return VecmapDrawStyle(groupIds, mapDrawStyles);
  }

  static List<String> genGroupIds(TileStyle tileStyle) {
    return tileStyle.group.map((group) => group.id).toList();
  }

  static Map<String, List<DrawStyle>> _genMapDrawStyle(TileStyle tileStyle) {
    final mapNameItem = getItemNamesFromStyle(tileStyle);
    final mapDrawStyles = Map<String, List<DrawStyle>>.new();

    /// add filter to DrawStyle
    for (var nameItem in mapNameItem.entries) {
      List<dynamic> filter =
          nameItem.value.filter == null ? [true] : nameItem.value.filter!;

      for (var layerElement in nameItem.value.list) {
        final layer = layerElement as TileStyleLayer;
        final draws = getTileStyleDrawFromLayer(layer);
        String layerName = '';

        if (layer.sourceLayer != null) {
          layerName = layer.sourceLayer!;
        }

        if (layer.filter != null) {
          filter = layer.filter!;
        }

        for (var draw in draws) {
          final String sourceLayer;
          if (draw.sourceLayer != null) {
            sourceLayer = draw.sourceLayer!;
          } else {
            sourceLayer = layerName;
          }

          /// add style
          final List<String> groupIds = nameItem.value.group;
          final ZoomLevel zoomLevel = ZoomLevel(layer.minzoom, layer.maxzoom);
          if (mapDrawStyles.containsKey(sourceLayer)) {
            mapDrawStyles[sourceLayer]!
                .add(DrawStyle(groupIds, draw, zoomLevel, filter));
          } else {
            mapDrawStyles[sourceLayer] = List.empty(growable: true);
            mapDrawStyles[sourceLayer]!
                .add(DrawStyle(groupIds, draw, zoomLevel, filter));
          }
        }
      }
    }

    return mapDrawStyles;
  }
}

const Color _fallbackColor = Color.fromARGB(100, 100, 100, 100);
const double _defaultLineWidth = 10.0;

class VecmapDrawStyle {
  final List<String> groupIds;
  final Map<String, List<DrawStyle>> styles;
  VecmapDrawStyle(this.groupIds, this.styles);

  VecmapDrawStyle.NoStyle()
      : groupIds = List.empty(),
        styles = {};
}

class DrawStyle {
  final String drawType;
  final List<String> groupIds;
  final Color color;
  final ZoomLevel zoomLevel;
  final LineWidth? lineWidth;
  final List<double>? lineDashArray;
  final List<dynamic> filter;
  final Map<String, dynamic> textInfo;
  final TextOffset? textOffset;
  final String? iconImage;

  factory DrawStyle(
    final List<String> groupIds,
    TileStyleDraw draw,
    ZoomLevel zoomLevel,
    List<dynamic> filter,
  ) {
    final String drawType;
    final Color color;
    final LineWidth? lineWidth;
    final List<double>? lineDashArray;
    final TextOffset? textOffset;
    final String? iconImage;

    drawType = draw.type;
    switch (draw.type) {
      case 'fill':
        color = convertColorFromStr(draw.draw['fill-color']);
        lineWidth = null;
        lineDashArray = null;
        textOffset = null;
        iconImage = null;
        break;
      case 'line':
        color = convertColorFromStr(draw.draw['line-color']);
        if (draw.draw.containsKey('line-width')) {
          lineWidth = LineWidth(draw.draw['line-width']);
        } else {
          lineWidth = LineWidth(_defaultLineWidth);
        }
        lineDashArray = _getLineDashArray(draw.draw['line-dasharray']);
        textOffset = null;
        iconImage = null;
        break;
      case 'symbol':
        color = _genTextColor(draw.draw);
        lineWidth = null;
        lineDashArray = null;
        textOffset = _genTextOffset(draw.draw);
        iconImage = draw.draw['icon-image'];
        break;
      default:
        color = _fallbackColor;
        lineWidth = null;
        lineDashArray = null;
        textOffset = null;
        iconImage = null;
        break;
    }

    return DrawStyle._(drawType, groupIds, color, zoomLevel, lineWidth,
        lineDashArray, filter, draw.info, textOffset, iconImage);
  }

  DrawStyle._(
      this.drawType,
      this.groupIds,
      this.color,
      this.zoomLevel,
      this.lineWidth,
      this.lineDashArray,
      this.filter,
      this.textInfo,
      this.textOffset,
      this.iconImage);
  const DrawStyle.defaultStyle()
      : drawType = '',
        groupIds = const [],
        color = Colors.black,
        zoomLevel = const ZoomLevel(1, 15),
        lineWidth = null,
        lineDashArray = null,
        filter = const [true],
        textInfo = const {},
        textOffset = null,
        iconImage = null;

  static List<double>? _getLineDashArray(List<dynamic>? array) {
    if (array == null) {
      return null;
    }

    return array.map((e) {
      if (e is double) {
        return e;
      }

      return (e as int).toDouble();
    }).toList();
  }

  static Color _genTextColor(Map<String, dynamic> jsonDraw) {
    const key = 'text-color';
    if (jsonDraw.containsKey(key)) {
      return convertColorFromStr(jsonDraw[key]);
    } else {
      return _fallbackColor;
    }
  }

  static TextOffset? _genTextOffset(Map<String, dynamic> jsonDraw) {
    const key = 'text-offset';

    if (!jsonDraw.containsKey(key)) {
      return null;
    }

    /// "text-offset":"auto"
    /// or else
    if (!(jsonDraw[key] is List)) {
      /// TODO report error
      return null;
    }

    final array = jsonDraw[key];

    /// "text-offset":"[expression]"
    /// TODO parse expression
    if (!(array[0] is double) || !(array[1] is double)) {
      return null;
    }

    /// - "text-offset":[0,-0.1]
    final doubleArray = jsonDraw[key] as List;
    final x = doubleArray[0] as double;
    final y = doubleArray[1] as double;
    return TextOffset(x, y);
  }

  /// <https://docs.mapbox.com/style-spec/reference/types/#color>
  static Color convertColorFromStr(String? str) {
    if (str == null) {
      return _fallbackColor;
    }

    final Color color;
    if (str.contains('rgba')) {
      /// ex) 'rgba(100,100,100,0.5)'
      final List<String> strColorValues =
          str.substring(5, str.indexOf(')')).split(',');
      final int r = int.parse(strColorValues[0]);
      final int g = int.parse(strColorValues[1]);
      final int b = int.parse(strColorValues[2]);
      final double opacity = double.parse(strColorValues[3]);
      color = Color.fromRGBO(r, g, b, opacity);
    } else if (str.contains('rgb')) {
      /// ex) 'rgb(100,100,100)'
      final List<String> strColorValues =
          str.substring(4, str.indexOf(')')).split(',');
      final int r = int.parse(strColorValues[0]);
      final int g = int.parse(strColorValues[1]);
      final int b = int.parse(strColorValues[2]);
      final double opacity = 1.0;
      color = Color.fromRGBO(r, g, b, opacity);
    } else {
      color = _fallbackColor;
    }

    return color;
  }
}

const int zommLevelAll = 0;
const int zommLevelMax = 65535;

class ZoomLevel {
  final int minzoom;
  final int maxzoom;
  const ZoomLevel(this.minzoom, this.maxzoom);

  @override
  String toString() {
    return 'minzoom: $minzoom, maxzoom: $maxzoom';
  }

  bool isWithin(double curZoomLevel) {
    final flooredZoomLevel = curZoomLevel.floor();
    if (flooredZoomLevel < minzoom || flooredZoomLevel > maxzoom) {
      return false;
    }

    return true;
  }
}

class LineWidth {
  final Map<int, double> _mapLineWidth;

  factory LineWidth(dynamic width) {
    final mapLineWidth = Map<int, double>.new();

    if (width is num) {
      mapLineWidth[zommLevelAll] = width.toDouble();
      return LineWidth._(mapLineWidth);
    }

    /// interpolate: stops: [[zoomlevel, width],[zoomlevel, width]]
    final widthStops = width as Map;

    if (!widthStops.containsKey('stops')) {
      /// fallback
      mapLineWidth[zommLevelAll] = _defaultLineWidth;
      return LineWidth._(mapLineWidth);
    }

    final arrayZoomWidth = widthStops['stops']! as List;
    int preZoom = zommLevelMax;
    for (List zoomWidth in arrayZoomWidth) {
      final zoom = zoomWidth[0] as int;
      final width = zoomWidth[1] as num;
      mapLineWidth[zoom] = width.toDouble();

      _interpolate(mapLineWidth, preZoom, zoom);

      preZoom = zoom;
    }

    return LineWidth._(mapLineWidth);
  }

  LineWidth._(this._mapLineWidth);

  static void _interpolate(Map<int, double> map, int preZoom, int curZoom) {
    if (preZoom == zommLevelMax) {
      return;
    }

    final double d = (map[curZoom]! - map[preZoom]!) / (curZoom - preZoom);
    for (int i = preZoom + 1; i < curZoom; i++) {
      map[i] = map[i - 1]! + d;
    }
  }

  double? getWidthWithZoom(int zoom) {
    if (_mapLineWidth.containsKey(zommLevelAll)) {
      return _mapLineWidth[zommLevelAll];
    }

    return _mapLineWidth[zoom];
  }

  double getWidth() {
    if (_mapLineWidth.containsKey(zommLevelAll)) {
      return _mapLineWidth[zommLevelAll]!;
    }

    return _defaultLineWidth;
  }
}

class TextOffset {
  final double x;
  final double y;

  TextOffset(this.x, this.y);
}

List<DrawStyle> getDrawStyles(
  List<DrawStyle>? drawStyles,
  double curZoomLevel,
  Tile_Feature feature,
  Map<String, Tile_Value> featureTags,
) {
  if (drawStyles == null) {
    return List.empty();
  }

  return drawStyles
      .where((drawStyle) {
        return exeFilterExpresstions(featureTags, drawStyle.filter);
      })
      .where((drawStyle) => drawStyle.zoomLevel.isWithin(curZoomLevel))
      .toList();
}

Tile_Layer? getLayer(Tile tile, String layerName) {
  for (var layer in tile.layers) {
    if (layer.name == layerName) {
      return layer;
    }
  }

  return null;
}

Map<String, Tile_Value> genFeatureTags(Tile_Layer layer, Tile_Feature feature) {
  final featureTags = Map<String, Tile_Value>.new();
  for (int i = 0; i < feature.tags.length;) {
    final keyIndex = feature.tags[i];
    i++;

    final valueIndex = feature.tags[i];
    i++;

    featureTags[layer.keys[keyIndex]] = layer.values[valueIndex];
  }

  return featureTags;
}

const int _filterOperatorIndex = 0;
const int _filterkeyIndex = 1;
const int _filtervalueIndex = 2;

List<int> splitSignedStrValueBy1G(String str) {
  /// split 1giga length. 1giga length is 10.
  const int oneGigaLen = 10;

  /// generate list max index
  final int genLen = ((str.length - 1) ~/ oneGigaLen) + 1;

  final List<int> splitedlist = List.empty(growable: true);
  for (int i = 0; i < genLen; i++) {
    final subStart = i * oneGigaLen;
    final subExpectEnd = subStart + oneGigaLen;
    final subEnd;
    if (subExpectEnd < str.length) {
      subEnd = subExpectEnd;
    } else {
      subEnd = str.length;
    }

    final subStr = str.substring(subStart, subEnd);
    final intValue = int.tryParse(subStr);
    if (intValue == null) {
      return List.empty();
    }

    if (splitedlist.isEmpty && (intValue == 0)) {
      /// ex) str: 00000000001
      continue;
    }

    splitedlist.add(intValue);
  }

  if (splitedlist.isEmpty) {
    /// ex) str: 000
    return const [0];
  }

  return List.unmodifiable(splitedlist);
}

int compareStringSignedValue(String str1, String str2) {
  /// ex1)
  /// str1: 001234
  /// str2: 01235
  final List<int> str1Splited = splitSignedStrValueBy1G(str1);
  final List<int> str2Splited = splitSignedStrValueBy1G(str2);

  if (str1Splited.length > str2Splited.length) {
    return 1;
  }

  if (str1Splited.length > str2Splited.length) {
    return -1;
  }

  for (int i = 0; i < str1Splited.length; i++) {
    if (str1Splited[i] > str2Splited[i]) {
      return 1;
    }

    if (str1Splited[i] < str2Splited[i]) {
      return -1;
    }
  }

  /// same value
  return 0;
}

bool exeFilterExpresstion(Map<String, Tile_Value> tags, dynamic filterExp) {
  if (filterExp is bool) {
    return filterExp;
  }

  if (filterExp is List<dynamic>) {
    switch (filterExp[_filterOperatorIndex]) {
      case '==':
        if (tags[filterExp[_filterkeyIndex]] != null) {
          final filterValue = filterExp[_filtervalueIndex];
          if (filterValue is String) {
            return tags[filterExp[_filterkeyIndex]]!.stringValue == filterValue;
          } else if (filterValue is int) {
            return tags[filterExp[_filterkeyIndex]]!.intValue == filterValue;
          }
        }
        break;
      case '!=':
        if (tags[filterExp[_filterkeyIndex]] != null) {
          final filterValue = filterExp[_filtervalueIndex];
          if (filterValue is String) {
            return tags[filterExp[_filterkeyIndex]]!.stringValue != filterValue;
          } else if (filterValue is int) {
            return tags[filterExp[_filterkeyIndex]]!.intValue != filterValue;
          }
        }
        break;
      case '>=':

        /// get tagValue
        if (tags[filterExp[_filterkeyIndex]] == null) {
          break;
        }
        final tagValue = tags[filterExp[_filterkeyIndex]];

        /// get filterVaule
        final filterValue = filterExp[_filtervalueIndex];

        /// result of expression
        if (filterValue is String) {
          final ret =
              compareStringSignedValue(tagValue!.stringValue, filterValue);
          if (ret >= 0) {
            return true;
          }
          return false;
        }

        if (filterValue is int) {
          return tagValue!.intValue >= filterValue;
        }
        break;
      case '<':

        /// get tagValue
        if (tags[filterExp[_filterkeyIndex]] == null) {
          break;
        }
        final tagValue = tags[filterExp[_filterkeyIndex]];

        /// get filterVaule
        final filterValue = filterExp[_filtervalueIndex];

        /// result of expression
        if (filterValue is String) {
          final ret =
              compareStringSignedValue(tagValue!.stringValue, filterValue);
          if (ret < 0) {
            return true;
          }
          return false;
        }

        if (filterValue is int) {
          return tagValue!.intValue < filterValue;
        }
        break;
      case 'in':
        if (tags[filterExp[_filterkeyIndex]] != null) {
          final filterValue = filterExp[_filtervalueIndex];
          if (filterValue is String &&
              tags[filterExp[_filterkeyIndex]]!.hasStringValue()) {
            return filterValue
                .contains(tags[filterExp[_filterkeyIndex]]!.stringValue);
          } else if (filterValue is int &&
              tags[filterExp[_filterkeyIndex]]!.hasIntValue()) {
            /// filter exp: ['in', 'key', Int1, Int2, ..., IntN]
            bool ret = false;
            for (int i = _filtervalueIndex; i < filterExp.length; i++) {
              if (tags[filterExp[_filterkeyIndex]]!.intValue == filterExp[i]) {
                ret = true;
                break;
              }
            }
            return ret;
          } else if (filterValue is List) {
            if (filterValue.first is String) {
              return filterValue
                  .contains(tags[filterExp[_filterkeyIndex]]!.stringValue);
            } else if (filterValue.first is int) {
              return filterValue
                  .contains(tags[filterExp[_filterkeyIndex]]!.intValue.toInt());
            } else {
              // nop
            }
          } else {
            // nop
          }
        }
        break;
      case 'has':
        if (tags[filterExp[_filterkeyIndex]] != null) {
          return true;
        }
        break;
      case '!has':
        if (tags[filterExp[_filterkeyIndex]] == null) {
          return true;
        }
        break;
      default:
    }
  }

  /// TODO throw exception message
  return false;
}

/// recurcive
bool exeFilterExpresstions(Map<String, Tile_Value> tags, dynamic filterExp) {
  if (filterExp is bool) {
    return filterExp;
  }

  bool ret;
  if (filterExp is List<dynamic>) {
    switch (filterExp[_filterOperatorIndex]) {
      case 'all':
        ret = true;
        for (int i = 1; i < filterExp.length; i++) {
          if (exeFilterExpresstions(tags, filterExp[i]) == false) {
            ret = false;
            break;
          }
        }
        break;
      case 'any':
        ret = false;
        for (int i = 1; i < filterExp.length; i++) {
          if (exeFilterExpresstions(tags, filterExp[i]) == true) {
            ret = true;
            break;
          }
        }
        break;
      default:
        ret = exeFilterExpresstion(tags, filterExp);
    }
  } else {
    ret = false;
  }

  return ret;
}

void printTile(Tile tile) {
  for (var layer in tile.layers) {
    print('layer name: ${layer.name}');

    for (var feature in layer.features) {
      print('\tfeature type: ${feature.type}');
    }
  }
}

void printLayers(Tile tile) {
  for (var layer in tile.layers) {
    print('layer name: ${layer.name}');
  }
}

void printFeatures(List<Tile_Feature> features) {
  for (var feature in features) {
    print('feature type: ${feature.type}');
  }
}

void printGeometry(List<int> geometry) {
  for (var geocode in geometry) {
    var hex = geocode.toRadixString(16);
    print('geocode: $hex');
  }
}

void printCommands(List<GeometryCommand> commands) {
  for (var command in commands) {
    print('command: ${command.commandType}');
    for (var param in command.commandParameters) {
      print('param: ${param.x}, ${param.y}');
    }
  }
}
