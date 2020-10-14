import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:universy/widgets/cards/rectangular.dart';
import 'package:universy/widgets/paddings/edge.dart';

class EmptyCoursesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: buildCard(),
    );
  }

  Widget buildCard() {
    return CircularRoundedRectangleCard(
      color: Colors.white,
      radius: 16.0,
      elevation: 5,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5,
        child: Center(
          heightFactor: 3.5,
          child: buildMessage(),
        ),
      ),
    );
  }

  Widget buildMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          //TODO: apptext
          "Esta materia no tiene cursos",
          //AppText.getInstance().get("subjectBoard.carousel.noComissionAvaiable"),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6),
        Icon(Icons.block)
      ],
    );
  }
}
