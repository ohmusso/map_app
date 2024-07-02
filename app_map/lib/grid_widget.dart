import 'package:flutter/material.dart';

class GridWidget extends StatelessWidget {
  const GridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: CustomPaint(
          painter: GridPainter(),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double space = 20;
  final Paint _gridPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.black26;

  GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 原点を画面の中心に設定する
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    canvas.restore();
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
