import 'package:flutter/material.dart';
import 'vecmap_widget.dart';
import 'package:latlng/latlng.dart' hide Point;

class VecmapController {
  static const double zoomLvUnit = 1.0;
  static const double zoomLvMax = 14.0;
  static const double zoomLvMin = 9.0;

  final ValueNotifier<Offset> vnUsrTilePosition;
  final ValueNotifier<double> vnZoomLevel;
  final ValueNotifier<MapStatus> vnMapStatus;

  VecmapController(
    this.vnUsrTilePosition,
    this.vnZoomLevel,
    this.vnMapStatus,
  );

  void move(Offset delta) {
    final scale = vnMapStatus.value.scale;
    final Offset scaledDelta = Offset(delta.dx / scale, delta.dy / scale);
    final newDelta = vnMapStatus.value.delta + scaledDelta;
    final newMapStatus = vnMapStatus.value.copyWith(delta: newDelta);
    vnMapStatus.value = newMapStatus;
  }

  void zoom(Offset scrollDelta) {
    const double scaleUnit = 0.1;
    const double scaleMax = 1.2;
    const double scaleMin = 0.2;

    final deltaY;
    if (scrollDelta.dy > 0) {
      deltaY = -scaleUnit;
    } else {
      deltaY = scaleUnit;
    }

    /// new scale
    final scale = vnMapStatus.value.scale + deltaY;

    /// zoom out
    if (scale < scaleMin) {
      final isZoomChange = _zoomOut();

      if (isZoomChange) {
        _updateScale(scaleMax);
      }
      return;
    }

    /// zoom in
    if (scale > scaleMax) {
      final isZoomChange = _zoomIn();

      if (isZoomChange) {
        _updateScale(scaleMin);
      }
      return;
    }

    /// only change scale
    _updateScale(scale);
  }

  bool _zoomOut() {
    bool isChange = false;
    final double zoomLevel = vnZoomLevel.value;
    if (zoomLevel >= zoomLvMin) {
      vnZoomLevel.value = zoomLevel - zoomLvUnit;
      isChange = true;
    }

    return isChange;
  }

  bool _zoomIn() {
    bool isChange = false;
    final double zoomLevel = vnZoomLevel.value;
    if (zoomLevel <= zoomLvMax) {
      vnZoomLevel.value = zoomLevel + zoomLvUnit;
      isChange = true;
    }

    return isChange;
  }

  void _updateScale(double scale) {
    final newMapStatus = vnMapStatus.value.copyWith(scale: scale);
    vnMapStatus.value = newMapStatus;
  }
}
