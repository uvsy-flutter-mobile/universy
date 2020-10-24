import 'package:flutter/material.dart';

import 'cell.dart';

class Bar extends StatelessWidget {
  final List<Color> _cellColorsList;
  final double _barWidth;
  final double _cellHeight;

  Bar(this._barWidth, this._cellHeight, this._cellColorsList);

  @override
  Widget build(BuildContext context) {
    assert(_cellColorsList.length != 0);
    var cellWidth = _barWidth / _cellColorsList.length;
    var cellWidgetList = _populateCellWidgetList(_cellColorsList, cellWidth);
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: cellWidgetList,
        ),
      ),
    );
  }

  List<Widget> _populateCellWidgetList(
      List<Color> cellColorList, double cellWidth) {
    return cellColorList
        .map((color) => Cell(cellWidth, _cellHeight, color))
        .toList();
  }
}
