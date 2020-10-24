import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:universy/business/correlatives/validator.dart';
import 'package:universy/business/subjects/classifier/classifier.dart';
import 'package:universy/business/subjects/classifier/result.dart';
import 'package:universy/business/subjects/classifier/state_classifier.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/subject.dart';
import 'package:universy/modules/student/stats/stats.dart';
import 'package:universy/modules/student/subjects/subject_list.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/logger.dart';
import 'package:universy/widgets/flushbar/builder.dart';

const int APPROVED_INDEX = 3;
const int REGULAR_INDEX = 2;
const int TAKING_INDEX = 1;
const int TO_TAKE_INDEX = 0;

class SubjectsDisplayWidget extends StatefulWidget {
  final List<Subject> _subjects;

  const SubjectsDisplayWidget({
    Key key,
    List<Subject> subjects,
  })  : this._subjects = subjects,
        super(key: key);

  @override
  _SubjectsDisplayWidgetState createState() => _SubjectsDisplayWidgetState();
}

class _SubjectsDisplayWidgetState extends State<SubjectsDisplayWidget> {
  List<Subject> _subjects;
  SubjectClassifier<SubjectByStateResult> _classifier;
  SubjectByStateResult _subjectByState;
  CorrelativesValidator _correlativesValidator;
  PageController _pageController;
  bool _submitting;
  StudentCareerService _careerService;
  @override
  void initState() {
    this._subjects = widget._subjects;
    this._classifier = SubjectByStateClassifier();
    this._subjectByState = _classifier.classify(_subjects);
    this._correlativesValidator = CorrelativesValidator.fromSubjects(_subjects);
    this._pageController = PageController(
      viewportFraction: 0.8,
      initialPage: _getInitialPage(),
    );
    this._submitting = false;
    this._careerService = Provider.of<ServiceFactory>(context, listen: false) //
        .studentCareerService();
    super.initState();
  }

  @override
  void dispose() {
    this._subjects = null;
    this._classifier = null;
    this._subjectByState = null;
    this._correlativesValidator = null;
    this._pageController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<CorrelativesValidator>.value(
      value: _correlativesValidator,
      child: Scaffold(
        floatingActionButton: _buildViewStudentProgress(),
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          dismissible: false,
          inAsyncCall: _submitting,
          child: SizedBox.expand(
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              children: <Widget>[
                _buildToTakeList(_subjectByState),
                _buildTakingList(_subjectByState),
                _buildRegularList(_subjectByState),
                _buildApprovedList(_subjectByState)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewStudentProgress() {
    return FloatingActionButton(
      heroTag: "progress_tag",
      backgroundColor: Colors.deepPurple,
      child: Icon(Icons.equalizer),
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StatsModule(
                  subjects: _subjects, validator: _correlativesValidator))),
    );
  }

  Widget _buildApprovedList(SubjectByStateResult result) {
    return StudentSubjectList(
      title:
          AppText.getInstance().get("student.subjects.states.labels.approved"),
      subjects: result.approved,
      onUpdate: _onUpdate,
    );
  }

  Widget _buildRegularList(SubjectByStateResult result) {
    return StudentSubjectList(
      title:
          AppText.getInstance().get("student.subjects.states.labels.regular"),
      subjects: result.regular,
      onUpdate: _onUpdate,
    );
  }

  Widget _buildTakingList(SubjectByStateResult result) {
    return StudentSubjectList(
      title: AppText.getInstance().get("student.subjects.states.labels.taking"),
      subjects: result.taking,
      onUpdate: _onUpdate,
    );
  }

  Widget _buildToTakeList(SubjectByStateResult result) {
    return StudentSubjectList(
      title: AppText.getInstance().get("student.subjects.states.labels.toTake"),
      subjects: result.toTake,
      onUpdate: _onUpdate,
    );
  }

  int _getInitialPage() {
    if (_subjectByState.taking.isEmpty) {
      if (_subjectByState.toTake.isEmpty) {
        if (_subjectByState.regular.isEmpty) {
          return APPROVED_INDEX;
        } else {
          return REGULAR_INDEX;
        }
      } else {
        return TO_TAKE_INDEX;
      }
    } else {
      return TAKING_INDEX;
    }
  }

  void _onUpdate(Subject subject) async {
    try {
      _updateSubmitting();
      await _careerService.updateSubject(subject);
      _updateList(subject);
      _updateSubmitting();
      _refreshNavigateFocus(subject);
      _buildFlashBarOk();
    } catch (e) {
      Log.getLogger().error(e);
      _updateSubmitting(forceSubmitting: false);
      FlushBarBroker.unknownError().show(context);
    }
  }

  void _updateList(Subject subject) {
    _subjects.removeWhere((s) => s.id == subject.id);
    _subjects.add(subject);
  }

  void _updateSubmitting({bool forceSubmitting}) {
    setState(() {
      this._submitting = forceSubmitting ?? !this._submitting;
    });
  }

  void _refreshNavigateFocus(Subject subject) {
    int index = _getPageForSubject(subject);
    setState(() {
      this._subjectByState = _classifier.classify(_subjects);
      this._correlativesValidator =
          CorrelativesValidator.fromSubjects(_subjects);
      this._pageController.animateToPage(
            index,
            duration: Duration(seconds: 1),
            curve: ElasticInCurve(),
          );
    });
  }

  void _buildFlashBarOk() {
    FlushBarBroker()
        .withDuration(5)
        .withIcon(Icon(Icons.spellcheck, color: Colors.green))
        .withMessage(
            AppText.getInstance().get("student.subjects.states.info.saved"))
        .show(context);
  }

  int _getPageForSubject(Subject subject) {
    if (subject.isTaking()) {
      return TAKING_INDEX;
    } else if (subject.isRegular()) {
      return REGULAR_INDEX;
    } else if (subject.isApproved()) {
      return APPROVED_INDEX;
    } else {
      return TO_TAKE_INDEX;
    }
  }
}
