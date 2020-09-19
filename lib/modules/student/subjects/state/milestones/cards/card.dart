import 'package:flutter/material.dart';

class MilestoneCard extends StatelessWidget {
  final Color color;
  final List<Widget> children;
  final double padding;
  final double margin;
  final double height;
  final double radius;

  const MilestoneCard(
      {Key key,
      this.children,
      this.color = Colors.amberAccent,
      this.padding = 0,
      this.margin = 3,
      this.height = 65,
      this.radius = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, child: _buildMilestoneBody());
  }

  Widget _buildMilestoneBody() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: _buildMilestoneBodyClip(),
    );
  }

  Widget _buildMilestoneBodyClip() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Row(children: children),
    );
  }
}
