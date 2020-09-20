import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:universy/constants/gradient_fraction.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/constants/strings.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/text/comparators/search_comparator.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'empty.dart';
import 'subject_card.dart';

class InstitutionSubjectDisplayWidget extends StatefulWidget {
  final List<InstitutionSubject> _institutionSubjects;

  const InstitutionSubjectDisplayWidget(
      {Key key, @required List<InstitutionSubject> institutionSubjects})
      : this._institutionSubjects = institutionSubjects,
        super(key: key);

  @override
  _InstitutionSubjectDisplayWidgetState createState() =>
      _InstitutionSubjectDisplayWidgetState();
}

class _InstitutionSubjectDisplayWidgetState
    extends State<InstitutionSubjectDisplayWidget> {
  TextEditingController _nameSearchController;
  List<InstitutionSubject> _displayedSubjectList;

  @override
  void initState() {
    _nameSearchController = TextEditingController();
    _displayedSubjectList = List<InstitutionSubject>();
    _displayedSubjectList.addAll(widget._institutionSubjects);
    super.initState();
  }

  @override
  void dispose() {
    _nameSearchController.dispose();
    _displayedSubjectList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          _buildNameSearchBar(),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_displayedSubjectList.isEmpty) {
      return EmptyInstitutionSubjectsWidget();
    }
    return _buildSubjectList();
  }

  Widget _buildNameSearchBar() {
    return EdgePaddingWidget(
      EdgeInsets.all(20.0),
      TextField(
        onChanged: (value) {
          _filterSearchResults(value);
        },
        maxLength: 40,
        controller: _nameSearchController,
        decoration: _buildNameSearchBarDecoration(),
      ),
    );
  }

  InputDecoration _buildNameSearchBarDecoration() {
    return InputDecoration(
      counterText: EMPTY_STRING,
      labelText: "Buscar Cátedra",
      //AppText.getInstance().get('institutionSubject.searchBar.title'),
      hintText: "Nombre",
      //AppText.getInstance().get('institutionSubject.searchBar.hint'),
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
    );
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<InstitutionSubject> newSubjectList = List<InstitutionSubject>();
      widget._institutionSubjects.forEach((subject) {
        var nameComparator = TextSearchComparator(subject.name);
        if (nameComparator.isQueryInText(query)) {
          newSubjectList.add(subject);
        }
      });
      setState(() {
        _updateSubjectList(newSubjectList);
      });
    } else {
      setState(() {
        _updateSubjectList(widget._institutionSubjects);
      });
    }
  }

  void _updateSubjectList(List<InstitutionSubject> newSubjectList) {
    _displayedSubjectList.clear();
    _displayedSubjectList.addAll(newSubjectList);
  }

  Widget _buildSubjectList() {
    return FadingEdgeScrollView.fromScrollView(
      gradientFractionOnStart: GradientFraction.SMALL,
      gradientFractionOnEnd: GradientFraction.NONE,
      child: ListView.builder(
        controller: ScrollController(),
        itemCount: _displayedSubjectList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: _getSubjectBuilder(_displayedSubjectList),
      ),
    );
  }

  IndexedWidgetBuilder _getSubjectBuilder(
      List<InstitutionSubject> institutionSubjects) {
    return (BuildContext context, int index) {
      InstitutionSubject institutionSubject = institutionSubjects[index];
      return InstitutionSubjectCardWidget(
        institutionSubject: institutionSubject,
        onCardTap: (ctx, inst) => Navigator.pushNamed(
          context,
          Routes.SUBJECT_BOARD_MODULE,
          arguments: institutionSubject,
        ), //_navigateToSubjectBoardView,
      );
    };
  }
}
