import 'package:flutter/material.dart';
import 'vecmap_widget.dart';
import 'package:latlng/latlng.dart' hide Point;

class VecmapController {
  static const double zoomLvUnit = 1.0;
  static const double zoomLvMax = 14.0;
  static const double zoomLvMin = 9.0;
  static const double tileSize = 4096.0;

  final ValueNotifier<LatLng> vnLatLng;
  final ValueNotifier<double> vnZoomLevel;
  final ValueNotifier<MapStatus> vnMapStatus;

  TileIndex _tileIndex;

  VecmapController(
    this.vnLatLng,
    this.vnZoomLevel,
    this.vnMapStatus,
    this._tileIndex,
  );

  /// delta
  ///  - move left to right: delta.x is minus
  ///  - move right to left: delta.x is plus
  ///  - move down to up   : delta.y is minus
  ///  - move up to down   : delta.y is plus
  void move(Offset delta) {
    final scaledDelta = _newScaledDelta(delta);
    final newDelta = vnMapStatus.value.delta + scaledDelta;
    final newMapStatus = vnMapStatus.value.copyWith(delta: newDelta);
    vnMapStatus.value = newMapStatus;

    // update tileIndex
    // inverse delta
    _tileIndex = _addDeltaToTileIndex(-scaledDelta);

    // update latlng
    vnLatLng.value = epsg.toLatLngZoom(_tileIndex, vnZoomLevel.value);
  }

  void zoom(Offset scrollDelta) {
    const double scaleUnit = 0.01;
    const double scaleMax = 1.15;
    const double scaleMin = 0.85;

    final deltaY;
    if (scrollDelta.dy > 0.0) {
      deltaY = -scaleUnit;
    } else {
      deltaY = scaleUnit;
    }

    /// new scale
    final scale = vnMapStatus.value.scale + deltaY;

    /// zoom out
    if (scale < scaleMin) {
      final double zoomLevel = vnZoomLevel.value;

      if (zoomLevel >= zoomLvMin) {
        _updateTileIndexWhenZoomOut();
        _zoomOut();
        _updateScale(scaleMax);
      }

      return;
    }

    /// zoom in
    if (scale > scaleMax) {
      final double zoomLevel = vnZoomLevel.value;

      if (zoomLevel <= zoomLvMax) {
        _updateTileIndexWhenZoomIn();
        _zoomIn();
        _updateScale(scaleMin);
      }

      return;
    }

    /// only change scale
    _updateScale(scale);
  }

  void moveToCurLatLng() {
    final lat = vnLatLng.value.latitude.degrees;
    final lng = vnLatLng.value.longitude.degrees;
    final latLng = LatLng.degree(lat, lng);

    final index = epsg.toTileIndexZoom(latLng, vnZoomLevel.value);
    final tilePixelX = index.x % 1;
    final tilePixelY = index.y % 1;

    final newDelta = Offset(tileSize * tilePixelX, tileSize * tilePixelY);

    /// inverse delta to convert camera position.
    final newMapStatus = vnMapStatus.value.copyWith(delta: -newDelta);
    vnMapStatus.value = newMapStatus;
  }

  void moveToCurPos() {
    final tilePixelX = _tileIndex.x % 1;
    final tilePixelY = _tileIndex.y % 1;

    final newDelta = Offset(tileSize * tilePixelX, tileSize * tilePixelY);

    /// inverse delta to convert camera position.
    final newMapStatus = vnMapStatus.value.copyWith(delta: -newDelta);
    vnMapStatus.value = newMapStatus;
  }

  Offset _newScaledDelta(Offset delta) {
    final scale = vnMapStatus.value.scale;
    return Offset(delta.dx / scale, delta.dy / scale);
  }

  TileIndex _addDeltaToTileIndex(Offset delta) {
    final x = _tileIndex.x + (delta.dx / tileSize);
    final y = _tileIndex.y + (delta.dy / tileSize);
    final index = TileIndex(x, y);
    return index;
  }

  void _zoomOut() {
    final double zoomLevel = vnZoomLevel.value;
    vnZoomLevel.value = zoomLevel - zoomLvUnit;
  }

  void _zoomIn() {
    final double zoomLevel = vnZoomLevel.value;
    vnZoomLevel.value = zoomLevel + zoomLvUnit;
  }

  void _updateScale(double scale) {
    final newMapStatus = vnMapStatus.value.copyWith(scale: scale);
    vnMapStatus.value = newMapStatus;
  }

  void _updateTileIndexWhenZoomIn() {
    //3584.3756031999997, 1627.4779705571025
    final double newZoomlevel = vnZoomLevel.value + zoomLvUnit;
    final latlng = epsg.toLatLngZoom(_tileIndex, vnZoomLevel.value);
    _tileIndex = epsg.toTileIndexZoom(latlng, newZoomlevel);
  }

  void _updateTileIndexWhenZoomOut() {
    final double newZoomlevel = vnZoomLevel.value - zoomLvUnit;
    final latlng = epsg.toLatLngZoom(_tileIndex, vnZoomLevel.value);
    _tileIndex = epsg.toTileIndexZoom(latlng, newZoomlevel);
  }
}
