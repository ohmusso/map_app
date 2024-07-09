library vecmap;

import 'dart:math';
import 'package:flutter/material.dart';

import 'proto/vectile/vector_tile.pb.dart';
export 'proto/vectile/vector_tile.pb.dart';

import 'package:vecmap/model/style.dart';
export 'model/style.dart';

export 'vecmap_webapi.dart';
export 'icon_sprite.dart';

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
  Map<String, List<DrawStyle>> genDrawStyles() {
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

          if (mapDrawStyles.containsKey(sourceLayer)) {
            mapDrawStyles[sourceLayer]!.add(DrawStyle(
                draw, ZoomLevel(layer.minzoom, layer.maxzoom), filter));
          } else {
            mapDrawStyles[sourceLayer] = List.empty(growable: true);
            mapDrawStyles[sourceLayer]!.add(DrawStyle(
                draw, ZoomLevel(layer.minzoom, layer.maxzoom), filter));
          }
        }
      }
    }

    return mapDrawStyles;
  }
}

const Color _fallbackColor = Color.fromARGB(100, 100, 100, 100);
const double _defaultLineWidth = 10.0;

class DrawStyle {
  final Color color;
  final ZoomLevel zoomLevel;
  final LineWidth? lineWidth;
  final List<dynamic> filter;

  factory DrawStyle(
    TileStyleDraw draw,
    ZoomLevel zoomLevel,
    List<dynamic> filter,
  ) {
    final Color color;
    final LineWidth? lineWidth;

    switch (draw.type) {
      case 'fill':
        color = convertColorFromStr(draw.draw['fill-color']);
        lineWidth = null;
        break;
      case 'line':
        color = convertColorFromStr(draw.draw['line-color']);
        if (draw.draw.containsKey('line-width')) {
          lineWidth = LineWidth(draw.draw['line-width']);
        } else {
          lineWidth = LineWidth(_defaultLineWidth);
        }
        break;
      case 'symbol':
        color = _fallbackColor;
        lineWidth = null;
        break;
      default:
        color = _fallbackColor;
        lineWidth = null;
        break;
    }

    return DrawStyle._(color, zoomLevel, lineWidth, filter);
  }

  DrawStyle._(this.color, this.zoomLevel, this.lineWidth, this.filter);
  const DrawStyle.defaultStyle()
      : color = Colors.black,
        zoomLevel = const ZoomLevel(1, 15),
        lineWidth = null,
        filter = const [true];

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

DrawStyle? getDrawStyle(
  List<DrawStyle>? drawStyles,
  Tile_Feature feature,
  Map<String, Tile_Value> featureTags,
) {
  if (drawStyles == null) {
    return null;
  }

  final drawStyle = drawStyles.where((drawStyle) {
    return exeFilterExpresstions(featureTags, drawStyle.filter);
  }).firstOrNull;

  final DrawStyle? ret;
  if (drawStyle != null) {
    ret = drawStyle;
  } else {
    ret = null;
  }

  return ret;
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
      default:
    }
  }

  /// TODO throw exception message
  return false;
}

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
          if (exeFilterExpresstion(tags, filterExp[i]) == false) {
            ret = false;
            break;
          }
        }
        break;
      case 'any':
        ret = false;
        for (int i = 1; i < filterExp.length; i++) {
          if (exeFilterExpresstion(tags, filterExp[i]) == true) {
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
