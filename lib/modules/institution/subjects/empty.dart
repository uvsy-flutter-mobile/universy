import 'package:flutter/material.dart';
import 'package:universy/widgets/items/empty.dart';

class EmptyInstitutionSubjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyItemsWidget(
      title:
          "¡Ups!", //AppText.getInstance().get("student.subjects.empty.title"),
      message:
          "No encontramos la materia que estas buscando :(", //AppText.getInstance().get("student.subjects.empty.subtitle"),
    );
  }
}
