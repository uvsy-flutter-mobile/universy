import 'package:flutter/material.dart';

class EdgePaddingWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets edgeInsets;

  const EdgePaddingWidget(this.edgeInsets, this.child, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: edgeInsets, child: child);
  }
}

/// This class adds padding in two opposites edges
class SymmetricEdgePaddingWidget extends EdgePaddingWidget {
  SymmetricEdgePaddingWidget.vertical(
      {@required double paddingValue, @required Widget child, Key key})
      : super(EdgeInsets.symmetric(vertical: paddingValue), child, key: key);

  SymmetricEdgePaddingWidget.horizontal(
      {@required double paddingValue, @required Widget child, Key key})
      : super(EdgeInsets.symmetric(horizontal: paddingValue), child, key: key);
}

/// This class adds padding only in one of the edges
class OnlyEdgePaddedWidget extends EdgePaddingWidget {
  OnlyEdgePaddedWidget.top(
      {@required Widget child, @required double padding, Key key})
      : super(EdgeInsets.only(top: padding), child, key: key);

  OnlyEdgePaddedWidget.bottom(
      {@required Widget child, @required double padding, Key key})
      : super(EdgeInsets.only(bottom: padding), child, key: key);

  OnlyEdgePaddedWidget.left(
      {@required Widget child, @required double padding, Key key})
      : super(EdgeInsets.only(left: padding), child, key: key);

  OnlyEdgePaddedWidget.right(
      {@required Widget child, @required double padding, Key key})
      : super(EdgeInsets.only(right: padding), child, key: key);
}

/// This class adds padding on all edges on its child
class AllEdgePaddedWidget extends EdgePaddingWidget {
  AllEdgePaddedWidget(
      {@required Widget child, @required double padding, Key key})
      : super(EdgeInsets.all(padding), child, key: key);
}
