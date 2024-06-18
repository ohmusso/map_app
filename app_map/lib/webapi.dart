import 'package:vecmap/vecmap.dart';
import 'package:http/http.dart' as http;

final Uri _uriVecmapWebApi =
    Uri.parse('https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap');
final VecMapWebApi vecMapWebApi = VecMapWebApi(
  client: http.Client(),
  uri: _uriVecmapWebApi,
);
