import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vecmap/model/style.dart';
import 'dart:io';

Future<String> loadJsonString(String path) async {
  final File file = File(path);
  return await file.readAsString();
}

void main() {
  test('read test json', () async {
    final jsonString = await loadJsonString('./style/test.json');
    final json = jsonDecode(jsonString);
    final style = TileStyle.fromJson(json);
    expect(style.title, '標準地図');
    print(style.group);
    print(style.list);
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
              '水域', [TileStyleElement.layer('水域', null, null)])
        ]),
        TileStyleElement.directory('fugafuga', [
          TileStyleElement.item(
              '緑地', [TileStyleElement.layer('緑地', null, null)])
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
            {'type': 'layer', 'title': '水域'}
          ]
        }),
        TileStyleElement.item(
            '水域', [TileStyleElement.layer('水域', null, null)]));
  });

  test('read layer from json', () async {
    expect(
      TileStyleElement.fromJson(<String, dynamic>{
        'type': 'layer',
        'title': '道路',
        'visible': true,
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
      TileStyleElement.layer('道路', true, [
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

    print(TileStyleElement.layer('42', false, null));
  });
}
