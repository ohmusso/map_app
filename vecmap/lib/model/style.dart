import 'package:freezed_annotation/freezed_annotation.dart';

part 'style.freezed.dart';
part 'style.g.dart';

@freezed
class TileStyle with _$TileStyle {
  const TileStyle._();
  const factory TileStyle({
    required String title,
    required List<TileStyleGroup> group,
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
class CustomKey with _$CustomKey {
  const factory CustomKey.item(String title) = _CustomKeyItem;
  const factory CustomKey.layer(String title, bool visible) = _CustomKeyLayer;

  factory CustomKey.fromJson(Map<String, dynamic> json) =>
      _$CustomKeyFromJson(json);
}
