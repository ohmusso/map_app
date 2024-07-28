import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'dart:io';

import 'package:vecmap/vecmap.dart';

String _loadJsonString(String path) {
  final File file = File(path);
  return file.readAsStringSync();
}

void main() {
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

  test('parse tag', () {
    File file = File('./11_1796_811.pbf');
    Tile tile = Tile.fromBuffer(file.readAsBytesSync());

    final layer = getLayer(tile, 'transp');

    if (layer == null) {
      return;
    }

    print('${layer.name}, ${layer.keys}, ${layer.values}');

    for (var feature in layer.features) {
      /// tags format
      /// [d0, d1, d2, d3, ...]
      ///   |   |   |   | - index of layer.values
      ///   |   |   | - index of layer.keys
      ///   |   | - index of layer.values
      ///   | - index of layer.keys
      print('${feature.id}, ${feature.tags}');
    }

    final tags = genFeatureTags(layer, layer.features[0]);
    expect(tags['ftCode']!.intValue.toInt(), 2901);
  });

  group('DrawStyle fill', () {
    test('new DrawStyl fill', () {
      final DrawStyle style = DrawStyle(
        [],
        TileStyleDraw(
            type: 'fill',
            visible: true,
            sourceLayer: 'sourceLayer',
            info: {},
            draw: {'fill-color': 'rgb(255,135,75)'}),
        ZoomLevel(1, 10),
        [true],
      );

      expect(style.zoomLevel.minzoom, 1);
      expect(style.zoomLevel.maxzoom, 10);
      expect(style.color, Color.fromARGB(255, 255, 135, 75));
    });

    test('new LineWidth json object', () {
      final linwWidthInt = LineWidth(1);
      expect(linwWidthInt.getWidth(), 1.0);

      final linwWidthDouble = LineWidth(1.5);
      expect(linwWidthDouble.getWidth(), 1.5);

      final tileDraw = TileStyleDraw.fromJson({
        'type': 'line',
        'visible': true,
        'sourceLayer': 'hogehoge',
        'draw': {
          'line-color': 'red',
          'line-style': 'line',
          'line-width': {
            'stops': [
              [1, 5.0],
              [5, 25.0]
            ]
          },
        }
      });

      final linwWidthStops = LineWidth(tileDraw.draw['line-width']);
      expect(linwWidthStops.getWidthWithZoom(1), 5.0);
      expect(linwWidthStops.getWidthWithZoom(2), 10.0);
      expect(linwWidthStops.getWidthWithZoom(3), 15.0);
      expect(linwWidthStops.getWidthWithZoom(4), 20.0);
    });

    test('new LineWidth json string', () {
      final jsonStr = """
        {
          "type":"line",
          "source-layer":"landforml",
          "info":{
            "type":"line"
          },
          "draw":{
            "line-cap":"square",
            "line-color":"rgba(200, 160, 60,1)",
            "line-visible":true,
            "line-width": {
                "stops":[
                  [14,1.5],[17,4.5]
                ]
            }
          }
        }
      """;

      final json = jsonDecode(jsonStr);
      final tileDraw = TileStyleDraw.fromJson(json);
      final linwWidthStops = LineWidth(tileDraw.draw['line-width']);
      expect(linwWidthStops.getWidthWithZoom(14), 1.5);
      expect(linwWidthStops.getWidthWithZoom(15), 2.5);
      expect(linwWidthStops.getWidthWithZoom(16), 3.5);
      expect(linwWidthStops.getWidthWithZoom(17), 4.5);
    });

    test('new DrawStyl line', () {
      final DrawStyle style = DrawStyle(
        [],
        TileStyleDraw(
            type: 'line',
            visible: true,
            sourceLayer: 'sourceLayer',
            info: {},
            draw: {
              'line-color': 'rgb(255,135,75)',
              'line-width': 20,
            }),
        ZoomLevel(1, 10),
        [true],
      );

      expect(style.zoomLevel.minzoom, 1);
      expect(style.zoomLevel.maxzoom, 10);
      expect(style.color, Color.fromARGB(255, 255, 135, 75));
      expect(style.lineWidth!.getWidth(), 20.0);
    });

    test('DrawStyleGenerator', () {
      final jsonString = _loadJsonString('./style/test.json');
      final json = jsonDecode(jsonString);
      final style = TileStyle.fromJson(json);

      final generator = DrawStyleGenerator(style);
      final vecmapDrawStyle = generator.genVecmapDrawStyle();
      print(vecmapDrawStyle.styles);
    });

    test('convert string color', () {
      String str;
      Color color;

      str = 'rgba(10,20,30,0.5)';
      color = DrawStyle.convertColorFromStr(str);
      expect(color, Color.fromRGBO(10, 20, 30, 0.5));

      str = 'rgb(0,1,255)';
      color = DrawStyle.convertColorFromStr(str);
      expect(color, Color.fromRGBO(0, 1, 255, 1.0));
    });
  });

  group('filter expression', () {
    test('filter ==, intValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}')
      };

      final ret = exeFilterExpresstion(tags, ["==", "annoCtg", 2901]);
      expect(ret, true);
    });

    test('filter ==, stringValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstion(tags, ["==", "name", 'hogehoge']);
      expect(ret, true);
    });

    test('filter !=, intValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}')
      };

      final ret = exeFilterExpresstion(tags, ["!=", "annoCtg", 2901]);
      expect(ret, false);
    });

    test('filter !=, stringValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstion(tags, ["!=", "name", 'hogehoge']);
      expect(ret, false);
    });

    test('compareStringSignedValue', () async {
      var str1;
      var str2;
      var ret;

      str1 = '123';
      str2 = '123';
      ret = compareStringSignedValue(str1, str2);
      expect(ret, 0);
    });

    test('filter >=, stringValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"1":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      bool ret;
      ret = exeFilterExpresstion(tags, [">=", "annoCtg", "0"]);
      expect(ret, true);

      ret = exeFilterExpresstion(tags, [">=", "annoCtg", "2900"]);
      expect(ret, true);

      ret = exeFilterExpresstion(tags, [">=", "annoCtg", "2901"]);
      expect(ret, true);

      ret = exeFilterExpresstion(tags, [">=", "annoCtg", "2902"]);
      expect(ret, false);
    });

    test('filter >=, intValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstion(tags, [">=", "annoCtg", 0]);
      expect(ret, true);
    });

    test('filter <, stringValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"1":"2901"}'),
        'rtCode1': Tile_Value.fromJson('{"1":"40203800001"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      bool ret;
      ret = exeFilterExpresstion(tags, ["<", "annoCtg", "0"]);
      expect(ret, false);

      ret = exeFilterExpresstion(tags, ["<", "annoCtg", "2900"]);
      expect(ret, false);

      ret = exeFilterExpresstion(tags, ["<", "annoCtg", "2901"]);
      expect(ret, false);

      ret = exeFilterExpresstion(tags, ["<", "annoCtg", "2902"]);
      expect(ret, true);

      ret = exeFilterExpresstion(tags, [">=", "rtCode1", "40203800002"]);
      expect(ret, true);
    });

    test('filter <, intValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstion(tags, ["<", "annoCtg", 0]);
      expect(ret, false);
    });

    test('filter has', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      bool ret;

      ret = exeFilterExpresstion(tags, ["has", "annoCtg"]);
      expect(ret, true);

      ret = exeFilterExpresstion(tags, ["has", "ftCode"]);
      expect(ret, false);
    });

    test('filter !has', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      bool ret;

      ret = exeFilterExpresstion(tags, ["!has", "annoCtg"]);
      expect(ret, false);

      ret = exeFilterExpresstion(tags, ["!has", "ftCode"]);
      expect(ret, true);
    });

    test('filter in, stringValue', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"2901"}'),
        'name': Tile_Value.fromJson('{"1":"fugafuga"}'),
      };

      final ret =
          exeFilterExpresstion(tags, ["in", "name", 'hogehoge,fugafuga']);
      expect(ret, true);
    });

    test('filter in, list int', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"3"}'),
        'name': Tile_Value.fromJson('{"1":"fugafuga"}'),
      };

      final ret = exeFilterExpresstion(tags, [
        "in",
        "annoCtg",
        [1, 2, 3]
      ]);
      expect(ret, true);
    });

    test('filter in, ints', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"3"}'),
        'name': Tile_Value.fromJson('{"1":"fugafuga"}'),
      };

      final ret = exeFilterExpresstion(tags, ["in", "annoCtg", 1, 2, 3]);
      expect(ret, true);
    });

//"filter":["all",["in","ftCode",8201],["==","snglDbl",2],["in","railState",0,200],["any",["==","staCode","0"],["!has","staCode"]],["any",["all",[">=","rtCode1","40203000000"],["<","rtCode1","40204000000"]],["all",[">=","rtCode","40203000000"],["<","rtCode","40204000000"]]]]

    test('filter in, some int', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"3"}'),
        'name': Tile_Value.fromJson('{"1":"fugafuga"}'),
      };

      final ret = exeFilterExpresstion(tags, ["in", "annoCtg", 1, 2, 3]);
      expect(ret, true);
    });

    test('filter in, list string', () async {
      final Map<String, Tile_Value> tags = {
        'annoCtg': Tile_Value.fromJson('{"4":"3"}'),
        'name': Tile_Value.fromJson('{"1":"fugafuga"}'),
      };

      final ret = exeFilterExpresstion(tags, [
        "in",
        "name",
        ['aaa', 'bbb', 'fugafuga']
      ]);
      expect(ret, true);
    });

    test('filter all', () async {
      final Map<String, Tile_Value> tags = {
        'ftCode': Tile_Value.fromJson('{"4":"50100"}'),
        'annoCtg': Tile_Value.fromJson('{"4":"140"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstions(tags, [
        "all",
        ['==', 'ftCode', 50100],
        ['in', 'annoCtg', 140],
        ['==', 'name', 'hogehoge']
      ]);
      expect(ret, true);
    });

    test('filter all in, ==', () async {
      final Map<String, Tile_Value> tags = {
        'ftCode': Tile_Value.fromJson('{"4":"2701"}'),
        'annoCtg': Tile_Value.fromJson('{"4":"140"}'),
        'motorway': Tile_Value.fromJson('{"4":"1"}'),
      };

      final ret = exeFilterExpresstions(tags, [
        "all",
        ['in', 'ftCode', 2701],
        ['==', 'motorway', 1]
      ]);
      expect(ret, true);
    });

    test('filter any', () async {
      final Map<String, Tile_Value> tags = {
        'ftCode': Tile_Value.fromJson('{"4":"50100"}'),
        'annoCtg': Tile_Value.fromJson('{"4":"140"}'),
        'name': Tile_Value.fromJson('{"1":"hogehoge"}'),
      };

      final ret = exeFilterExpresstions(tags, [
        "any",
        ['==', 'ftCode', 50101],
        ['in', 'annoCtg', 141],
        ['==', 'name', 'hogehoge']
      ]);
      expect(ret, true);
    });
  });

  group('app test', () {
    /// feature
    /// - commands
    /// - tags
    ///
    /// drawstyle
    /// - filter
    /// - color
    /// - zoom
    // layer name: waterarea
    // layer name: wstructurea
    // layer name: boundary
    // layer name: contour
    // layer name: label
    // layer name: elevation
    // layer name: river
    // layer name: road
    // layer name: railway
    // layer name: transp
    // layer name: landforma
    // layer name: symbol

    test('find style corresponding to feature: road', () async {
      // read style
      final jsonString = await _loadJsonString('./style/std.json');
      final json = jsonDecode(jsonString);
      final style = TileStyle.fromJson(json);
      final generator = DrawStyleGenerator(style);
      final mapDrawStyles = generator.genVecmapDrawStyle().styles;

      // read pbf
      File file = File('./11_1796_811.pbf');
      Tile tile = Tile.fromBuffer(file.readAsBytesSync());

      // get drawStyle
      Tile_Layer? layer;
      String targetLayerName = 'road';
      layer = tile.layers
          .where((layer) => layer.name == targetLayerName)
          .firstOrNull;

      assert(layer != null);
      for (var feature in layer!.features) {
        final tags = genFeatureTags(layer, feature);
        assert(mapDrawStyles[targetLayerName] != null);

        final drawStyle = mapDrawStyles[targetLayerName]!.where((drawStyle) {
          return exeFilterExpresstions(tags, drawStyle.filter);
        }).firstOrNull;

        if (drawStyle == null) {
          print('ftcode: ${tags['ftCode']}, annoCtg: ${tags['annoCtg']}');
          print('style not found');
        }
      }
    });

    test('find style corresponding to feature: symbol', () async {
      // read style
      final jsonString = await _loadJsonString('./style/std.json');
      final json = jsonDecode(jsonString);
      final style = TileStyle.fromJson(json);
      final generator = DrawStyleGenerator(style);
      final mapDrawStyles = generator.genVecmapDrawStyle().styles;

      // read pbf
      File file = File('./11_1796_811.pbf');
      Tile tile = Tile.fromBuffer(file.readAsBytesSync());

      // get drawStyle
      Tile_Layer? layer;
      String targetLayerName = 'symbol';
      layer = tile.layers
          .where((layer) => layer.name == targetLayerName)
          .firstOrNull;

      assert(layer != null);
      for (var feature in layer!.features) {
        final tags = genFeatureTags(layer, feature);
        assert(mapDrawStyles[targetLayerName] != null);

        final drawStyle = mapDrawStyles[targetLayerName]!.where((drawStyle) {
          return exeFilterExpresstions(tags, drawStyle.filter);
        }).firstOrNull;

        if (drawStyle == null) {
          print('ftcode: ${tags['ftCode']}, annoCtg: ${tags['annoCtg']}');
          print('style not found');
        }
      }
    });
  });
}
