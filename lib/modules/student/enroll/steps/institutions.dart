import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/institution.dart';
import 'package:universy/modules/student/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/enroll/steps/element_card.dart';
import 'package:universy/modules/student/enroll/steps/step.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class InstitutionStep extends StatefulWidget {
  final List<Institution> institutions;

  const InstitutionStep({Key key, this.institutions}) : super(key: key);

  @override
  _InstitutionStepState createState() => _InstitutionStepState();
}

class _InstitutionStepState extends State<InstitutionStep> {
  Institution _selectedInstitution;

  @override
  void initState() {
    _selectedInstitution = null;
    super.initState();
  }

  @override
  void dispose() {
    _selectedInstitution = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnrollStep(
      title:
          AppText.getInstance().get("student.enroll.input.chooseInstitution"),
      child: _buildInstitutionList(),
      onNext: notNull(_selectedInstitution) ? _selectInstitution : null,
      onPrevious: null,
    );
  }

  Widget _buildInstitutionList() {
    List<Widget> children = [];
    children.add(SizedBox(height: 10));
    children.addAll(widget.institutions.map(_createInstitutionItem).toList());
    children.add(SizedBox(height: 40));
    return AllEdgePaddedWidget(
      padding: 8,
      child: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnEnd: 0.3,
        child: ListView(
          controller: ScrollController(),
          physics: BouncingScrollPhysics(),
          children: children,
        ),
      ),
    );
  }

  Widget _createInstitutionItem(Institution institution) {
    return ElementCard(
      title: institution.name,
      tag: institution.codename,
      selected: isSelected(institution),
      onTap: () => _handleSelection(institution),
    );
  }

  bool isSelected(Institution institution) {
    return notNull(_selectedInstitution) &&
        _selectedInstitution.id == institution.id;
  }

  void _handleSelection(Institution institution) {
    if (isSelected(institution)) {
      setState(() {
        _selectedInstitution = null;
      });
    } else {
      setState(() {
        _selectedInstitution = institution;
      });
    }
  }

  void _selectInstitution() {
    Provider.of<EnrollCubit>(context, listen: false)
        .selectInstitution(_selectedInstitution);
  }
}
