import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/widgets/paddings/edge.dart';

class FiltersViewWidget extends StatefulWidget {
  final Function(Filters) _callBack;
  final List<InstitutionSubject> _subjects;

  const FiltersViewWidget({Key key, Function(Filters) callBack,List<InstitutionSubject> subjects})
      : this._callBack = callBack,
        this._subjects = subjects,
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
  InstitutionSubject _selectedSubject;
  bool _maxTags;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _subjects = widget._subjects;
    _searchTagsEditingController = TextEditingController();
    super.initState();
    _maxTags = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton() ,
        body: _buildBody());
  }

  _buildFloatingActionButton(){
    return FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: _createAndSendFilter,
      child: Icon(
        Icons.search,
        color: Colors.white,
        size: 40,
      ),
    );
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
                  _buildSubjectDropDown(),
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
            ],
          ),
        ),
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
      value: dropdownValue,
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

  void _createAndSendFilter() {
    Filters newFilter =
        Filters(_selectedLevel, _selectedSubject, _selectedDateFrom, _selectedDateTo, _uploadTags);
    setState(() {
      widget._callBack(newFilter);
    });
    Navigator.pop(context);
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
      backgroundColor: _selectedLevel == int.parse(text) ? Colors.amber : Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: _selectedLevel != int.parse(text) ? Colors.amber : Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: Container(
        child: _buildContentLevelButton(text),
      ),
      onPressed: () {
        setState(() {
          if (_selectedLevel == int.parse(text)) {
            _selectedLevel = null;
          } else {
            _selectedLevel = int.parse(text);
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
