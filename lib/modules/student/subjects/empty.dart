import 'package:flutter/material.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/items/empty.dart';

class EmptySubjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyItemsWidget(
      title: AppText.getInstance().get("student.subjects.empty.title"),
      message: AppText.getInstance().get("student.subjects.empty.subtitle"),
    );
  }
}
