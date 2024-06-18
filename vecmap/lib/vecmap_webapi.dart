import 'dart:typed_data';
import 'package:http/http.dart' as http;

class VecMapWebApi {
  VecMapWebApi({
    required http.Client client,
    required Uri uri,
  })  : _client = client,
        _uri = uri;

  final http.Client _client;
  final Uri _uri;

// https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/{zoomlevel}/{x}/{y}.pbf
  Future<Uint8List> getPbf(int zoomLevel, int x, int y) async {
    final Uri reqUri = Uri(
      scheme: _uri.scheme,
      host: _uri.host,
      path: '${_uri.path}/$zoomLevel/$x/$y.pbf',
    );

    final res = await _client.get(reqUri);

    if (res.statusCode != 200) {
      throw Exception(res.statusCode);
    }

    return res.bodyBytes;
  }

  void dispose() {
    _client.close();
  }
}
