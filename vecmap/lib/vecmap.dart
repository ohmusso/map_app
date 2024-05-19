library vecmap;

import 'dart:math';
import 'dart:ui';

import 'package:vecmap/model/style.dart';

import 'proto/vectile/vector_tile.pb.dart';
export 'proto/vectile/vector_tile.pb.dart';

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

class DrawDataGenerator {
  final TileStyle tileStyle;

  DrawDataGenerator(this.tileStyle);

  Map<String, List<DrawStyle>> genDrawStyles() {
    final mapNameItem = getItemNamesFromStyle(tileStyle);
    final mapDrawStyles = Map<String, List<DrawStyle>>.new();
    for (var nameItem in mapNameItem.entries) {
      final List<DrawStyle> drawStyles = List.empty(growable: true);
      for (var layerElement in nameItem.value.list) {
        final layer = layerElement as TileStyleLayer;
        final draws = getTileStyleDrawFromLayer(layer);

        for (var draw in draws) {
          drawStyles
              .add(DrawStyle(draw, ZoomLevel(layer.minzoom, layer.maxzoom)));
        }
      }

      mapDrawStyles[nameItem.key] = drawStyles;
    }

    return mapDrawStyles;
  }
}

const Color _fallbackColor = Color.fromARGB(100, 100, 100, 100);

class DrawStyle {
  final Color color;
  final ZoomLevel zoomLevel;

  factory DrawStyle(
    TileStyleDraw draw,
    ZoomLevel zoomLevel,
  ) {
    final Color color;
    switch (draw.type) {
      case 'fill':
        color = convertColorFromStr(draw.draw['fill-color']);
        break;
      case 'line':
        color = convertColorFromStr(draw.draw['line-color']);
        break;
      case 'symbol':
        color = _fallbackColor;
        break;
      default:
        color = _fallbackColor;
        break;
    }
    return DrawStyle._(color, zoomLevel);
  }

  DrawStyle._(this.color, this.zoomLevel);
  DrawStyle.fallback(this.color, this.zoomLevel);

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

class ZoomLevel {
  final int minzoom;
  final int maxzoom;
  ZoomLevel(this.minzoom, this.maxzoom);
}

class DrawData {
  final int ftcode;
  final List<DrawStyle> style;
  final List<GeometryCommand> commands;

  DrawData(
    this.ftcode,
    this.style,
    this.commands,
  );
}

Tile_Layer? getLayer(Tile tile, String layerName) {
  for (var layer in tile.layers) {
    if (layer.name == layerName) {
      return layer;
    }
  }

  return null;
}

void printTile(Tile tile) {
  for (var layer in tile.layers) {
    print('layter name: ${layer.name}');

    for (var feature in layer.features) {
      print('\tfeature type: ${feature.type}');
    }
  }
}

void printLayers(Tile tile) {
  for (var layer in tile.layers) {
    print('layter name: ${layer.name}');
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
