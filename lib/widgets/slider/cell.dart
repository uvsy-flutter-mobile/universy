import 'dart:ui';
import 'package:flutter/material.dart';

class CellData {
  final Color color;

  CellData(this.color);
}

class Cell extends StatelessWidget {
  final double _height;
  final double _width;
  final Color _color;

  Cell(this._width, this._height, this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: PaintedCell(_width, _height, _color),
        child: SizedBox(
          width: _width,
          height: _height,
        ),
      ),
      height: _height,
      width: _width,
    );
  }
}

class PaintedCell extends CustomPainter {
  final double _baseHeight;
  final double _baseWidth;
  final Color _color;

  PaintedCell(this._baseHeight, this._baseWidth, this._color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = _color;
    paint.style = PaintingStyle.fill;

    var rect = Rect.fromLTWH(0, 0, _baseWidth, _baseHeight);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(PaintedCell oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PaintedCell oldDelegate) => true;
}
