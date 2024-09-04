import 'package:latlng/latlng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final epsg = EPSG4326();
  test('latlang akashi', () async {
    final latlng = LatLng.degree(34.634801, 135.033012); // akashi
    var index = epsg.toTileIndexZoom(latlng, 11);
    print(index.x);
    print(index.y);

    index = epsg.toTileIndexZoom(latlng, 12);
    print(index.x);
    print(index.y);
  });

  test('latlng akashi from tileindex', () async {
    final index = TileIndex(1792.477343288889, 813.5523424441678); // akashi
    final latlng = epsg.toLatLngZoom(index, 11);
    print(latlng.latitude);
    print(latlng.longitude);
  });

  test('latlang akashi tileindex', () async {
    final latlng = LatLng.degree(34.661791, 135.083908); // akashi
    final tileIndex = epsg.toTileIndex(latlng);
    print(tileIndex.x);
    print(tileIndex.y);
  });

  test('calc latlng from map delta', () async {
    const double tileSize = 4096.0;
    // akashi
    final tileIndexX = 1792.0;
    final tileIndexY = 813.0;
    // current map delta
    final mapDeltaX = tileSize / 2.0; // 50%
    final mapDeltaY = tileSize / 2.0; // 50%
    // tile pixel from map delta
    final tilePixelX = mapDeltaX / tileSize;
    final tilePixelY = mapDeltaY / tileSize;

    final x = tileIndexX + tilePixelX;
    final y = tileIndexY + tilePixelY;
    print('$x,$y');

    final index = TileIndex(x, y);
    print(index.x);
    print(index.y);

    final latlng = epsg.toLatLngZoom(index, 11);
    print(latlng.latitude);
    print(latlng.longitude);
  });

  test('latlang skytree', () async {
    final latlng = LatLng.degree(35.709529, 139.810713); // skytree
    final index = epsg.toTileIndexZoom(latlng, 15);
    print(index.x);
    print(index.y);

    final tileIndexX = index.x.floor();
    final tileIndexY = index.y.floor();
    final tilePixelX = index.x % 1;
    final tilePixelY = index.y % 1;
    print(tileIndexX);
    print(tileIndexY);
    print(tilePixelX);
    print(tilePixelY);
  });
}
