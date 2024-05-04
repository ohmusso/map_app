import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'style.freezed.dart';
part 'style.g.dart';

@freezed
class TileStyle with _$TileStyle {
  const TileStyle._();
  const factory TileStyle({
    required String title,
    required List<TileStyleGroup> group,
    required List<TileStyleElement> list,
    // required String list,
  }) = _TileStyle;

  factory TileStyle.fromJson(Map<String, dynamic> json) =>
      _$TileStyleFromJson(json);
}

@freezed
class TileStyleGroup with _$TileStyleGroup {
  const TileStyleGroup._();
  const factory TileStyleGroup({
    required String id,
    required String title,
  }) = _TileStyleGroup;

  factory TileStyleGroup.fromJson(Map<String, dynamic> json) =>
      _$TileStyleGroupFromJson(json);
}

@Freezed(unionKey: 'type')
class TileStyleElement with _$TileStyleElement {
  const factory TileStyleElement.item(
      String title, List<TileStyleElement> list) = TileStyleItem;
  const factory TileStyleElement.layer(String? title, bool? visible) =
      TileStyleLayer;

  factory TileStyleElement.fromJson(Map<String, dynamic> json) =>
      _$TileStyleElementFromJson(json);
}
