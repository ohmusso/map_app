import 'dart:typed_data';
import 'package:http/http.dart' as http;

class VecMapWebApi {
  VecMapWebApi({
    required this.client,
    required this.uri,
  });

  final http.Client client;
  final Uri uri;

// https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/{zoomlevel}/{x}/{y}.pbf
  Future<Uint8List> getPbf(int zoomLevel, int x, int y) async {
    final Uri reqUri = Uri(
      scheme: uri.scheme,
      host: uri.host,
      path: '${uri.path}/$zoomLevel/$x/$y.pbf',
    );

    final res = await client.get(reqUri);

    if (res.statusCode != 200) {
      throw Exception(res.statusCode);
    }

    return res.bodyBytes;
  }

  void dispose() {
    client.close();
  }
}
