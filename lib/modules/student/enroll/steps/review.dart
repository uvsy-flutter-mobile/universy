import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/institution/enrollment.dart';
import 'package:universy/modules/student/enroll/bloc/cubit.dart';
import 'package:universy/modules/student/enroll/steps/step.dart';
import 'package:universy/text/text.dart';
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
      title: AppText.getInstance().get("student.enroll.input.checkInput"),
      child: _buildReviewWidget(),
      onNext: confirmed ? _handleCareerCreation : null,
      nextLabel: AppText.getInstance().get("student.enroll.actions.addCareer"),
      onPrevious: _goToCareers,
    );
  }

  Widget _buildReviewWidget() {
    String checkCareerLabel =
        AppText.getInstance().get("student.enroll.info.checkCareer");
    String checkInstitutionLabel =
        AppText.getInstance().get("student.enroll.info.checkInstitution");
    String checkProgramLabel =
        AppText.getInstance().get("student.enroll.info.checkProgram");
    return AllEdgePaddedWidget(
      padding: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(checkCareerLabel, style: TextStyle(fontSize: 18.0)),
          Text(
            widget.enrollment.institutionCareer.name,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 20.0),
          ),
          SizedBox(height: 12.0),
          Text(checkInstitutionLabel, style: TextStyle(fontSize: 18.0)),
          Text(
            widget.enrollment.institution.name,
            overflow: TextOverflow.visible,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 20.0),
          ),
          SizedBox(height: 12.0),
          Text(checkProgramLabel, style: TextStyle(fontSize: 18.0)),
          Text(
            widget.enrollment.institutionProgram.name,
            overflow: TextOverflow.visible,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                fontSize: 20.0),
          ),
          SizedBox(height: 12.0),
          Divider(
            color: Colors.grey,
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                value: confirmed,
                onChanged: _handleCheck,
              ),
              Text(
                AppText.getInstance().get("student.enroll.input.correctInput"),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
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
    await AsyncModalBuilder()
        .perform(_createCareer)
        .then(_navigateToHome)
        .withTitle(
            AppText.getInstance().get("student.enroll.info.addingCareer"))
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

  void _navigateToHome(BuildContext context) async {
    Navigator.pop(context);
    await Navigator.pushReplacementNamed(context, Routes.HOME);
    // Here an exceptions is taking place
    // At this point the state of the widget's element tree is no longer stable.
    // E/flutter ( 7353): To safely refer to a widget's ancestor in its dispose() method,
    // save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType()
    // in the widget's didChangeDependencies() method.
    FlushBarBroker()
        .withMessage(
            AppText.getInstance().get("student.enroll.info.careerAdded"))
        .withIcon(Icon(Icons.check, color: Colors.green))
        .show(context);
  }
}
