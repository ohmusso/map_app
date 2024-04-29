library vecmap;

import 'dart:math';

import 'proto/vectile/vector_tile.pb.dart';
export 'proto/vectile/vector_tile.pb.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}

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

  static decodeZigzag(int parameterInteger) {
    return (parameterInteger >> 1) ^ (-(parameterInteger & 1));
  }

  static List<GeometryCommand> newCommands(List<int> geometory) {
    List<GeometryCommand> commands = [];
    for (var i = 0; i < geometory.length; /* count in body */) {
      /* comannd */
      final type = getCommandType(geometory[i]);
      final count = getCommandCount(geometory[i]);
      i++;

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

    return commands;
  }

  final GeometryCommandType commandType;
  final List<Point<int>> commandParameters;
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
