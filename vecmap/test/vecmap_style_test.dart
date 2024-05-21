import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vecmap/model/style.dart';
import 'dart:io';

Future<String> _loadJsonString(String path) async {
  final File file = File(path);
  return await file.readAsString();
}

void main() {
  test('read test json', () async {
    final jsonString = await _loadJsonString('./style/test.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);
    expect(style.title, '標準地図');
    print(style.group);
    print(style.list);
  });

  test('read group from json', () async {
    expect(
        TileStyleGroup.fromJson(<String, dynamic>{
          'id': 'back',
          'title': '道路等より下に描画',
          'zoom': [1, 2, 3],
          'filter': [
            ["==", "line-role", "outline"]
          ]
        }),
        TileStyleGroup(id: 'back', title: '道路等より下に描画', zoom: [
          1,
          2,
          3
        ], filter: [
          ['==', "line-role", "outline"]
        ]));
  });

  test('read directory from json', () async {
    expect(
      TileStyleElement.fromJson(<String, dynamic>{
        'type': 'directory',
        'title': '地形',
        'list': [
          {
            'type': 'directory',
            'title': 'hogehoge',
            'list': [
              {
                'type': 'item',
                'title': '水域',
                'list': [
                  {'type': 'layer', 'title': '水域'}
                ]
              }
            ]
          },
          {
            'type': 'directory',
            'title': 'fugafuga',
            'list': [
              {
                'type': 'item',
                'title': '緑地',
                'list': [
                  {'type': 'layer', 'title': '緑地'}
                ]
              }
            ]
          }
        ]
      }),
      TileStyleElement.directory('地形', [
        TileStyleElement.directory('hogehoge', [
          TileStyleElement.item(
              '水域', [TileStyleElement.layer('水域', null, 1, 10, null, null)])
        ]),
        TileStyleElement.directory('fugafuga', [
          TileStyleElement.item(
              '緑地', [TileStyleElement.layer('緑地', null, 1, 10, null, null)])
        ])
      ]),
    );
  });

  test('read item from json', () async {
    expect(
        TileStyleElement.fromJson(<String, dynamic>{
          'type': 'item',
          'title': '水域',
          'list': [
            {'type': 'layer', 'title': '水域', 'minzoom': 1, 'maxzoom': 10}
          ]
        }),
        TileStyleElement.item(
            '水域', [TileStyleElement.layer('水域', null, 1, 10, null, null)]));
  });

  test('read layer from json', () async {
    expect(
      TileStyleElement.fromJson(<String, dynamic>{
        'type': 'layer',
        'title': '道路',
        'visible': true,
        'minzoom': 1,
        'maxzoom': 10,
        'source-layer': 'hogehoge',
        'list': [
          {
            'type': 'fill',
            'visible': true,
            'source-layer': "hogehoge",
            'draw': {
              'fill-color': 'red',
              'fill-style': 'fill',
            }
          }
        ]
      }),
      TileStyleElement.layer('道路', true, 1, 10, 'hogehoge', [
        TileStyleDraw(
            type: 'fill',
            visible: true,
            sourceLayer: 'hogehoge',
            draw: {
              'fill-color': 'red',
              'fill-style': 'fill',
            })
      ]),
    );

    print(TileStyleElement.layer('42', false, 1, 10, null, null));
  });

  test('get item', () async {
    final jsonString = await _loadJsonString('./style/test.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);

    final item = getTileStyleItem(style, '水域');
    if (item == null) {
      return;
    }
    expect(item.title, '水域');

    for (var element in item.list) {
      final layer = element as TileStyleLayer;
      print(layer);
    }
  });

  test('get item titles few data', () async {
    final jsonString = await _loadJsonString('./style/test.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);

    final titles = getItemNamesFromStyle(style);
    assert(titles.isNotEmpty);

    expect(titles[0], '水域');
    expect(titles[1], '高層建物');
    expect(titles[2], '高層建物（外周線）');
  });

  test('get item titles many data', () async {
    final jsonString = await _loadJsonString('./style/std.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);

    final mapNameItem = getItemNamesFromStyle(style);
    assert(mapNameItem.isNotEmpty);

    final file = File("./test/item_titles.txt");
    if (!await file.exists()) {
      await file.create();
      await file.writeAsString(mapNameItem.keys.join('\r\n'));
    } else {
      await file.writeAsString(mapNameItem.keys.join('\r\n'));
    }

    // expect(titles, ['水域']);
  });

  test('get draws', () async {
    final layer = TileStyleElement.layer('道路', true, 1, 10, null, [
      TileStyleDraw(
          type: 'fill',
          visible: true,
          sourceLayer: 'hogehoge',
          draw: {
            'fill-color': 'red',
            'fill-style': 'fill',
          })
    ]) as TileStyleLayer;

    final draw = getTileStyleDrawFromLayer(layer).first;
    expect(draw.type, 'fill');
  });
}
