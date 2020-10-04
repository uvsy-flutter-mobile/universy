import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/widgets/paddings/edge.dart';

class FiltersViewWidget extends StatefulWidget {
  final Function(Filters) _callBack;

  const FiltersViewWidget({Key key, Function(Filters) callBack})
      : this._callBack = callBack,
        super(key: key);

  @override
  _FiltersViewWidgetState createState() => _FiltersViewWidgetState();
}

class _FiltersViewWidgetState extends State<FiltersViewWidget> {
  TextEditingController _searchTagsEditingController;
  int _selectedLevel;
  String _selectedType;
  DateTime _selectedDateFrom;
  DateTime _selectedDateTo;
  List<String> _uploadTags = [];

  @override
  void initState() {
    _searchTagsEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Container(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[_buildBody()],
      )),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildTitle("Nivel"),
        _buildLevelButtonsRow(),
        _buildTitle("Tipo de Publicación"),
        _buildTypeButtonsRow(),
        _buildTitle("Fecha de Publicación"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildDatePicker(false),
            _buildDatePicker(true),
          ],
        ),
        _buildTitle("Tags"),
        _buildTags(),
        _buildTagAddField(),
        _buildApplyButton()
      ],
    );
  }

  void _createAndSendFilter() {
    Filters newFilter =
        Filters(_selectedLevel, _selectedType, _selectedDateFrom, _selectedDateTo, _uploadTags);
    setState(() {
      widget._callBack(newFilter);
    });
    Navigator.pop(context);
  }

  Widget _buildApplyButton() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10,
        child: GestureDetector(
          onTap: () {
            _createAndSendFilter();
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            width: double.infinity,
            height: 50,
            child: Center(
                child: Text(
              "Aplicar",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }

  Widget _buildTags() {
    return Tags(
      itemCount: _uploadTags.length,
      itemBuilder: (int index) {
        return ItemTags(
          removeButton: ItemTagsRemoveButton(
            icon: Icons.clear,
            onRemoved: () {
              setState(() {
                _uploadTags.removeAt(index);
              });
            },
          ),
          key: Key(index.toString()),
          index: index,
          title: "${_uploadTags[index]}",
          pressEnabled: false,
          textStyle: TextStyle(
            fontSize: 14,
          ),
          combine: ItemTagsCombine.withTextBefore,
        );
      },
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

  Widget _buildTypeButtonsRow() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTypeButton("Parcial", 100, 50),
            _buildTypeButton("Final", 100, 50),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTypeButton("Discusión", 100, 50),
            _buildTypeButton("Cursado", 100, 50),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelButtonsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildLevelButton("1", 50, 50),
        _buildLevelButton("2", 50, 50),
        _buildLevelButton("3", 50, 50),
        _buildLevelButton("4", 50, 50),
        _buildLevelButton("5", 50, 50),
      ],
    );
  }

  Widget _buildTitle(String text) {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 4,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
        ));
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Filtros"),
      elevation: 4,
      backgroundColor: Colors.amber,
    );
  }

  Widget _buildTypeButton(String text, double width, double height) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 3,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 5,
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedType == text) {
                _selectedType = null;
              } else {
                _selectedType = text;
              }
            });
          },
          child: Container(
            decoration: _buildButtonTypeDecoration(text),
            width: width,
            height: height,
            child: _buildContentTypeButton(text),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(String text, double width, double height) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedLevel == int.parse(text)) {
              _selectedLevel = null;
            } else {
              _selectedLevel = int.parse(text);
            }
          });
        },
        child: Container(
          decoration: _buildButtonLevelDecoration(text),
          width: width,
          height: height,
          child: _buildContentLevelButton(text),
        ),
      ),
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

  Center _buildContentTypeButton(String text) {
    return Center(
        child: Text(
      text,
      style: TextStyle(
          color: _selectedType == text ? Colors.white : Colors.amber, fontWeight: FontWeight.bold),
    ));
  }

  BoxDecoration _buildButtonLevelDecoration(String text) {
    return BoxDecoration(
      color: _selectedLevel == int.parse(text) ? Colors.amber : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
          width: 2, color: _selectedLevel == int.parse(text) ? Colors.white : Colors.amber),
    );
  }

  BoxDecoration _buildButtonTypeDecoration(String text) {
    return BoxDecoration(
      color: _selectedType == text ? Colors.amber : Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(width: 2, color: _selectedType == text ? Colors.white : Colors.amber),
    );
  }

  Widget _buildTagAddField() {
    return Container(
      child: EdgePaddingWidget(
          EdgeInsets.all(10.0),
          TextField(
              onChanged: _filterTag,
              controller: _searchTagsEditingController,
              decoration: _buildNameSearchBarDecoration())),
    );
  }

  InputDecoration _buildNameSearchBarDecoration() {
    return InputDecoration(
      labelText: "Agregá un tag",
      hintText: "Cada tag se separa con ,",
      prefixIcon: Icon(Icons.add),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
  }

  void _filterTag(String query) {
    if (query.isNotEmpty) {
      if (query.trim().length > 0) {
        if (query.endsWith(" ")) {
          setState(() {
            String cleanQuery = query.trimLeft();
            String cleanQuery2 = cleanQuery.trimRight();
            _uploadTags.add(cleanQuery2);
            _searchTagsEditingController.clear();
          });
        }
      }
    }
  }
}
