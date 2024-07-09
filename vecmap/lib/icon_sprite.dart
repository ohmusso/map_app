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
  Uint8List? generateIconBytes(String iconImageName) {
    if (_image == null) {
      return null;
    }

    if (_spriteJson.containsKey(iconImageName) == false) {
      return null;
    }

    final value = _spriteJson[iconImageName];
    final x = value['x'];
    final y = value['y'];
    final width = value['width'];
    final height = value['height'];
    final cropedImg =
        img.copyCrop(_image, x: x, y: y, width: width, height: height);
    return img.encodePng(cropedImg);
  }
}
