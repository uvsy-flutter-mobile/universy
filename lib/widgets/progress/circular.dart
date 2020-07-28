import 'package:flutter/material.dart';

class CenterSizedCircularProgressIndicator extends StatelessWidget {
  final double width;
  final double height;

  const CenterSizedCircularProgressIndicator(
      {Key key, this.width = 50, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Center(child: CircularProgressIndicator()),
        height: height,
        width: width,
      ),
    );
  }
}
