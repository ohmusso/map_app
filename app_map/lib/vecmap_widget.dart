import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart' hide Point;
import 'package:vecmap/vecmap.dart';

import 'grid_widget.dart';
import 'webapi.dart';
import 'input_latlng_widget.dart';

/// TODO draw feature in order by group id

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

Future<VecmapDrawStyle> getStyleFromJson(String path) async {
  final jsonString = await rootBundle.loadString('assets/$path');
  final json = jsonDecode(jsonString);
  final style = TileStyle.fromJson(json);
  final generator = DrawStyleGenerator(style);

  return generator.genVecmapDrawStyle();
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

const _initZoomLevel = 11.0;
final beginLatlngAkashi = InputLatLng(34.661791, 135.083908);

class _DemoState extends State<Demo> {
  final ValueNotifier<InputLatLng> vnInputLatLng =
      ValueNotifier<InputLatLng>(beginLatlngAkashi);
  final ValueNotifier<double> vnZoomLevel =
      ValueNotifier<double>(_initZoomLevel);
  final ValueNotifier<MapStatus> vnMapStatus =
      ValueNotifier<MapStatus>(const MapStatus.init());
  CustomPainter? painter = null;
  Map<String, ui.Image> _mapIconImage = Map();

  VecmapDrawStyle vecmapDrawStyle = VecmapDrawStyle.NoStyle();

  Future<void> _fetchStyle() async {
    print('read style');
    vecmapDrawStyle = await getStyleFromJson('style/std.json');
  }

  Future<void> _fetchPbf() async {
    print('read pbf start');
    final lat = vnInputLatLng.value.lat;
    final lng = vnInputLatLng.value.lng;
    final latLng = LatLng.degree(lat, lng);
    // TODO
    // final double zoomLevel = vnMapStatus.value.zoomLevel;
    final double zoomLevel = vnZoomLevel.value;

    final tileIndex = _epsg.toTileIndexZoom(latLng, zoomLevel);
    final Tile tile = await getTileFromPbf(
        zoomLevel.floor(), tileIndex.x.floor(), tileIndex.y.floor());
    print('read pbf finish');

    print('generate drawer');
    final drawersGroup = VecmapDrawersGroup(vecmapDrawStyle.groupIds);
    for (var layer in tile.layers) {
      final drawStyles = vecmapDrawStyle.styles[layer.name];

      if (drawStyles == null) {
        continue;
      }

      for (var feature in layer.features) {
        final featureTags = genFeatureTags(layer, feature);
        final styles =
            getDrawStyles(drawStyles, zoomLevel, feature, featureTags);
        final commands = GeometryCommand.newCommands(feature.geometry);

        for (var style in styles) {
          final drawer = _genDrawer(style, commands, featureTags);
          if (drawer != null) {
            for (var groupId in style.groupIds)
              drawersGroup.add(groupId, drawer);
          }
        }
      }
    }

    painter = MyPainter(drawersGroup, vnMapStatus: vnMapStatus);
    vnMapStatus.value = vnMapStatus.value.copyWith(position: Offset.zero);

    setState(() {});
  }

  Future<void> _init() async {
    await _initMapIcon();
    await _fetchStyle();
    await _fetchPbf();
  }

  Future<void> _initMapIcon() async {
    _mapIconImage = await generateMapIconImage();
  }

  VecmapDrawer? _genDrawer(DrawStyle style, List<GeometryCommand> commands,
      Map<String, Tile_Value> featureTags) {
    switch (style.drawType) {
      case 'fill':
        return VecmapPolygonDrawer(commands, style);
      case 'line':
        return VecmapLinestringDrawer(commands, style);
      case 'symbol':
        return VecmapPointsDrawer(commands, style, _mapIconImage, featureTags);
      default:
        break;
    }

    return null;
  }

  @override
  void initState() {
    vnInputLatLng.addListener(
      // when update vnInputLatLng, call bellow
      () {
        _fetchPbf();
      },
    );

    vnZoomLevel.addListener(
        // when update zoomlevel, call bellow
        () {
      _fetchPbf();
    });

    _init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GridWidget(),
        Listener(
          onPointerMove: _onPointerMove,
          onPointerSignal: _onPointerSignal,
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

  void _onPointerMove(PointerMoveEvent event) {
    Offset delta = event.delta;
    print(delta);
    final newPosition = vnMapStatus.value.position + delta;
    final newMapStatus = vnMapStatus.value.copyWith(position: newPosition);
    vnMapStatus.value = newMapStatus;
  }

  void _onPointerSignal(PointerSignalEvent event) {
    const double scaleUnit = 0.1;
    if (event is PointerScrollEvent) {
      final deltaY;
      if (event.scrollDelta.dy > 0) {
        deltaY = -scaleUnit;
      } else {
        deltaY = scaleUnit;
      }

      final newScale = vnMapStatus.value.scale.update(deltaY);

      if (newScale.value > 1.4) {
        /// TODO inc zoomlevel
        print('inc zoomlevel');
      } else if (newScale.value < 0.3) {
        /// TODO dec zoomlevel
        print('dec zoomlevel');
      } else {
        /// nop
      }

      final newMapStatus = vnMapStatus.value.copyWith(scale: newScale);
      vnMapStatus.value = newMapStatus;
    }
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

class VecmapDrawersGroup {
  final Map<String, List<VecmapDrawer>> group = {};

  /// sorted by drawing order
  final List<String> groupIds;

  VecmapDrawersGroup(this.groupIds);
  VecmapDrawersGroup.None() : groupIds = [];

  void add(final String groupId, final VecmapDrawer drawer) {
    if (group.containsKey(groupId)) {
      group[groupId]!.add(drawer);
    } else {
      group[groupId] = List.empty(growable: true);
      group[groupId]!.add(drawer);
    }
  }
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
    if (drawStyle.drawType == 'symbol') {
      return VecmapLinestringDrawer._(Paint(), Path());
    }

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

class MapStatus {
  final Offset position;
  final PainterScale scale;

  const MapStatus({required this.position, required this.scale});
  const MapStatus.init()
      : position = Offset.zero,
        scale = PainterScale.init;

  MapStatus copyWith({Offset? position, PainterScale? scale}) {
    return MapStatus(
      position: position ?? this.position,
      scale: scale ?? this.scale,
    );
  }
}

class PainterScale {
  static const double max = 1.5;
  static const double min = 0.2;
  final double value;
  const PainterScale(this.value);

  static const init = const PainterScale(0.5);

  PainterScale update(double delta) {
    final value = this.value + delta;

    if (value < min) {
      return PainterScale(min);
    }

    if (value > max) {
      return PainterScale(max);
    }

    return PainterScale(value);
  }
}

class MyPainter extends CustomPainter {
  PainterScale scale = PainterScale.init;
  final VecmapDrawersGroup drawersGroup;
  final ValueNotifier<MapStatus> vnMapStatus;

  MyPainter(this.drawersGroup, {required this.vnMapStatus})
      : super(repaint: vnMapStatus) {
    // vnMapStatus.addListener(() {});
  }

  @override
  void paint(Canvas canvas, Size size) {
    // レイヤーを描画
    canvas.save();

    // タイルを画面収まるように縮小/拡大するため倍率を計算する
    scale = vnMapStatus.value.scale;

    // TODO 原点は画面の中央
    // MAPが画面中央に表示されるように原点を設定する
    final double tileSize = 4096.0; // タイル(正方形)の1辺の長さ
    final double offsetTileToCenter = tileSize / 2.0 * scale.value;
    canvas.translate((size.width / 2.0) - offsetTileToCenter, 20.0);

    // タッチによる移動
    final position = vnMapStatus.value.position;
    canvas.translate(position.dx, position.dy);

    canvas.scale(scale.value, scale.value);

    /// タイルを描画
    /// groupIdの先頭から描画する。
    for (var groupId in drawersGroup.groupIds) {
      final drawers = drawersGroup.group[groupId];
      if (drawers == null) {
        continue;
      }

      for (var drawer in drawers) {
        drawer.vecmapDraw(canvas);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
