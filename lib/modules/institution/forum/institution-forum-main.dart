import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/modules/institution/forum/items/filters/filter_button.dart';
import 'package:universy/modules/institution/forum/items/publication/publication_item.dart';
import 'package:universy/modules/institution/forum/items/publication/new_publication.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/system/assets.dart';
import 'package:universy/widgets/decorations/box.dart';
import 'package:universy/widgets/paddings/edge.dart';

class InstitutionForumModule extends StatefulWidget {
  final List<ForumPublication> _listPublications;

  const InstitutionForumModule({Key key, @required List<ForumPublication> forumPublications})
      : this._listPublications = forumPublications,
        super(key: key);

  @override
  _InstitutionForumModuleState createState() => _InstitutionForumModuleState();
}

class _InstitutionForumModuleState extends State<InstitutionForumModule> {
  TextEditingController _searchTextEditingController;
  List<ForumPublication> _listOfPublications = [];
  List<DropdownMenuItem> items = List<DropdownMenuItem>();
  DropdownMenuItem _selected;
  List<String> _listTags = [];

  @override
  void initState() {
    _listOfPublications = new List();
    _listTags = new List();
    List<Comment> list = List<Comment>();
    Profile student = Profile("1521515", "Guido", "Henry", "Pepe");
    Comment comment = Comment(1, student, "La verdad que me parece agradable", DateTime.now());
    list.add(comment);
    list.add(comment);
    list.add(comment);
    list.add(comment);
    _listTags.add("MATSUP");
    _listTags.add("AM1");
    _listTags.add("AM2");
    _listTags.add("AM3");
    ForumPublication publication1 = new ForumPublication(
        1,
        "Donde curso Diseño?",
        student,
        "Tengo una consulta sobre la materia ..Tengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una consulta sobre la materiaTengo una ..",
        DateTime.now(),
        list,
        3,
        "Final",
        _listTags);
    ForumPublication publication2 = new ForumPublication(2, "Sorocotongo", student,
        "Que ondera Superior ? Te rompen el toto ?", DateTime(2014), list, 2, "Final", _listTags);
    _listOfPublications.add(publication1);
    _listOfPublications.add(publication2);
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
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: _buildColumn(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _onFloatingPressed(context);
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      backgroundColor: Colors.amber,
    );
  }

  void _onFloatingPressed(BuildContext context) async {
    var sessionFactory = await Provider.of<ServiceFactory>(context, listen: false);
    var careerService = await sessionFactory.studentCareerService();
    var institutionService = sessionFactory.institutionService();
    var programId = await careerService.getCurrentProgram();
    var institutionSubjects = await institutionService.getSubjects(programId);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewPublicationWidget(
                subjects: institutionSubjects,
                callBack: (forumPublication) {
                  _onCallBack(forumPublication);
                },
              )),
    );
  }

  void _onCallBack(ForumPublication forumPublication) {
    print("LLEGO +" + forumPublication.title.toString());
    setState(() {
      this._listOfPublications.add(forumPublication);
    });
  }

  Widget _buildColumn() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 6,
      child: Container(
        decoration: assetImageDecoration(Assets.UNIVERSY_CITY_BACKGROUND),
        child: Column(
          children: <Widget>[_buildSearchField(), _buildOrderBy(), _buildPublications()],
        ),
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
    List<ForumPublication> orderedPublications = this._listOfPublications;
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
      this._listOfPublications = orderedPublications;
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
    if (_listOfPublications == null || _listOfPublications.isEmpty) {
      return _buildInstitutionForumPublicationsNotFoundMessage();
    } else {
      return Expanded(flex: 10, child: _buildForumPublicationsList());
    }
  }

  Widget _buildInstitutionForumPublicationsNotFoundMessage() {
    return Center(
      child: Text(
        "No se encontraron publicaciones en el foro",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildForumPublicationsList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      controller: ScrollController(),
      itemCount: _listOfPublications.length,
      itemBuilder: (BuildContext context, int index) {
        ForumPublication forumPublication = _listOfPublications[index];
        return _buildStudentNoteCardWidget(forumPublication, index);
      },
    );
  }

  Widget _buildStudentNoteCardWidget(ForumPublication forumPublication, index) {
    return PublicationItemWidget(forumPublication: forumPublication);
  }
}
