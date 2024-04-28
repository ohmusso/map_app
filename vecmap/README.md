# vector tile

## source pbf

<https://cyberjapandata.gsi.go.jp/xyz/experimental_bvmap/11/1796/811.pbf>

## compile proto

protoc -I=".\lib\proto" --dart_out=".\lib\proto\vectile" ".\lib\proto\vectile\vector_tile.proto"

## run

dart run bin/dartproto.dart 811.pbf

## png

<https://cyberjapandata.gsi.go.jp/xyz/std/11/1796/811.png>
