import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optional/optional.dart';
import 'package:universy/model/institution/program.dart';
import 'package:universy/modules/student/career/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/career/enroll/steps/step.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'element_card.dart';

const int MAX_AMOUNT_OF_YEARS = 20;

class ProgramStep extends StatefulWidget {
  final List<InstitutionProgram> programs;

  const ProgramStep({Key key, this.programs}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProgramStepState();
  }
}

class _ProgramStepState extends State<ProgramStep> {
  int _selectedYear;
  InstitutionProgram _selectedProgram;

  EnrollCubit _enrollCubit;

  @override
  void didChangeDependencies() {
    this._enrollCubit = BlocProvider.of<EnrollCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    this._selectedProgram = null;
    this._selectedYear = null;
    this._enrollCubit = null;
    super.initState();
  }

  @override
  void dispose() {
    this._selectedProgram = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EnrollStep(
      // TODO: Apptext
      title: "Elegi tu año de ingreso",
      child: _buildProgramWidget(),
      onNext: notNull(_selectedProgram) ? _selectYear : null,
      onPrevious: _goToCareers,
    );
  }

  Widget _buildProgramWidget() {
    return AllEdgePaddedWidget(
      padding: 20,
      child: FadingEdgeScrollView.fromScrollView(
        gradientFractionOnEnd: 0.1,
        child: ListView(
          controller: ScrollController(),
          physics: BouncingScrollPhysics(),
          children: _createYearList().map(_buildYear).toList(),
        ),
      ),
    );
  }

  Widget _buildYear(int year) {
    print(year);
    Optional<InstitutionProgram> program = getProgramForYear(year);
    return ElementCard(
      selected: isSelected(year),
      enabled: program.isPresent,
      title: "$year",
      // TODO: Migrate to apptext
      subtitle:
          program.map((p) => p.name).orElse("No hay programa para este año :/"),
      onTap: () => _handleSelection(year),
    );
  }

  bool isSelected(int year) {
    return notNull(_selectedYear) && _selectedYear == year;
  }

  void _handleSelection(int year) {
    if (isSelected(year)) {
      setState(() {
        _selectedYear = null;
        _selectedProgram = null;
      });
    } else {
      setState(() {
        _selectedYear = year;
        _selectedProgram = getProgramForYear(year).value;
      });
    }
  }

  Optional<InstitutionProgram> getProgramForYear(int year) {
    return Optional.ofNullable(widget.programs.firstWhere(
      (program) => program.isProgramForYear(year),
      orElse: () => null,
    ));
  }

  Iterable<int> get years sync* {
    int actualYear = DateTime.now().year;
    int i = actualYear;
    while (true) yield i--;
  }

  List<int> _createYearList() {
    return years.take(MAX_AMOUNT_OF_YEARS).toList();
  }

  void _selectYear() {
    _enrollCubit.selectProgram(_selectedProgram, _selectedYear);
  }

  void _goToCareers() {
    _enrollCubit.reloadCareers();
  }
}
