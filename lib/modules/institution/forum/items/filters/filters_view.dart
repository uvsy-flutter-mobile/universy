import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
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
  DateTime _selectedDateFrom;
  DateTime _selectedDateTo;
  List<String> _uploadTags = [];
  List<InstitutionSubject> _subjects;
  List<Commission> _commissions;
  InstitutionSubject _selectedSubject;
  Commission _selectedCommission;
  bool _maxTags;
  ScrollController _scrollController;

  @override
  void initState() {
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
              _buildTitle("Nivel"),
              _buildLevelButtonsRow(),
              _buildTitle("Materia"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildSubjectDropDown(),
                ],
              ),
              _buildTitle("Comision"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildCommissionDropDown(),
                ],
              ),
              _buildTitle("Fecha"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildDatePicker(false),
                  _buildDatePicker(true),
                ],
              ),
              _buildTitle("Etiquetas"),
              _buildTags(),
              _buildAddTagsSection(),
              _buildApplyButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return Center(
      child: RaisedButton(
        color: Colors.amber,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 30,
            ),
            Text("Buscar")
          ],
        ),
        onPressed: _createAndSendFilter,
      ),
    );
  }

  Widget _buildSubjectDropDown() {
    GlobalKey key = GlobalKey();
    InstitutionSubject dropdownValue;
    return DropdownButton<InstitutionSubject>(
      key: key,
      hint: Text(
        "Materia",
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
        "Comisión",
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
    listTags.add(tags);
    if (this._selectedDateFrom != null) {
      listTags.add(this._selectedDateFrom.millisecondsSinceEpoch.toString());
    }
    if (this._selectedDateTo != null) {
      listTags.add(this._selectedDateTo.millisecondsSinceEpoch.toString());
    }
    print(listTags);
    print(listTags[0]);
    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications(listTags);
    //Navigator.pop(context);
  }

  Widget _buildAddTagsSection() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Visibility(
        visible: !_maxTags,
        replacement: _buildErrorMessage(),
        child: _buildInputTagsField(),
      ),
    );
  }

  TextField _buildInputTagsField() {
    return TextField(
        enabled: !_maxTags,
        onChanged: _filterTag,
        controller: _searchTagsEditingController,
        decoration: _buildTagAddDecoration());
  }

  Widget _buildErrorMessage() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: Text(
        "Has llegado al máximo de tags permitidos, pagá la versión PREMIUM, o eliminá algún TAG.",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  InputDecoration _buildTagAddDecoration() {
    return InputDecoration.collapsed(
      hintStyle: TextStyle(color: Colors.grey),
      hintText: "Agregá a tu búsqueda #",
    );
  }

  void _filterTag(String query) {
    if (query.isNotEmpty) {
      if (query.trim().length > 0) {
        if (query.endsWith(" ")) {
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
            textStyle: TextStyle(
              fontSize: 14,
            ),
            combine: ItemTagsCombine.withTextBefore,
          );
        },
      ),
    );
  }

  Widget _buildDatePicker(bool toFrom) {
    DateTime dateTime = toFrom ? _selectedDateTo : _selectedDateFrom;
    String date;
    if (toFrom) {
      if (_selectedDateTo != null) {
        date = _selectedDateTo.year.toString() + "/" + _selectedDateTo.month.toString();
      }
    } else {
      if (_selectedDateFrom != null) {
        date = _selectedDateFrom.year.toString() + "/" + _selectedDateFrom.month.toString();
      }
    }
    String concept = toFrom ? "Hasta " : "Desde ";
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.amber,
              )),
          color: (dateTime != null) ? Colors.amber : Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Icon(
              Icons.calendar_today,
              color: (dateTime != null) ? Colors.white : Colors.amber,
            ),
            Text(
              "$concept",
              style: TextStyle(
                color: (dateTime != null) ? Colors.white : Colors.amber,
              ),
            ),
            Text(
              (dateTime != null) ? "$date" : "",
              style: TextStyle(
                color: (dateTime != null) ? Colors.white : Colors.amber,
              ),
            )
          ]),
          onPressed: () {
            var now = (dateTime != null) ? dateTime : DateTime.now();
            _onPressedDatePicker(toFrom, now);
          }),
    );
  }

  void _onPressedDatePicker(bool toFrom, DateTime date) async {
    final picker = await showMonthPicker(
      context: context,
      initialDate: date,
    );
    if (toFrom == true) {
      if (picker != null) {
        setState(() {
          _selectedDateTo = picker;
        });
      }
    } else {
      if (picker != null) {
        setState(() {
          _selectedDateFrom = picker;
        });
      }
    }
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
