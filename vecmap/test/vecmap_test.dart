import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:vecmap/vecmap.dart';

void main() {
  test('adds one to input values', () {
    final calculator = Calculator();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });

  test('decode zigzag', () {
    var decodedParam = GeometryCommand.decodeZigzag(9);
    expect(decodedParam, -5);
    decodedParam = GeometryCommand.decodeZigzag(886);
    expect(decodedParam, 443);
    decodedParam = GeometryCommand.decodeZigzag(159);
    expect(decodedParam, -80);
  });

  test('read pbf', () {
    File file = File('./11_1796_811.pbf');
    Tile tile = Tile.fromBuffer(file.readAsBytesSync());

    final layer = getLayer(tile, 'boundary');
    expect(layer!.name, 'boundary');

    expect(layer.extent, 4096);
    expect(layer.features[0].type, Tile_GeomType.LINESTRING);

    printLayers(tile);

    final geometry = layer.features[0].geometry;
    printGeometry(geometry);
  });

  test('decode geometry', () {
    File file = File('./11_1796_811.pbf');
    Tile tile = Tile.fromBuffer(file.readAsBytesSync());

    final layer = getLayer(tile, 'boundary');
    final geometry = layer!.features[0].geometry;
    print('${layer.name}, ${layer.keys}, ${layer.values}');
    print(geometry);

    final type = GeometryCommand.getCommandType(geometry[0]);
    final count = GeometryCommand.getCommandCount(geometry[0]);

    expect(type, GeometryCommandType.moveTo);
    expect(count, 1);

    final commands = GeometryCommand.newCommands(geometry);
    expect(commands.length, 2);
    expect(commands[0].commandType, GeometryCommandType.moveTo);
    expect(commands[1].commandType, GeometryCommandType.lineTo);

    printCommands(commands);
    // print('command num: ${command.length}');
    // print('command[0]: ${command[0].commandType}');
    // print('${command[0].commandParameters}');
    // print('command[1]: ${command[1].commandType}');
    // print('${command[1].commandParameters}');
  });
}
