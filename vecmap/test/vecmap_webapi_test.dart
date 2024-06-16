import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:vecmap/vecmap.dart';

import 'vecmap_webapi_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final File file = File('./11_1796_811.pbf');

  test('String.trim() removes surrounding whitespace', () async {
    final client = MockClient();
    final uri =
        Uri.parse('https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap');
    final reqUri = Uri.parse(
        'https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/1/1/1.pbf');

    when(client.get(reqUri)).thenAnswer(
        (_) async => http.Response.bytes(file.readAsBytesSync(), 200));

    final api = VecMapWebApi(client: client, uri: uri);
    final pbf = await api.getPbf(1, 1, 1);
    Tile tile = Tile.fromBuffer(pbf);

    final layer = getLayer(tile, 'boundary');
    expect(layer!.name, 'boundary');
  });
}
