import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:universy/model/account/profile.dart';
import 'package:universy/model/institution/commission.dart';
import 'package:universy/model/institution/forum.dart';
import 'package:universy/model/institution/subject.dart';
import 'package:universy/modules/institution/forum/bloc/cubit.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/dialog/confirm.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

class NewPublicationWidget extends StatefulWidget {
  final Profile _profile;
  final List<InstitutionSubject> _subjects;
  final List<Commission> _commissions;
  final bool _isUpdate;
  final ForumPublication _forumPublication;

  NewPublicationWidget(
      {Key key,
      Function(ForumPublication) callBack,
      List<InstitutionSubject> subjects,
      List<Commission> commissions,
      ForumPublication forumPublication,
      bool isUpdate,
      Profile profile})
      : this._profile = profile,
        this._subjects = subjects,
        this._commissions = commissions,
        this._isUpdate = isUpdate,
        this._forumPublication = forumPublication,
        super(key: key);

  @override
  _NewPublicationWidgetState createState() => _NewPublicationWidgetState();
}

class _NewPublicationWidgetState extends State<NewPublicationWidget> {
  final MAX_LENGTH_DESCRIPTION = 500;
  final MAX_LENGTH_TITLE = 50;
  List<InstitutionSubject> _subjects;
  List<Commission> _commissions;
  InstitutionSubject _selectedSubject;
  Commission _selectedCommission;
  Profile _profile;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _searchTagsEditingController;
  List<String> _uploadTags = [];
  bool _maxTags;

  ScrollController _scrollController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _subjects = widget._subjects;
    _commissions = widget._commissions;
    _profile = widget._profile;
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _searchTagsEditingController = TextEditingController();

    if (widget._isUpdate) {
      _titleController.text = widget._forumPublication.title;
    }
    if (widget._isUpdate) {
      _descriptionController.text = widget._forumPublication.description;
    }
    (widget._isUpdate) ? _uploadTags = widget._forumPublication.tags : [];
    _scrollController = ScrollController();
    _maxTags = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (this._uploadTags.length >= 10) {
      setState(() {
        _maxTags = true;
      });
    }
    return Form(
      key: _formKey,
      child: SymmetricEdgePaddingWidget.vertical(
        paddingValue: 5,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 5,
          child: Card(
            child: _buildListView(context),
          ),
        ),
      ),
    );
  }

  ListView _buildListView(BuildContext context) {
    return ListView(
      controller: _scrollController,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _buildHeader(),
        Divider(),
        _buildTextFieldTitle(),
        Divider(),
        _buildTextFieldDescription(context),
        Divider(),
        _buildTags(),
        _buildAddTagsSection(),
        Divider(),
        _buildConfirmAndCancelButtons(context)
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

  void _filterTag(String query) {
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
          flex: 3,
          child: SymmetricEdgePaddingWidget.vertical(
            paddingValue: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _buildUserInfo(),
                _getDropDownSubject(),
                _getDropDownCommission(),
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

  Widget _buildConfirmAndCancelButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SaveButton(
          onSave: () => {_buildPublicationRequest(context)},
        ),
        CancelButton(
          onCancel: () => {_cancelNewPublication(context)},
        )
      ],
    );
  }

  void _buildPublicationRequest(BuildContext context) {
    if (this._formKey.currentState.validate()) {
      String title = _titleController.text.trim();
      String description = _descriptionController.text.trim();
      if (_selectedSubject != null) {
        _uploadTags.add(_selectedSubject.name);
        _uploadTags.add(_selectedSubject.level.toString());
      }
      if (_selectedCommission != null) {
        _uploadTags.add(_selectedCommission.name);
      }

      if (widget._isUpdate == false) {
        BlocProvider.of<InstitutionForumCubit>(context)
            .addForumPublication(title, description, _uploadTags);
      } else {
        BlocProvider.of<InstitutionForumCubit>(context).updateForumPublication(
            title, description, _uploadTags, widget._forumPublication.idPublication);
      }
    }
  }

  void _cancelNewPublication(BuildContext context) {
    BlocProvider.of<InstitutionForumCubit>(context).fetchPublications([]);
  }

  Widget _buildTextFieldDescription(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: CustomTextFormField(
        maxLines: 9,
        controller: _descriptionController,
        decorationBuilder: ForumInputDescriptionDecorationBuilder(
            AppText.getInstance().get("institution.forum.publication.hintDescription")),
        validatorBuilder: TextFieldForumValidatorBuilder(
            AppText.getInstance().get("institution.forum.publication.errorDescription"),
            AppText.getInstance().get("institution.forum.publication.errorDescriptionMaxLength") +
                MAX_LENGTH_DESCRIPTION.toString(),
            MAX_LENGTH_DESCRIPTION),
      ),
    );
  }

  Widget _buildTextFieldTitle() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: CustomTextFormField(
        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        controller: _titleController,
        decorationBuilder: ForumInputTitleDecorationBuilder(
            AppText.getInstance().get("institution.forum.publication.hintTitle")),
        validatorBuilder: TextFieldForumValidatorBuilder(
          AppText.getInstance().get("institution.forum.publication.errorTitle"),
          AppText.getInstance().get("institution.forum.publication.errorTitleMaxLength") +
              MAX_LENGTH_TITLE.toString(),
          MAX_LENGTH_TITLE,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _getDropDownSubject() {
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
      items: (this._maxTags && widget._isUpdate)
          ? null
          : _subjects.map((x) {
              return new DropdownMenuItem<InstitutionSubject>(
                value: x,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.0,
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
        AppText.getInstance().get("institution.forum.filter.commission"),
        textAlign: TextAlign.center,
      ),
      value: (this._selectedCommission == null) ? dropdownValue : this._selectedCommission,
      elevation: 6,
      style: TextStyle(color: Colors.black),
      onChanged: _onChangeDropDownCommission,
      items: (this._maxTags && widget._isUpdate)
          ? null
          : _commissions.map((x) {
              return new DropdownMenuItem<Commission>(
                value: x,
                child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.0,
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
}
