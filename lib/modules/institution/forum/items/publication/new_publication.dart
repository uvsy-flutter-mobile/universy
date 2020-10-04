import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NewPublicationWidget extends StatefulWidget {
  final Function(ForumPublication) _callBack;
  final List<InstitutionSubject> _subjects;

  NewPublicationWidget(
      {Key key, Function(ForumPublication) callBack, List<InstitutionSubject> subjects})
      : this._callBack = callBack,
        this._subjects = subjects,
        super(key: key);

  @override
  _NewPublicationWidgetState createState() => _NewPublicationWidgetState();
}

class _NewPublicationWidgetState extends State<NewPublicationWidget> {
  List<InstitutionSubject> _subjects;

  //List<DropdownMenuItem> _subjects = List<DropdownMenuItem>();
  List<DropdownMenuItem> _courses = List<DropdownMenuItem>();
  InstitutionSubject _selectedLevel;
  DropdownMenuItem _selectedType;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _searchTagsEditingController = TextEditingController();
  List<String> _uploadTags = [];
  bool _maxTags;

  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _maxTags = false;
    _uploadTags = [];
    DropdownMenuItem type1 = DropdownMenuItem(value: "Final", child: Text("Final"));
    DropdownMenuItem type2 = DropdownMenuItem(value: "Discusion", child: Text("Discusion"));
    DropdownMenuItem type3 = DropdownMenuItem(value: "Cursado", child: Text("Cursado"));
    DropdownMenuItem type4 = DropdownMenuItem(value: "Parcial", child: Text("Parcial"));
    _courses.add(type1);
    _courses.add(type2);
    _courses.add(type3);
    _courses.add(type4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Crear Publicación"),
      elevation: 4,
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBody() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10,
        child: Card(
          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              _buildHeader(),
              Divider(),
              _buildTextTitle(),
              Divider(),
              _buildTextDescription(),
              Divider(),
              _buildTags(),
              _buildAddTagsSection(),
              Divider(),
              _buildConfirmAndCancelButtons()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddTagsSection() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Visibility(
        visible: !_maxTags,
        replacement: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 10,
            child: Text(
              "Has llegado al máximo de tags permitidos, pagá la versión PREMIUM, o eliminá algún TAG.",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            )),
        child: TextField(
            enabled: !_maxTags,
            onChanged: _filterTag,
            controller: _searchTagsEditingController,
            decoration: _buildTagAddDecoration()),
      ),
    );
  }

  InputDecoration _buildTagAddDecoration() {
    return InputDecoration.collapsed(
      hintStyle: TextStyle(color: Colors.grey),
      hintText: "Agregá a tu publicación #",
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

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Icon(
            Icons.perm_identity,
            size: 35,
          ),
        ),
        Expanded(
          flex: 5,
          child: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Guido Henry",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                ),
                _buildLevelAndTypeSelector(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmAndCancelButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SaveButton(
          onSave: _savePublication,
        ),
        CancelButton()
      ],
    );
  }

  void _savePublication() async {
    if ((_titleController.text.trim() != null) && (_descriptionController.text.trim() != null)) {
      String title = _titleController.text.trim();
      //Student student = await Services.of(context).profileService().getStudentProfile();
      Profile profile = Profile("1234555", "Guido", "Henry", "Pololo");
      String description = _descriptionController.text.trim();
      DateTime date = DateTime.now();
      print(_selectedType.value);
      //print(_selectedLevel.value);
      List<String> listTags = ["asd", "asd"];
      //ForumPublication forumPublication = ForumPublication(1, title, profile, description, date, [],          _selectedLevel.value, _selectedType.value, listTags);
      //await Services.of(context).institutionForumService().saveForumPublication(forumPublication);
      setState(() {
        //print(forumPublication.title);
        //widget._callBack(forumPublication);
        Navigator.pop(context);
      });
    }
  }

  Widget _buildTextDescription() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: TextField(
        controller: _descriptionController,
        decoration: InputDecoration.collapsed(
            hintText: "Explayate titán !", hintStyle: TextStyle(color: Colors.grey)),
        maxLines: 10,
      ),
    );
  }

  Widget _buildLevelAndTypeSelector() {
    return Row(
      children: <Widget>[
        _getDropDownSubject(),
        //SymmetricEdgePaddingWidget.horizontal(paddingValue: 10, child: _getDropDownComision()),
      ],
    );
  }

  Widget _getDropDownSubject() {
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
      items: widget._subjects.map((x) {
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
      this._selectedLevel = newValue;
    });
  }

  Widget _getDropDownComision() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    return DropdownButton<DropdownMenuItem>(
      key: key,
      hint: Text("Comisión"),
      value: dropdownValue,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownType,
      items: this._courses.map<DropdownMenuItem<DropdownMenuItem>>((DropdownMenuItem value) {
        return DropdownMenuItem<DropdownMenuItem>(
          value: value,
          child: value.child,
        );
      }).toList(),
    );
  }

  void _onChangeDropDownType(DropdownMenuItem newValue) {
    return setState(() {
      this._selectedType = newValue;
    });
  }

  Widget _buildTextTitle() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: TextField(
        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        controller: _titleController,
        decoration: InputDecoration.collapsed(
            hintText: "Escribe el título de tu publicación",
            hintStyle: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        maxLines: 1,
      ),
    );
  }
}
