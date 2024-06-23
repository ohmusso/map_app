import 'package:latlng/latlng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final epsg = EPSG4326();
  test('latlang akashi', () async {
    final latlng = LatLng.degree(34.661791, 135.083908); // akashi
    final index = epsg.toTileIndexZoom(latlng, 11);
    print(index.x);
    print(index.y);
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
