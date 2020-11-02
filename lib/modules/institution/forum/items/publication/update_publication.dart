import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/paddings/edge.dart';

class UpdatePublicationWidget extends StatefulWidget {
  final List<InstitutionSubject> _subjects;
  final ForumPublication _forumPublication;
  final List<Commission> _commissions;
  final Profile _profile;

  UpdatePublicationWidget(
      {Key key,
      Function(ForumPublication) callBack,
      List<InstitutionSubject> subjects,
      List<Commission> commissions,
      ForumPublication forumPublication,
      Profile profile})
      : this._profile = profile,
        this._subjects = subjects,
        this._forumPublication = forumPublication,
        this._commissions = commissions,
        super(key: key);

  @override
  _UpdatePublicationWidgetState createState() => _UpdatePublicationWidgetState();
}

class _UpdatePublicationWidgetState extends State<UpdatePublicationWidget> {
  List<InstitutionSubject> _subjects;
  List<Commission> _commissions;
  InstitutionSubject _selectedSubject;
  Commission _selectedCommission;
  Profile _profile;

  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _searchTagsEditingController = TextEditingController();
  List<String> _uploadTags = [];
  bool _maxTags;

  ScrollController _scrollController;

  @override
  void initState() {
    _titleController.value = TextEditingValue(text: widget._forumPublication.title);
    _descriptionController.value = TextEditingValue(text: widget._forumPublication.description);
    _selectedSubject = widget._subjects.singleWhere((element) => element.name == widget._forumPublication.tags.first);
    _selectedCommission = widget._commissions.singleWhere((element) => element.name == widget._forumPublication.tags[1]);
    _uploadTags = widget._forumPublication.tags;

    _subjects = widget._subjects;
    _commissions = widget._commissions;
    _profile = widget._profile;
    _scrollController = ScrollController();
    if (widget._forumPublication.tags.length > 10) {
      _maxTags = true;
    } else {
      _maxTags = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 10,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 10,
        child: Card(
          child: _buildListView(),
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView(
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
    );
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
        _buildUserIcon(),
        Expanded(
          flex: 5,
          child: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildUserInfo(),
                _buildLevelAndTypeSelector(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Text _buildUserInfo() {
    return Text(
      _profile.name + " " + _profile.lastName,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
    );
  }

  Expanded _buildUserIcon() {
    return Expanded(
      flex: 1,
      child: Icon(
        Icons.perm_identity,
        size: 35,
      ),
    );
  }

  Widget _buildConfirmAndCancelButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SaveButton(
          onSave: _savePublication,
        ),
        CancelButton(
          onCancel: _cancelNewPublication,
        )
      ],
    );
  }

  void _savePublication() async {
    if ((_titleController.text.trim() != null) && (_descriptionController.text.trim() != null)) {
      String title = _titleController.text.trim();
      String description = _descriptionController.text.trim();
      DateTime date = DateTime.now();
      _uploadTags.first = (_selectedSubject.name);
      //ForumPublication forumPublication =          ForumPublication("1", title, this._profile.userId, description, date, _uploadTags);
      // PEGARLE AL SERVICIO PARA GUARDAR LA PUBLICACION, MOSTRAR FLUSHBAR y de ahí llevarlo al VIEW del FORO.
    }
  }

  void _cancelNewPublication() {
    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications();
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
        _getDropDownCommission(),
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
      value: _selectedSubject==null ? dropdownValue:_selectedSubject,
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

  Widget _getDropDownCommission() {
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
