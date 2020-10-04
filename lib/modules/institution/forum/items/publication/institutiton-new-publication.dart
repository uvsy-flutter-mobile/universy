import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/paddings/edge.dart';

class InstitutionNewPublication extends StatefulWidget {
  final Function(ForumPublication) _callBack;

  InstitutionNewPublication({Key key, Function(ForumPublication) callBack})
      : this._callBack = callBack,
        super(key: key);

  @override
  _InstitutionNewPublicationState createState() => _InstitutionNewPublicationState();
}

class _InstitutionNewPublicationState extends State<InstitutionNewPublication> {
  List<DropdownMenuItem> levels = List<DropdownMenuItem>();
  List<DropdownMenuItem> types = List<DropdownMenuItem>();
  DropdownMenuItem _selectedLevel;
  DropdownMenuItem _selectedType;
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    DropdownMenuItem defaultLevel = DropdownMenuItem(value: 0, child: Text("-"));
    DropdownMenuItem level1 = DropdownMenuItem(value: 1, child: Text("1"));
    DropdownMenuItem level2 = DropdownMenuItem(value: 2, child: Text("2"));
    DropdownMenuItem level3 = DropdownMenuItem(value: 3, child: Text("3"));
    DropdownMenuItem level4 = DropdownMenuItem(value: 4, child: Text("4"));
    DropdownMenuItem level5 = DropdownMenuItem(value: 5, child: Text("5"));
    levels.add(defaultLevel);
    levels.add(level1);
    levels.add(level2);
    levels.add(level3);
    levels.add(level4);
    levels.add(level5);
    DropdownMenuItem defaultType = DropdownMenuItem(value: 0, child: Text("-"));
    DropdownMenuItem type1 = DropdownMenuItem(value: "Final", child: Text("Final"));
    DropdownMenuItem type2 = DropdownMenuItem(value: "Discusion", child: Text("Discusion"));
    DropdownMenuItem type3 = DropdownMenuItem(value: "Cursado", child: Text("Cursado"));
    DropdownMenuItem type4 = DropdownMenuItem(value: "Parcial", child: Text("Parcial"));
    types.add(defaultType);
    types.add(type1);
    types.add(type2);
    types.add(type3);
    types.add(type4);
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
      title: Text("Nueva Publicación"),
      elevation: 4,
      backgroundColor: Colors.amber,
    );
  }

  Widget _buildBody() {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _buildTextTitle(),
        _buildLevelAndTypeSelector(),
        _buildTextDescription(),
        _buildConfirmAndCancelButtons()
      ],
    );
  }

  Widget _buildConfirmAndCancelButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[SaveButton(onSave: _savePublication,), CancelButton()],
    );
  }

  void _savePublication()async{
    if((_titleController.text.trim()!=null) && (_descriptionController.text.trim() != null)){
      String title = _titleController.text.trim();
      //Student student = await Services.of(context).profileService().getStudentProfile();
      Profile profile = Profile("1234555","Guido","Henry","Pololo");
      String description = _descriptionController.text.trim();
      DateTime date = DateTime.now();
      print(_selectedType.value);
      print(_selectedLevel.value);
      List<String> listTags = ["asd","asd"];
      ForumPublication forumPublication = ForumPublication(1,title,profile,description,date,[],_selectedLevel.value,_selectedType.value,listTags);
      //await Services.of(context).institutionForumService().saveForumPublication(forumPublication);
      setState(() {
        print(forumPublication.title);
        widget._callBack(forumPublication);
        Navigator.pop(context);
      });
    }
  }

  Widget _buildTextDescription() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 7,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5,
        child: TextField(
          controller: _descriptionController,
          decoration: InputDecoration(hintText: "Explayate titán"),
          maxLines: 10,
          maxLength: 500,
        ),
      ),
    );
  }

  Widget _buildLevelAndTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SymmetricEdgePaddingWidget.horizontal(
                  paddingValue: 6,
                  child: Text(
                    "Nivel",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SymmetricEdgePaddingWidget.horizontal(paddingValue: 10, child: _getDropDownLevel()),
            ],
          ),
        ),
        Card(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              SymmetricEdgePaddingWidget.horizontal(
                  paddingValue: 6,
                  child: Text(
                    "Tipo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              SymmetricEdgePaddingWidget.horizontal(paddingValue: 10, child: _getDropDownType()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getDropDownLevel() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    if (_selectedLevel != null) {
      dropdownValue = _selectedLevel;
    } else {
      dropdownValue = this.levels[0];
    }
    return DropdownButton<DropdownMenuItem>(
      key: key,
      value: dropdownValue,
      elevation: 6,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownLevel,
      items: this.levels.map<DropdownMenuItem<DropdownMenuItem>>((DropdownMenuItem value) {
        return DropdownMenuItem<DropdownMenuItem>(
          value: value,
          child: value.child,
        );
      }).toList(),
    );
  }

  void _onChangeDropDownLevel(DropdownMenuItem newValue) {
    return setState(() {
      this._selectedLevel = newValue;
    });
  }

  Widget _getDropDownType() {
    GlobalKey key = GlobalKey();
    DropdownMenuItem dropdownValue;
    if (_selectedType != null) {
      dropdownValue = _selectedType;
    } else {
      dropdownValue = this.types[0];
    }
    return DropdownButton<DropdownMenuItem>(
      key: key,
      value: dropdownValue,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownType,
      items: this.types.map<DropdownMenuItem<DropdownMenuItem>>((DropdownMenuItem value) {
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
      paddingValue: 7,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5,
        child: TextField(
          controller: _titleController,
          decoration: InputDecoration(hintText: "Título"),
          maxLines: 1,
          maxLength: 50,
        ),
      ),
    );
  }
}
