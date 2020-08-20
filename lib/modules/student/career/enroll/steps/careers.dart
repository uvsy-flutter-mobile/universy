import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/institution/career.dart';
import 'package:universy/modules/student/career/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/career/enroll/steps/element_card.dart';
import 'package:universy/modules/student/career/enroll/steps/step.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

class CareerStep extends StatefulWidget {
  final List<InstitutionCareer> careers;

  const CareerStep({Key key, this.careers}) : super(key: key);

  @override
  _CareerStepState createState() => _CareerStepState();
}

class _CareerStepState extends State<CareerStep> {
  InstitutionCareer _selectedCareer;

  @override
  void initState() {
    _selectedCareer = null;
    super.initState();
  }

  @override
  void dispose() {
    _selectedCareer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnrollStep(
      // TODO: To apptext
      title: "Elegi una carrera",
      child: _buildCareerWidget(),
      onNext: notNull(_selectedCareer) ? _selectCareer : null,
      onPrevious: _goToInstitution,
    );
  }

  Widget _buildCareerWidget() {
    List<Widget> children = [];
    children.add(SizedBox(height: 10));
    children.addAll(widget.careers.map(_createCareerItem).toList());
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

  Widget _createCareerItem(InstitutionCareer career) {
    return ElementCard(
      title: career.name,
      tag: career.codename,
      selected: isSelected(career),
      onTap: () => _handleSelection(career),
    );
  }

  bool isSelected(InstitutionCareer career) {
    return notNull(_selectedCareer) && _selectedCareer.id == career.id;
  }

  void _handleSelection(InstitutionCareer career) {
    if (isSelected(career)) {
      setState(() {
        _selectedCareer = null;
      });
    } else {
      setState(() {
        _selectedCareer = career;
      });
    }
  }

  void _selectCareer() {
    Provider.of<EnrollCubit>(context, listen: false)
        .selectCareer(_selectedCareer);
  }

  void _goToInstitution() {
    Provider.of<EnrollCubit>(context, listen: false).fetchInstitutions();
  }
}
