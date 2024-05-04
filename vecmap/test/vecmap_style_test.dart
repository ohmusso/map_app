import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vecmap/model/style.dart';
import 'dart:io';

Future<String> loadJsonString(String path) async {
  final File file = File(path);
  return await file.readAsString();
}

void main() {
  test('read test json', () async {
    final jsonString = await loadJsonString('./style/test.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);
    expect(style.title, '標準地図');
    print(style.group);
    print(style.list);
  });

  test('union key json', () async {
    expect(
        TileStyleElement.fromJson(<String, dynamic>{
          'type': 'item',
          'title': '水域',
          'list': [
            {'type': 'layer', 'title': '水域'}
          ]
        }),
        TileStyleElement.item('水域', [TileStyleElement.layer('水域', null)]));

    expect(
      TileStyleElement.fromJson(<String, dynamic>{
        'type': 'layer',
        'title': '道路',
        'visible': true,
      }),
      TileStyleElement.layer('道路', true),
    );

    print(TileStyleElement.layer('42', false));
  });

  test('read pbf', () {
    // File file = File('./11_1796_811.pbf');
    // Tile tile = Tile.fromBuffer(file.readAsBytesSync());

    // final layer = getLayer(tile, 'boundary');
    // expect(layer!.name, 'boundary');

    // expect(layer.extent, 4096);
    // expect(layer.features[0].type, Tile_GeomType.LINESTRING);

    // printLayers(tile);

    // final geometry = layer.features[0].geometry;
    // printGeometry(geometry);
  });

  test('decode geometry', () {
    // File file = File('./11_1796_811.pbf');
    // Tile tile = Tile.fromBuffer(file.readAsBytesSync());

    // final layer = getLayer(tile, 'boundary');
    // final geometry = layer!.features[0].geometry;
    // print('${layer.name}, ${layer.keys}, ${layer.values}');
    // print(geometry);

    // final type = GeometryCommand.getCommandType(geometry[0]);
    // final count = GeometryCommand.getCommandCount(geometry[0]);

    // expect(type, GeometryCommandType.moveTo);
    // expect(count, 1);

    // final commands = GeometryCommand.newCommands(geometry);
    // expect(commands.length, 2);
    // expect(commands[0].commandType, GeometryCommandType.moveTo);
    // expect(commands[1].commandType, GeometryCommandType.lineTo);

    // printCommands(commands);
    // // print('command num: ${command.length}');
    // // print('command[0]: ${command[0].commandType}');
    // // print('${command[0].commandParameters}');
    // // print('command[1]: ${command[1].commandType}');
    // // print('${command[1].commandParameters}');
  });
}
