import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({
    super.key,
  });

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Demo"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: CustomPaint(
              painter: MyPainter(true),
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final bool show;
  final double space = 20;
  final Paint _gridPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.black26;
  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.5
    ..color = Colors.blue.shade200;

  MyPainter(this.show);

  @override
  void paint(Canvas canvas, Size size) {
    // 原点を画面の中心に設定する
    canvas.translate(size.width / 2, size.height / 2);

    _drawGrid(canvas, size);

    Path path = Path();
    path
      ..moveTo(-120, -20) // ペンを(-120,-20)へ移動
      ..lineTo(-80, -80) // (-120,-20)から(-80, -80)線を描く
      ..lineTo(-40, -60) // (-80, -80)から(-40, -60)線を描く
      ..lineTo(0, 0)
      ..lineTo(40, -140)
      ..lineTo(80, 120)
      ..lineTo(120, -100);
    canvas.drawPath(path, _pathPaint);
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawGridRight(canvas, size);

    canvas.save();
    canvas.scale(1, -1);
    _drawGridRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1);
    _drawGridRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);
    _drawGridRight(canvas, size);
    canvas.restore();
  }

  void _drawGridRight(Canvas canvas, Size size) {
    // キャンパスの保存
    canvas.save();

    // 縦線を描く
    for (int i = 0; i < size.width / 2 / space; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(space, 0);
    }

    // キャンパスリセット（原点リセット）
    canvas.restore();
    canvas.save();

    // 横線を描く
    for (int i = 0; i < size.height / 2 / space; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, space);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
