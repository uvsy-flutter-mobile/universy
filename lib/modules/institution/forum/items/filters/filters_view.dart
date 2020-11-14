import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/dialog/confirm.dart';
import 'package:universy/widgets/paddings/edge.dart';

class FiltersViewWidget extends StatefulWidget {
  final List<InstitutionSubject> _subjects;
  final List<Commission> _commissions;

  const FiltersViewWidget({Key key, List<InstitutionSubject> subjects, List<Commission> commission})
      : this._subjects = subjects,
        this._commissions = commission,
        super(key: key);

  @override
  _FiltersViewWidgetState createState() => _FiltersViewWidgetState();
}

class _FiltersViewWidgetState extends State<FiltersViewWidget> {
  TextEditingController _searchTagsEditingController;
  int _selectedLevel;
  bool _recently;
  List<String> _uploadTags = [];
  List<InstitutionSubject> _subjects;
  List<Commission> _commissions;
  InstitutionSubject _selectedSubject;
  Commission _selectedCommission;
  bool _maxTags;
  ScrollController _scrollController;

  @override
  void initState() {
    _recently = true;
    _selectedCommission = null;
    _selectedSubject = null;
    _scrollController = ScrollController();
    _subjects = widget._subjects;
    _commissions = widget._commissions;
    _searchTagsEditingController = TextEditingController();
    super.initState();
    _maxTags = false;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 10,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitle(
                AppText.getInstance().get("institution.forum.filter.level"),
              ),
              _buildLevelButtonsRow(),
              _buildTitle(
                AppText.getInstance().get("institution.forum.filter.subject"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildSubjectDropDown(),
                ],
              ),
              _buildTitle(
                AppText.getInstance().get("institution.forum.filter.commission"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildCommissionDropDown(),
                ],
              ),
              _buildTitle(
                AppText.getInstance().get("institution.forum.filter.orderByDate"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDatePicker(
                      AppText.getInstance().get("institution.forum.filter.mostRecent"), true),
                  _buildDatePicker(
                      AppText.getInstance().get("institution.forum.filter.older"), false),
                ],
              ),
              _buildTitle(AppText.getInstance().get("institution.forum.filter.labels")),
              _buildTags(),
              _buildAddTagsSection(context),
              _buildApplyButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Center(
      child: CircularRoundedRectangleRaisedButton.general(
          child: AllEdgePaddedWidget(
            padding: 9.0,
            child: Text(
              AppText.getInstance().get("institution.forum.filter.filterButton"),
              style: Theme.of(context).primaryTextTheme.button,
            ),
          ),
          color: Theme.of(context).buttonColor,
          radius: 10,
          onPressed: _createAndSendFilter),
    );
  }

  Widget _buildSubjectDropDown() {
    GlobalKey key = GlobalKey();
    InstitutionSubject dropdownValue;
    return DropdownButton<InstitutionSubject>(
      key: key,
      hint: Text(
        AppText.getInstance().get("institution.forum.filter.subject"),
        textAlign: TextAlign.center,
      ),
      value: (this._selectedSubject == null) ? dropdownValue : this._selectedSubject,
      elevation: 6,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownSubject,
      items: _subjects.map((x) {
        return new DropdownMenuItem<InstitutionSubject>(
          value: x,
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: new Text(
                x.name,
                textAlign: TextAlign.center,
              )),
        );
      }).toList(),
    );
  }

  void _onChangeDropDownSubject(InstitutionSubject newValue) {
    return setState(() {
      this._selectedSubject = newValue;
    });
  }

  Widget _buildCommissionDropDown() {
    GlobalKey key = GlobalKey();
    Commission dropdownValue;
    return DropdownButton<Commission>(
      key: key,
      hint: Text(
        AppText.getInstance().get("institution.forum.filter.commission"),
        textAlign: TextAlign.center,
      ),
      value: (this._selectedCommission == null) ? dropdownValue : this._selectedCommission,
      elevation: 6,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownCommission,
      items: _commissions.map((x) {
        return new DropdownMenuItem<Commission>(
          value: x,
          child: SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: new Text(
                x.name,
                textAlign: TextAlign.center,
              )),
        );
      }).toList(),
    );
  }

  void _onChangeDropDownCommission(Commission newValue) {
    return setState(() {
      this._selectedCommission = newValue;
    });
  }

  void _createAndSendFilter() {
    List<String> listTags = [];
    if (this._recently == true) {
      String sort = "-creation";
      listTags.add(sort);
    } else {
      String sort = "+creation";
      listTags.add(sort);
    }

    String tags = '';

    if (this._selectedLevel != null) {
      tags += this._selectedLevel.toString() + ",";
    }
    if (this._selectedSubject != null) {
      tags += this._selectedSubject.name + ",";
    }
    if (this._selectedCommission != null) {
      tags += this._selectedCommission.name + ",";
    }
    if (this._uploadTags.isNotEmpty) {
      for (String x in _uploadTags) {
        tags += x + ",";
      }
    }
    if (tags.trim().length != 0) {
      listTags.add(tags);
    }

    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications(true, listTags);
  }

  Widget _buildAddTagsSection(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Visibility(
        visible: !_maxTags,
        replacement: _buildErrorMessage(),
        child: _buildInputTagsField(context),
      ),
    );
  }

  TextField _buildInputTagsField(BuildContext context) {
    return TextField(
        enabled: !_maxTags,
        onChanged: (query) => _filterTag(query, context),
        controller: _searchTagsEditingController,
        decoration: _buildTagAddDecoration());
  }

  Widget _buildErrorMessage() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Text(
        AppText.getInstance().get("institution.forum.filter.maxTags"),
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _buildTagAddDecoration() {
    return InputDecoration.collapsed(
      hintStyle: TextStyle(color: Colors.grey),
      hintText: AppText.getInstance().get("institution.forum.filter.hintTags"),
    );
  }

  void _filterTag(String query, BuildContext context) {
    if (query.isNotEmpty) {
      if (query.trim().length > 0) {
        if (query.endsWith(" ")) {
          if (query.length < 15) {
            if (_uploadTags.length != 9) {
              setState(() {
                String cleanQuery = query.trimLeft();
                String cleanQuery2 = cleanQuery.trimRight();
                _uploadTags.add(cleanQuery2);
                _searchTagsEditingController.clear();
              });
            } else {
              setState(() {
                String cleanQuery = query.trimLeft();
                String cleanQuery2 = cleanQuery.trimRight();
                _uploadTags.add(cleanQuery2);
                _searchTagsEditingController.clear();
                _scrollController.animateTo(
                  00.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 1000),
                );
                _maxTags = true;
              });
            }
          } else {
            showDialog<bool>(
                  context: context,
                  builder: (context) => ConfirmDialog(
                    title: AppText.getInstance().get("institution.forum.filter.maxTagsLengthTitle"),
                    content: AppText.getInstance()
                        .get("institution.forum.filter.maxTagsLengthDescription"),
                    buttons: <Widget>[
                      CancelButton(
                        onCancel: () => Navigator.of(context).pop(true),
                      )
                    ],
                  ),
                ) ??
                false;
          }
        }
      }
    }
  }

  Widget _buildTags() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Tags(
        alignment: WrapAlignment.start,
        itemCount: _uploadTags.length,
        itemBuilder: (int index) {
          return ItemTags(
            removeButton: ItemTagsRemoveButton(
                backgroundColor: Colors.transparent, icon: Icons.clear, color: Colors.black),
            onPressed: (x) {
              setState(() {
                _uploadTags.removeAt(index);
                _maxTags = false;
              });
            },
            key: Key(index.toString()),
            index: index,
            title: "${_uploadTags[index]}",
            pressEnabled: true,
            activeColor: Colors.grey[350],
            color: Colors.grey[350],
            elevation: 0,
            textActiveColor: Colors.black,
            textColor: Colors.black,
            textStyle: TextStyle(
              fontSize: 14,
            ),
            combine: ItemTagsCombine.withTextBefore,
          );
        },
      ),
    );
  }

  Widget _buildDatePicker(String descriptionText, bool ascending) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.amber,
              )),
          color: (_recently == ascending) ? Colors.amber : Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: (_recently == ascending) ? Colors.white : Colors.amber,
            ),
            Text(
              "$descriptionText",
              style: TextStyle(
                color: (_recently == ascending) ? Colors.white : Colors.amber,
              ),
            ),
          ]),
          onPressed: () {
            _onPressedDatePicker();
          }),
    );
  }

  void _onPressedDatePicker() {
    setState(() {
      this._recently = !this._recently;
    });
  }

  Widget _buildLevelButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _buildButton("1"),
        _buildButton("2"),
        _buildButton("3"),
        _buildButton("4"),
        _buildButton("5"),
      ],
    );
  }

  Widget _buildTitle(String text) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 6,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ));
  }

  Widget _buildButton(String text) {
    return FloatingActionButton(
      backgroundColor: this._selectedLevel == int.parse(text) ? Colors.amber : Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: this._selectedLevel != int.parse(text) ? Colors.amber : Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Container(
        child: _buildContentLevelButton(text),
      ),
      onPressed: () {
        setState(() {
          if (this._selectedLevel == int.parse(text)) {
            this._selectedLevel = null;
          } else {
            this._selectedLevel = int.parse(text);
          }
        });
      },
    );
  }

  Center _buildContentLevelButton(String text) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
          color: _selectedLevel == int.parse(text) ? Colors.white : Colors.amber,
          fontWeight: FontWeight.bold),
    ));
  }
}
