import 'dart:typed_data';
import 'package:image/image.dart' as img;

class MapIcon {
  final img.Image? _image;
  final Map<String, dynamic> _spriteJson;
  MapIcon(this._image, this._spriteJson);

  MapIcon.fromPngUint8List(Uint8List bytes, this._spriteJson)
      : _image = img.decodePng(bytes);

  bool isImageExist() {
    return (_image != null);
  }

  /// style icon-image: [iconImageName]
  Uint8List? genPngIconBytes(String iconImageName) {
    if (_image == null) {
      return null;
    }

    if (_spriteJson.containsKey(iconImageName) == false) {
      return null;
    }

    final jsonValue = _spriteJson[iconImageName];
    final x = jsonValue['x'];
    final y = jsonValue['y'];
    final width = jsonValue['width'];
    final height = jsonValue['height'];
    final cropedImg =
        img.copyCrop(_image, x: x, y: y, width: width, height: height);
    return img.encodePng(cropedImg);
  }

  /// style icon-image: [iconImageName]
  img.Image? genPngIconImage(String iconImageName) {
    if (_image == null) {
      return null;
    }

    if (_spriteJson.containsKey(iconImageName) == false) {
      return null;
    }

    final jsonValue = _spriteJson[iconImageName];
    final x = jsonValue['x'];
    final y = jsonValue['y'];
    final width = jsonValue['width'];
    final height = jsonValue['height'];

    return img.copyCrop(_image, x: x, y: y, width: width, height: height);
  }

  /// string: 地図記号の名前, Uint8List: 切り取った地図記号(png形式)
  Map<String, Uint8List>? genMapPngIconImageBytes() {
    if (_image == null) {
      return null;
    }

    final Map<String, Uint8List> mapKeyImageBytes = Map();
    for (var key in _spriteJson.keys) {
      final jsonValue = _spriteJson[key];
      final x = jsonValue['x'];
      final y = jsonValue['y'];
      final width = jsonValue['width'];
      final height = jsonValue['height'];
      final cropedImaage =
          img.copyCrop(_image, x: x, y: y, width: width, height: height);
      mapKeyImageBytes[key] = img.encodePng(cropedImaage);
    }

    return mapKeyImageBytes;
  }
}
