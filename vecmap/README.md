# vecmap

decode vector tile in japan land map.

## referrence

<https://github.com/mapbox/vector-tile-spec/blob/master/2.1/README.md>
<https://maps.gsi.go.jp/development/ichiran.html>
<https://github.com/gsi-cyberjapan/gsimaps-vector-experiment>

## source pbf

<https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/11/1796/811.pbf>

## compile protoc

protoc -I=".\lib\proto" --dart_out=".\lib\proto\vectile" ".\lib\proto\vectile\vector_tile.proto"

## run

dart run bin/dartproto.dart 811.pbf

## png

<https://cyberjapandata.gsi.go.jp/xyz/std/11/1796/811.png>

## freezed

``` powershell
flutter pub run build_runner watch
```
