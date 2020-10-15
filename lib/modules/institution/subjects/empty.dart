import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/items/empty.dart';

class EmptyInstitutionSubjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyItemsWidget(
      title: AppText.getInstance().get("institution.subjects.noResults.title"),
      message:
          AppText.getInstance().get("institution.subjects.noResults.subtitle"),
    );
  }
}
