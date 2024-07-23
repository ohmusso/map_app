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

    final drawStyles = mapDrawStyles[layer.name];

    List<VecmapDrawer> drawers = List.empty(growable: true);
    for (var feature in layer.features) {
      final featureTags = genFeatureTags(layer, feature);
      final styles = getDrawStyles(drawStyles, zoomLevel, feature, featureTags);

      if (styles.isEmpty) {
        // style is not found, do not draw
        // TODO report not found style
        continue;
      }

      final commands = GeometryCommand.newCommands(feature.geometry);
      switch (feature.type) {
        case Tile_GeomType.POINT:
          for (var style in styles) {
            drawers.add(VecmapPointsDrawer(
                commands, style, _mapIconImage, featureTags));
          }
          break;
        case Tile_GeomType.LINESTRING:
          for (var style in styles) {
            drawers.add(VecmapLinestringDrawer(commands, style));
          }
          break;
        case Tile_GeomType.POLYGON:
          for (var style in styles) {
            drawers.add(VecmapPolygonDrawer(commands, style));
          }
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

class _LineDash {
  final double solidLen;
  final double spanLen;
  final double totalLen;
  const _LineDash(this.solidLen, this.spanLen) : totalLen = solidLen + spanLen;

  /// https://docs.mapbox.com/style-spec/reference/layers/#paint-line-line-dasharray
  static List<_LineDash> genListFromDashArray(
      List<double> dashArray, double lineWidth) {
    if (dashArray.isEmpty) {
      return List.empty();
    }

    if ((dashArray.length % 2) != 0) {
      return List.empty();
    }

    /// TODO is there better way? join 2 element to 1 element
    final listLen = dashArray.length ~/ 2;
    return List.generate(listLen, (int i) {
      final i2 = i * 2;
      final solidLen = dashArray[i2] * lineWidth;
      final spanLen = dashArray[i2 + 1] * lineWidth;
      return _LineDash(solidLen, spanLen);
    });
  }
}

class _MapTextPainter {
  final TextPainter? textPainter;
  final Offset textOffset;

  factory _MapTextPainter(
    String? dispText,
    Color dispTextColor,
    Map<String, Tile_Value> tags,
    DrawStyle drawStyle,
    ui.Image? image,
  ) {
    if (dispText == null) {
      return _MapTextPainter.NoPaint();
    }

    final textStyle =
        TextStyle(color: dispTextColor, fontSize: 20, fontFamily: 'NotoSansJP');

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

    /// adjust scale of textOffset
    Offset textOffset = Offset.zero;
    textOffset = _addTextOffset(textOffset, drawStyle.textOffset);
    textOffset = _addDspPos(textOffset, tags['dspPos'], textPainter, image);

    return _MapTextPainter._(textPainter, textOffset);
  }

  _MapTextPainter._(this.textPainter, this.textOffset);
  _MapTextPainter.NoPaint()
      : textPainter = null,
        textOffset = Offset.zero;

  void paint(Canvas canvas, Offset offset) {
    if (textPainter != null) {
      textPainter!.paint(canvas, offset + textOffset);
    }
  }

  static Offset _addTextOffset(
    Offset offset,
    TextOffset? textOffset,
  ) {
    if (textOffset == null) {
      return offset;
    }

    return offset.translate(textOffset.x, textOffset.y);
  }

  static Offset _addDspPos(
    Offset offset,
    Tile_Value? dspPos,
    TextPainter textPainter,
    ui.Image? image,
  ) {
    if (dspPos == null) {
      return offset;
    }

    if (image == null) {
      return offset;
    }

    double textWidthHalf = textPainter.width / 2.0;
    double textHeightHalf = textPainter.height / 2.0;
    double imageWidth = image.width.toDouble();
    double imageheight = image.height.toDouble();

    /// dspPos
    /// RB--CB--LB
    /// |   |   |
    /// RC--CC--LC
    /// |   |   |
    /// RT--CT--LT
    final double dx;
    final double dy;
    switch (dspPos.stringValue) {
      case 'LT':
        dx = imageWidth;
        dy = imageheight;
        break;
      case 'CT':
        dx = imageWidth / 2.0;
        dy = imageheight;
        break;
      case 'RT':
        dx = 0.0;
        dy = imageheight;
        break;
      case 'LC':
        dx = imageWidth;
        dy = imageheight / 2.0;
        break;
      case 'CC':
        dx = (imageWidth / 2.0) - textWidthHalf;
        dy = (imageheight / 2.0) - textHeightHalf;
        break;
      case 'RC':
        dx = 0.0;
        dy = imageheight / 2.0;
        break;
      case 'LB':
        dx = imageWidth;
        dy = 0.0;
        break;
      case 'CB':
        dx = imageWidth / 2.0;
        dy = 0.0;
        break;
      case 'RB':
      default:
        dx = 0.0;
        dy = 0.0;
        break;
    }

    return offset.translate(dx, dy);
  }
}

abstract class VecmapDrawer {
  void vecmapDraw(Canvas canvas);
}

/// https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md#4352-example-multi-point
class VecmapPointsDrawer implements VecmapDrawer {
  final Paint paint;
  final List<Offset> offsets;
  final ui.Image? iconImage;
  final _MapTextPainter mapTextPainter;
  final Map<String, Tile_Value> tags;

  factory VecmapPointsDrawer(
    List<GeometryCommand> commands,
    DrawStyle drawStyle,
    Map<String, ui.Image> mapIconImage,
    Map<String, Tile_Value> tags,
  ) {
    // TODO use to draw image.
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 10.0
      ..color = Colors.blueAccent;

    /// image
    final ui.Image? image;
    if (mapIconImage.containsKey(drawStyle.iconImage)) {
      image = mapIconImage[drawStyle.iconImage];
    } else {
      // print(tags);
      image = null;
    }

    /// text
    final String? dispText = _genDispText(tags, drawStyle.textInfo);
    final _MapTextPainter mapTextPainter;
    if (dispText != null) {
      mapTextPainter =
          _MapTextPainter(dispText, drawStyle.color, tags, drawStyle, image);
    } else {
      mapTextPainter = _MapTextPainter.NoPaint();
    }

    /// position of symbols
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

    return VecmapPointsDrawer._(paint, offsets, image, mapTextPainter, tags);
  }

  VecmapPointsDrawer._(
    this.paint,
    this.offsets,
    this.iconImage,
    this.mapTextPainter,
    this.tags,
  );

  @override
  void vecmapDraw(Canvas canvas) {
    if (iconImage == null) {
      for (var offset in offsets) {
        mapTextPainter.paint(canvas, offset);
      }
    } else {
      for (var offset in offsets) {
        canvas.drawImage(iconImage!, offset, paint);
        mapTextPainter.paint(canvas, offset);
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

    if (tags[textField]!.hasStringValue()) {
      return tags[textField]!.stringValue;
    }

    if (tags[textField]!.hasIntValue()) {
      return tags[textField]!.intValue.toString();
    }

    return 'error';
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

    if (drawStyle.lineDashArray == null) {
      return VecmapLinestringDrawer._(paint, path);
    } else {
      final dashedPath = _convertDashLine(
          path, drawStyle.lineDashArray!, drawStyle.lineWidth!.getWidth());
      return VecmapLinestringDrawer._(paint, dashedPath);
    }
  }

  VecmapLinestringDrawer._(this.paint, this.path);

  static Path _convertDashLine(
      Path path, List<double> dashArray, double lineWidth) {
    final dashList = _LineDash.genListFromDashArray(dashArray, lineWidth);

    if (dashList.isEmpty) {
      return path;
    }

    final dashLength =
        dashList.map((e) => e.totalLen).reduce((sum, element) => sum + element);
    final ui.PathMetrics pms = path.computeMetrics();
    final Path dashedPath = Path();
    for (var pm in pms) {
      final int dashNum = pm.length ~/ dashLength;
      for (int i = 0; i < dashNum; i++) {
        double curPathLen = dashLength * i;
        for (var dash in dashList) {
          dashedPath.addPath(
              pm.extractPath(curPathLen, curPathLen + dash.solidLen),
              Offset.zero);
          curPathLen += dash.totalLen;
        }
      }

      final double tail = pm.length % dashLength;
      dashedPath.addPath(
          pm.extractPath(pm.length - tail, pm.length), Offset.zero);
    }

    return dashedPath;
  }

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
