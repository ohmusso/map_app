import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:vecmap/vecmap.dart';

Future<Tile> getTileFromPbf(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  return Tile.fromBuffer(byteData.buffer.asUint8List());
}

Future<Map<String, List<DrawStyle>>> getStyleFromJson(String path) async {
  final jsonString = await rootBundle.loadString('assets/$path');
  final json = jsonDecode(jsonString);
  final style = TileStyle.fromJson(json);
  final generator = DrawStyleGenerator(style);

  return generator.genDrawStyles();
}

class Demo extends StatefulWidget {
  const Demo({
    super.key,
  });

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  List<Tile_Layer> layers = [];
  Map<String, List<DrawStyle>> mapDrawStyles = {};
  @override
  void initState() {
    super.initState();

    print('init state start');

    Future(() async {
      print('read pbf start');
      final Tile tile = await getTileFromPbf('11_1796_811.pbf');
      layers = tile.layers;

      mapDrawStyles = await getStyleFromJson('std.json');
      print('read pbf finish');

      setState(() {});
    });

    print('init state finish');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Widget childWidget;
    if (layers.isEmpty) {
      childWidget = const Text('loading...');
    } else {
      childWidget = CustomPaint(
        painter: MyPainter(layers, mapDrawStyles),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Demo"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: childWidget,
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Tile_Layer> layers;
  Map<String, List<DrawStyle>> mapDrawStyles;
  final double space = 20;
  final Paint _gridPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.black26;

  MyPainter(this.layers, this.mapDrawStyles);

  @override
  void paint(Canvas canvas, Size size) {
    // 原点を画面の中心に設定する
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    canvas.restore();

    // レイヤーを描画
    canvas.save();
    const double scale = 0.15;
    const double offsetTileToCenter = 4096 / 2 * scale;
    canvas.translate((size.width / 2) - offsetTileToCenter, 20); // 画面中央
    canvas.scale(scale, scale);

    Tile_Layer? layer;
    layer = layers.where((layer) => layer.name == 'waterarea').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'wstructurea').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'boundary').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'label').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'elevation').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'river').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'road').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'railway').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'transp').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'landforma').firstOrNull;
    _drawFeatures(canvas, layer);

    layer = layers.where((layer) => layer.name == 'symbol').firstOrNull;
    _drawFeatures(canvas, layer);

    canvas.restore();
  }

  /// 地物の描画
  void _drawFeatures(Canvas canvas, Tile_Layer? layer) {
    if (layer == null) {
      return;
    }

    for (var feature in layer.features) {
      final featureTags = genFeatureTags(layer, feature);
      final drawStyles = mapDrawStyles[layer.name];
      final drawStyle = getDrawStyle(drawStyles, feature, featureTags);
      if (drawStyle == null) {
        // style is not found, do not draw
        return;
      }

      final commands = GeometryCommand.newCommands(feature.geometry);
      switch (feature.type) {
        case Tile_GeomType.POINT:
          _drawPoints(canvas, commands, drawStyle);
          break;
        case Tile_GeomType.LINESTRING:
          _drawStringLine(canvas, commands, drawStyle);
          break;
        case Tile_GeomType.POLYGON:
          _drawPolygon(canvas, commands, drawStyle);
          break;
        default:
      }
    }
  }

  void _drawPoints(
      Canvas canvas, List<GeometryCommand> commands, DrawStyle drawStyle) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Color.fromARGB(255, 0, 140, commands.hashCode);

    for (var command in commands) {
      if (command.commandType == GeometryCommandType.moveTo) {
        Offset offset = Offset(0, 0);
        final offsets = command.commandParameters.map((param) {
          offset = offset.translate(param.x.toDouble(), param.y.toDouble());
          return offset;
        }).toList();

        canvas.drawPoints(PointMode.points, offsets, paint);
      }
    }
  }

  void _drawStringLine(
      Canvas canvas, List<GeometryCommand> commands, DrawStyle drawStyle) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = drawStyle.color;
    final Path path = Path();
    Offset offset = const Offset(0.0, 0.0);

    for (var command in commands) {
      switch (command.commandType) {
        case GeometryCommandType.moveTo:
          offset = _drawGeoMoveTo(path, command.commandParameters, offset);
          break;
        case GeometryCommandType.lineTo:
          offset = _drawGeoLineTo(path, command.commandParameters, offset);
          break;
        case GeometryCommandType.closePath:
          // nop
          break;
        default:
      }
    }

    canvas.drawPath(path, paint);
  }

  void _drawPolygon(
      Canvas canvas, List<GeometryCommand> commands, DrawStyle drawStyle) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0
      ..color = drawStyle.color;
    final Path path = Path();
    Offset offset = const Offset(0.0, 0.0);

    for (var command in commands) {
      switch (command.commandType) {
        case GeometryCommandType.moveTo:
          offset = _drawGeoMoveTo(path, command.commandParameters, offset);
          break;
        case GeometryCommandType.lineTo:
          offset = _drawGeoLineTo(path, command.commandParameters, offset);
          break;
        case GeometryCommandType.closePath:
          path.close();
          break;
        default:
      }
    }

    canvas.drawPath(path, paint);
  }

  Offset _drawGeoMoveTo(Path path, List<Point<int>> cmdParams, Offset offset) {
    Offset curOffset = offset;

    for (var param in cmdParams) {
      curOffset = curOffset.translate(param.x.toDouble(), param.y.toDouble());
      path.moveTo(curOffset.dx, curOffset.dy);
    }

    return curOffset;
  }

  Offset _drawGeoLineTo(Path path, List<Point<int>> cmdParams, Offset offset) {
    Offset curOffset = offset;

    for (var param in cmdParams) {
      curOffset = curOffset.translate(param.x.toDouble(), param.y.toDouble());
      path.lineTo(curOffset.dx, curOffset.dy);
    }

    return curOffset;
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawGridRight(canvas, size);

    canvas.save();
    canvas.scale(1, -1);
    _drawGridRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1);
    _drawGridRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);
    _drawGridRight(canvas, size);
    canvas.restore();
  }

  void _drawGridRight(Canvas canvas, Size size) {
    // キャンパスの保存
    canvas.save();

    // 縦線を描く
    for (int i = 0; i < size.width / 2 / space; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(space, 0);
    }

    // キャンパスリセット（原点リセット）
    canvas.restore();
    canvas.save();

    // 横線を描く
    for (int i = 0; i < size.height / 2 / space; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, space);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
