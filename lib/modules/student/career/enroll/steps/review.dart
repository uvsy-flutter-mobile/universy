import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/model/institution/enrollment.dart';
import 'package:universy/modules/student/career/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/career/enroll/steps/step.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ReviewStep extends StatefulWidget {
  final CareerEnrollment enrollment;

  const ReviewStep({Key key, this.enrollment}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReviewStepState();
  }
}

class _ReviewStepState extends State<ReviewStep> {
  EnrollCubit _enrollCubit;

  bool confirmed;

  @override
  void didChangeDependencies() {
    this.confirmed = false;
    this._enrollCubit = BlocProvider.of<EnrollCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    this._enrollCubit = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EnrollStep(
      // TODO: Apptext
      title: "Revisa lo ingresado :)",
      child: _buildReviewWidget(),
      onNext: confirmed ? _handleCareerCreation : null,
      nextLabel: "Crear Carrera",
      onPrevious: _goToCareers,
    );
  }

  Widget _buildReviewWidget() {
    return AllEdgePaddedWidget(
      padding: 20,
      child: Column(
        children: <Widget>[
          Text(
              "Te vas a inscribir a ${widget.enrollment.institutionCareer.name}"),
          Row(
            children: <Widget>[
              Checkbox(
                value: confirmed,
                onChanged: _handleCheck,
              ),
              Text("Los datos son correctos!")
            ],
          )
        ],
      ),
    );
  }

  void _handleCheck(bool checked) {
    setState(() {
      confirmed = checked;
    });
  }

  void _handleCareerCreation() async {
    // TODO: apptext
    await AsyncModalBuilder()
        .perform(_createCareer)
        .then(_navigateToHome)
        .withTitle("Agregando Carrera")
        .build()
        .run(context);
  }

  Future<void> _createCareer(BuildContext context) async {
    var enrollment = widget.enrollment;
    await _enrollCubit.createCareer(
      enrollment.institutionProgram,
      enrollment.beginYear,
    );
  }

  void _goToCareers() async {
    _enrollCubit.reloadPrograms();
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pop(context);
    FlushBarBroker()
        .withMessage("Carrera agregada!")
        .withIcon(Icon(Icons.check, color: Colors.green))
        .show(context);
  }
}
