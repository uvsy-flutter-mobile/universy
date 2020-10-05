import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/filters/filter_button.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_item.dart';
import 'package:universy/widgets/paddings/edge.dart';

class ForumViewWidget extends StatefulWidget {
  final List<ForumPublication> _listPublications;

  const ForumViewWidget({Key key, @required List<ForumPublication> forumPublications})
      : this._listPublications = forumPublications,
        super(key: key);

  @override
  _InstitutionForumModuleState createState() => _InstitutionForumModuleState();
}

class _InstitutionForumModuleState extends State<ForumViewWidget> {
  TextEditingController _searchTextEditingController;
  List<DropdownMenuItem> items = List<DropdownMenuItem>();
  DropdownMenuItem _selected;

  List<ForumPublication> _listPublications = [];

  @override
  void initState() {
    _listPublications = widget._listPublications;
    _searchTextEditingController = TextEditingController();
    DropdownMenuItem item1 = DropdownMenuItem(value: 0, child: Text("Más recientes"));
    DropdownMenuItem item2 = DropdownMenuItem(value: 1, child: Text("Más antiguos"));
    DropdownMenuItem item3 = DropdownMenuItem(value: 2, child: Text("Más comentados"));
    items.add(item1);
    items.add(item2);
    items.add(item3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 6,
      child: Column(
        children: <Widget>[_buildSearchField(), _buildOrderBy(), _buildPublications()],
      ),
    );
  }

  Widget _buildOrderBy() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              "Ordenar por:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(flex: 4, child: _getDropDown()),
          Expanded(
            flex: 3,
            child: FilterButtonWidget(
              callBack: _fetchFilters,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getDropDown() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    if (_selected != null) {
      dropdownValue = _selected;
    } else {
      dropdownValue = this.items[0];
    }
    return DropdownButton<DropdownMenuItem>(
      key: key,
      value: dropdownValue,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDown,
      items: this.items.map<DropdownMenuItem<DropdownMenuItem>>((DropdownMenuItem value) {
        return DropdownMenuItem<DropdownMenuItem>(
          value: value,
          child: value.child,
        );
      }).toList(),
    );
  }

  void _onChangeDropDown(DropdownMenuItem newValue) {
    return setState(() {
      this._selected = newValue;
      _onChangedOrderBy(newValue.value);
    });
  }

  void _onChangedOrderBy(int newValue) {
    List<ForumPublication> orderedPublications = this._listPublications;
    switch (newValue) {
      case 0:
        {
          orderedPublications.sort((a, b) => a.date.compareTo(b.date));
        }
        break;
      case 1:
        {
          orderedPublications.sort((a, b) => b.date.compareTo(a.date));
        }
        break;
      case 2:
        {
          orderedPublications.sort((a, b) => b.comments.length.compareTo(a.comments.length));
        }
    }
    setState(() {
      this._listPublications = orderedPublications;
    });
  }

  void _fetchFilters(Filters filters) {
    print(filters.selectedLevel);
    print(filters.selectedType);
    print(filters.dateFrom);
    print(filters.dateTo);
    Filters newFilter = filters;
    setState(() {
      //widget._callBack(newFilter);
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Foro"),
      elevation: 4,
      backgroundColor: Colors.white,
    );
  }

  Widget _buildSearchField() {
    return EdgePaddingWidget(
      EdgeInsets.all(15.0),
      TextField(
        controller: _searchTextEditingController,
        decoration: _buildNameSearchBarDecoration(),
      ),
    );
  }

  InputDecoration _buildNameSearchBarDecoration() {
    return InputDecoration(
      labelText: "Buscar publicacion",
      hintText: "Buscar...",
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
    );
  }

  Widget _buildPublications() {
    return Expanded(flex: 10, child: _buildForumPublicationsList());
  }

  Widget _buildForumPublicationsList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      itemCount: this._listPublications.length,
      itemBuilder: (BuildContext context, int index) {
        ForumPublication forumPublication = this._listPublications[index];
        return _buildStudentNoteCardWidget(forumPublication, index);
      },
    );
  }

  Widget _buildStudentNoteCardWidget(ForumPublication forumPublication, index) {
    return PublicationItemWidget(forumPublication: forumPublication);
  }
}
