import 'package:latlng/latlng.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final epsg = EPSG4326();
  test('latlang', () async {
    final latlng = LatLng.degree(34.661791, 135.083908); // akashi
    final index = epsg.toTileIndexZoom(latlng, 11);
    print(index.x);
    print(index.y);
  });
}
