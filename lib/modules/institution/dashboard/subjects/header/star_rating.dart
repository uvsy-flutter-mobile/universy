import 'package:flutter/material.dart';

class StarDisplayWidget extends StatelessWidget {
  static const int AMOUNT_OF_STARS = 5;
  final int stars;
  final void Function(int) onChanged;

  const StarDisplayWidget({Key key, this.stars, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(AMOUNT_OF_STARS, (index) {
        return IconButton(
          onPressed: () => _performOnChanged(index),
          icon: _getStarIcon(index),
        );
      }),
    );
  }

  void _performOnChanged(int index) {
    onChanged(index + 1);
  }

  Icon _getStarIcon(index) {
    return Icon(
      index < stars ? Icons.star : Icons.star_border,
      color: index < stars ? Colors.orangeAccent : Colors.black,
      size: 34,
    );
  }
}
