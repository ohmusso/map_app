/// 緯度経度を平面直角座標への換算
/// https://vldb.gsi.go.jp/sokuchi/surveycalc/surveycalc/bl2xyf.html

import 'dart:math';

/// 楕円体の長半径
const double _a = 6378137;

/// 楕円体の逆扁平率
const double _rf = 298.257222101;

/// 平面直角座標系の軸上における縮尺係数 (0.9999)
const double _m0 = 0.9999;

/// 角度(秒)を角度(rad)に変換する係数
const double _s2r = pi / 648000;

/// 第三扁平率
const double _n = 0.5 / (_rf - 0.5);

/// 第三扁平率を1.5倍した定数
const double _n15 = 1.5 * _n;

/// ???
const double _anh = 0.5 * _a / (1 + _n);

/// nの二乗
const double _nsq = _n * _n;

/// ???
final double _e2n = 2.0 * sqrt(_n) / (1 + _n);

/// ???
final double _ra = 2.0 * _anh * _m0 * (1 + _nsq / 4.0 + _nsq * _nsq / 64.0);

/// ???
const int _jt = 5;

/// ???
const int _jt2 = 2 * _jt;

/// 子午線
class _Merid {
  final Map<int, double> e;
  final double ep;

  factory _Merid() {
    double _ep = 1.0;
    Map<int, double> _e = {};
    for (int k = 1; k <= _jt; k++) {
      _e[k] = (_n15 / k) - _n;
      _ep = _ep * _e[k]!;
      _e[k + _jt] = _n15 / (k + _jt) - _n;
    }

    return _Merid._(_e, _ep);
  }

  _Merid._(this.e, this.ep);
}

final _Merid _merid = _Merid();

/// ???
const List<double> _alp = [
  (0.5 + (-2 / 3 + (5 / 16 + (41 / 180 - 127 / 288 * _n) * _n) * _n) * _n) * _n,
  (13 / 48 + (-3 / 5 + (557 / 1440 + 281 / 630 * _n) * _n) * _n) * _nsq,
  (61 / 240 + (-103 / 140 + 15061 / 26880 * _n) * _n) * _n * _nsq,
  (49561 / 161280 - 179 / 168 * _n) * _nsq * _nsq,
  34729 / 80640 * _n * _nsq * _nsq,
];

// s=[0.0] ; t=[] ; 
