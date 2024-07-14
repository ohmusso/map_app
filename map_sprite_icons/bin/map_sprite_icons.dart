import 'dart:convert';

import 'package:map_sprite_icons/map_sprite_icons.dart' as map_sprite_icons;
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final spriteJsonStr = File('./sprite/std.json').readAsStringSync();
  final spriteJson = jsonDecode(spriteJsonStr);

  final spritePngImg = File('./sprite/std.png').readAsBytesSync();

  final mapIcon =
      map_sprite_icons.MapIcon.fromPngUint8List(spritePngImg, spriteJson);

  final mapkeyImage = mapIcon.genMapPngIconImageBytes();
  if (mapkeyImage == null) {
    print('no image');
    return;
  }

  for (var keyImage in mapkeyImage.entries) {
    final folderName = './../app_map/assets/map_icons';
    final fileName = '$folderName/${keyImage.key}.png';
    final file = File(fileName);
    if (!await file.exists()) {
      await file.create();
    }
    file.writeAsBytesSync(keyImage.value);
  }
}
