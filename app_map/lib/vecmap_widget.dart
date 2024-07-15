import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart' hide Point;
import 'package:vecmap/vecmap.dart';

import 'grid_widget.dart';
import 'webapi.dart';
import 'input_latlng_widget.dart';

/// package:latlng 地図の空間座標系
/// 緯度経度から地図の座標を計算したり、その逆を行うために使用する
final _epsg = EPSG4326();

Future<Tile> getTileFromPbf(
  int zoomLevel,
  int x,
  int y,
) async {
  final byteData = await vecMapWebApi.getPbf(zoomLevel, x, y);
  return Tile.fromBuffer(byteData.buffer.asUint8List());
}

Future<Map<String, List<DrawStyle>>> getStyleFromJson(String path) async {
  final jsonString = await rootBundle.loadString('assets/$path');
  final json = jsonDecode(jsonString);
  final style = TileStyle.fromJson(json);
  final generator = DrawStyleGenerator(style);

  return generator.genDrawStyles();
}

Future<Map<String, ui.Image>> generateMapIconImage() async {
  final jsonString = await rootBundle.loadString('assets/map_icons/std.json');
  final Map<String, dynamic> json = jsonDecode(jsonString);
  final Map<String, ui.Image> mapImage = Map();
  for (var key in json.keys) {
    final iconBytes = await rootBundle.load('assets/map_icons/$key.png');
    final image = await decodeImageFromList(iconBytes.buffer.asUint8List());
    mapImage[key] = image;
  }

  return mapImage;
}

class Demo extends StatefulWidget {
  const Demo({
    super.key,
  });

  @override
  State<Demo> createState() => _DemoState();
}

final beginLatlngAkashi = InputLatLng(34.661791, 135.083908);

class _DemoState extends State<Demo> {
  final ValueNotifier<InputLatLng> vnInputLatLng =
      ValueNotifier<InputLatLng>(beginLatlngAkashi);
  final ValueNotifier<Offset> vnPosition = ValueNotifier<Offset>(Offset.zero);
  CustomPainter? painter = null;
  Map<String, ui.Image> _mapIconImage = Map();

  Map<String, List<DrawStyle>> mapDrawStyles = {};
  double zoomLevel = 11.0;

  Future<void> _fetchPbf() async {
    print('read pbf start');
    final lat = vnInputLatLng.value.lat;
    final lng = vnInputLatLng.value.lng;
    final latLng = LatLng.degree(lat, lng);

    final tileIndex = _epsg.toTileIndexZoom(latLng, zoomLevel);
    final Tile tile = await getTileFromPbf(
        zoomLevel.floor(), tileIndex.x.floor(), tileIndex.y.floor());
    print('read pbf finish');

    print('read style');
    mapDrawStyles = await getStyleFromJson('style/std.json');

    print('generate drawer');
    List<VecmapDrawer> drawers = List.empty(growable: true);
    Tile_Layer? layer;
    layer = tile.layers.where((layer) => layer.name == 'waterarea').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer =
        tile.layers.where((layer) => layer.name == 'wstructurea').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'boundary').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'label').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'elevation').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'river').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'road').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'railway').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'transp').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'landforma').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    layer = tile.layers.where((layer) => layer.name == 'symbol').firstOrNull;
    drawers.addAll(_genDrawer(layer));

    painter = MyPainter(drawers, vnPosition: vnPosition);
    vnPosition.value = Offset.zero;

    setState(() {});
  }

  Future<void> _init() async {
    await _initMapIcon();
    await _fetchPbf();
  }

  Future<void> _initMapIcon() async {
    _mapIconImage = await generateMapIconImage();
  }

  List<VecmapDrawer> _genDrawer(Tile_Layer? layer) {
    if (layer == null) {
      return List.empty();
    }

    List<VecmapDrawer> drawers = List.empty(growable: true);
    for (var feature in layer.features) {
      final featureTags = genFeatureTags(layer, feature);
      final drawStyles = mapDrawStyles[layer.name];
      final drawStyle = getDrawStyle(drawStyles, feature, featureTags);

      if (drawStyle == null) {
        // style is not found, do not draw
        // TODO report not found style
        continue;
      }

      final commands = GeometryCommand.newCommands(feature.geometry);
      switch (feature.type) {
        case Tile_GeomType.POINT:
          drawers.add(VecmapPointsDrawer(
              commands, drawStyle, _mapIconImage, featureTags));
          break;
        case Tile_GeomType.LINESTRING:
          drawers.add(VecmapLinestringDrawer(commands, drawStyle));
          break;
        case Tile_GeomType.POLYGON:
          drawers.add(VecmapPolygonDrawer(commands, drawStyle));
          break;
        default:
      }
    }

    return drawers;
  }

  @override
  void initState() {
    vnInputLatLng.addListener(
      // when update vnInputLatLng,  call bellow
      () {
        _fetchPbf();
      },
    );

    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GridWidget(),
        GestureDetector(
          onPanUpdate: (details) {
            vnPosition.value += details.delta;
          },
          child: SizedBox.expand(
            child: CustomPaint(
              painter: painter,
            ),
          ),
        ),
        InputLatlngWidget(
          vnLatLng: vnInputLatLng,
        ),
      ],
    );
  }
}

abstract class VecmapDrawer {
  void vecmapDraw(Canvas canvas);
}

/// https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#4352-example-multi-point
class VecmapPointsDrawer implements VecmapDrawer {
  final Paint paint;
  final TextPainter textPainter;
  final List<Offset> offsets;
  final ui.Image? iconImage;
  final Map<String, Tile_Value> tags;

  factory VecmapPointsDrawer(
    List<GeometryCommand> commands,
    DrawStyle drawStyle,
    Map<String, ui.Image> mapIconImage,
    Map<String, Tile_Value> tags,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = Color.fromARGB(255, 0, 140, commands.hashCode);

    const textStyle =
        TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'NotoSansJP');

    final String? dispText = _genDispText(tags, drawStyle.textInfo);
    print(dispText);

    final textSpan = TextSpan(
      text: dispText,
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100,
    );

    final ui.Image? image;
    if (mapIconImage.containsKey(drawStyle.iconImage)) {
      image = mapIconImage[drawStyle.iconImage];
    } else {
      // print(tags);
      image = null;
    }

    final List<Offset> offsets = List.empty(growable: true);
    for (var command in commands) {
      if (command.commandType == GeometryCommandType.moveTo) {
        Offset offset = Offset(0, 0);
        final itOffsets = command.commandParameters.map((param) {
          offset = offset.translate(param.x.toDouble(), param.y.toDouble());
          return offset;
        });

        offsets.addAll(itOffsets);
      } else {
        // TODO error report
      }
    }

    return VecmapPointsDrawer._(paint, textPainter, offsets, image, tags);
  }

  VecmapPointsDrawer._(
    this.paint,
    this.textPainter,
    this.offsets,
    this.iconImage,
    this.tags,
  );

  @override
  void vecmapDraw(Canvas canvas) {
    // TODO draw internal text of icon

    if (iconImage == null) {
      for (var offset in offsets) {
        textPainter.paint(canvas, offset);
      }
    } else {
      for (var offset in offsets) {
        canvas.drawImage(iconImage!, offset, paint);
        textPainter.paint(canvas, offset);
      }
    }
  }

  static String? _genDispText(
    Map<String, Tile_Value> tags,
    Map<String, dynamic> textInfo,
  ) {
    if (!textInfo.containsKey('text-field')) {
      return null;
    }
    final textField = textInfo['text-field'];

    if (!tags.containsKey(textField)) {
      return null;
    }

    return tags[textField]!.stringValue;
  }
}

/// https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#4353-example-linestring
class VecmapLinestringDrawer implements VecmapDrawer {
  final Paint paint;
  final Path path;

  factory VecmapLinestringDrawer(
    List<GeometryCommand> commands,
    DrawStyle drawStyle,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = drawStyle.lineWidth!.getWidth()
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

    return VecmapLinestringDrawer._(paint, path);
  }

  VecmapLinestringDrawer._(this.paint, this.path);

  @override
  void vecmapDraw(Canvas canvas) {
    canvas.drawPath(path, paint);
  }
}

/// https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#4355-example-polygon
class VecmapPolygonDrawer implements VecmapDrawer {
  final Paint paint;
  final Path path;

  factory VecmapPolygonDrawer(
    List<GeometryCommand> commands,
    DrawStyle drawStyle,
  ) {
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

    return VecmapPolygonDrawer._(paint, path);
  }

  VecmapPolygonDrawer._(this.paint, this.path);

  @override
  void vecmapDraw(Canvas canvas) {
    canvas.drawPath(path, paint);
  }
}

/// vecmap drawer helper
Offset _drawGeoMoveTo(Path path, List<Point<int>> cmdParams, Offset offset) {
  Offset curOffset = offset;

  for (var param in cmdParams) {
    curOffset = curOffset.translate(param.x.toDouble(), param.y.toDouble());
    path.moveTo(curOffset.dx, curOffset.dy);
  }

  return curOffset;
}

/// vecmap drawer helper
Offset _drawGeoLineTo(Path path, List<Point<int>> cmdParams, Offset offset) {
  Offset curOffset = offset;

  for (var param in cmdParams) {
    curOffset = curOffset.translate(param.x.toDouble(), param.y.toDouble());
    path.lineTo(curOffset.dx, curOffset.dy);
  }

  return curOffset;
}

class MyPainter extends CustomPainter {
  final List<VecmapDrawer> drawers;
  final ValueNotifier<Offset> vnPosition;

  MyPainter(this.drawers, {required this.vnPosition})
      : super(repaint: vnPosition) {
    vnPosition.addListener(() {});
  }

  @override
  void paint(Canvas canvas, Size size) {
    // レイヤーを描画
    canvas.save();

    // タイルを画面収まるように縮小/拡大するため倍率を計算する
    final double tileSize = 4096.0; // タイル(正方形)の1辺の長さ
    // final double scale = min(size.width, size.height) / tileSize;
    final double scale = 0.55;

    // MAPが画面中央に表示されるように原点を設定する
    final double offsetTileToCenter = tileSize / 2.0 * scale;
    canvas.translate((size.width / 2.0) - offsetTileToCenter, 20.0);

    // タッチによる移動
    canvas.translate(vnPosition.value.dx, vnPosition.value.dy);

    canvas.scale(scale, scale);

    // タイルを描画
    for (var drawer in drawers) {
      drawer.vecmapDraw(canvas);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
