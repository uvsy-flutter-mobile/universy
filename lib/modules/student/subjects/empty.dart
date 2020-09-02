import 'package:flutter/material.dart';
import 'package:universy/widgets/items/empty.dart';

class EmptySubjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyItemsWidget(
      // TODO: App text
      title: "¡Ups!", //AppText.getInstance().get("error.ups"),
      // (AppText.getInstance().get("studentSubject.noSubjectsFound"));
      message: "Parece que no hay materias cargadas en el plan de estudios",
    );
  }
}
