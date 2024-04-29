import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:vecmap/vecmap.dart';

Future<Tile> getTileFromPbf(String path) async {
  final byteData = await rootBundle.load('assets/$path');
  return Tile.fromBuffer(byteData.buffer.asUint8List());
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
  @override
  void initState() {
    super.initState();

    print('init state start');

    Future(() async {
      print('read pbf start');
      final Tile tile = await getTileFromPbf('11_1796_811.pbf');
      layers = tile.layers;
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
        painter: MyPainter(layers),
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
  final double space = 20;
  final Paint _gridPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.black26;

  MyPainter(this.layers);

  @override
  void paint(Canvas canvas, Size size) {
    // 原点を画面の中心に設定する
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    canvas.restore();

    // レイヤーを描画
    canvas.save();
    canvas.scale(1.0, 1.0);
    // for (var layer in layers) {
    //   print('draw layter ${layer.name}');
    //   _drawLayer(path, layer);
    // }
    var layer = layers.where((layer) => layer.name == 'road').first;

    for (var feature in layer.features) {
      _drawFeature(canvas, feature);
    }

    canvas.restore();
  }

  /// 地物の描画
  void _drawFeature(Canvas canvas, Tile_Feature feature) {
    final commands = GeometryCommand.newCommands(feature.geometry);
    Path path = Path();
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
          break;
        default:
      }
    }

    final Paint pathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Color.fromARGB(255, 0, 140, feature.hashCode);
    canvas.drawPath(path, pathPaint);
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
