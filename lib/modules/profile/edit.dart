/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/account.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/modules/profile/header.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'keys.dart';

class ProfileProfileEditWidget extends StatefulWidget {
  final Profile _profile;

  const ProfileProfileEditWidget({Key key, @required Profile profile})
      : this._profile = profile,
        super(key: key);

  @override
  _ProfileProfileEditState createState() => _ProfileProfileEditState();
}

class _ProfileProfileEditState extends State<ProfileProfileEditWidget> {
  GlobalKey<FormState> _formKeyLog;
  TextEditingController _nameController;
  TextEditingController _lastNameController;

  Profile _profile;
  SaveLock _saveLock;

  @override
  void initState() {
    this._profile = widget._profile;
    this._saveLock = SaveLock.lock(snapshot: _profile);
    this._formKeyLog = GlobalKey<FormState>();
    this._nameController = TextEditingController()..text = _profile.name;
    this._lastNameController = TextEditingController()..text = _profile.lastName;
    super.initState();
  }

  @override
  void dispose() {
    this._profile = null;
    this._saveLock = null;
    this._nameController.dispose();
    this._nameController = null;
    this._lastNameController.dispose();
    this._lastNameController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScrollableListView(
      children: <Widget>[
        Container(
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              children: <Widget>[
                ProfileHeaderWidget(this._profile),
                _buildProfileForm(context),
              ],
            )),
      ],
    ));
  }

  Widget _buildProfileForm(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 75,
      child: Form(
        key: _formKeyLog,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildGivenNameInput(),
            _buildFamilyNameInput(),
            _buildSaveButton(context),
            _buildCancelButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildGivenNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        key: STUDENT_PROFILE_KEY_GIVEN_NAME_FIELD,
        textCapitalization: TextCapitalization.words,
        controller: _nameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
          regExp: Regex.LETTERS_FORMAT_REGEX,
          patternMessage: AppText.getInstance().get("profile.profile.name.notValid"),
          emptyMessage: AppText.getInstance().get("profile.profile.name.required"),
        ),
        decorationBuilder: TextInputDecorationBuilder(
          AppText.getInstance().get("profile.profile.name.inputMessage"),
        ),
      ),
    );
  }

  Widget _buildFamilyNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        textCapitalization: TextCapitalization.words,
        key: STUDENT_PROFILE_KEY_FAMILY_NAME_FIELD,
        controller: _lastNameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
          regExp: Regex.LETTERS_FORMAT_REGEX,
          patternMessage: AppText.getInstance().get("profile.profile.lastName.notValid"),
          emptyMessage: AppText.getInstance().get("profile.profile.lastName.required"),
        ),
        decorationBuilder: TextInputDecorationBuilder(
          AppText.getInstance().get("profile.profile.lastName.inputMessage"),
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 5.0,
      child: SizedBox(
        width: double.infinity,
        child: CircularRoundedRectangleRaisedButton.general(
          key: STUDENT_PROFILE_KEY_SAVE_BUTTON,
          radius: 10,
          onPressed: _pressSaveProfileButton(context),
          color: Theme.of(context).accentColor,
          child: SymmetricEdgePaddingWidget.horizontal(
            paddingValue: 10,
            child: Text(
              AppText.getInstance().get("profile.profile.action.saveButton"),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CircularRoundedRectangleRaisedButton.general(
        key: STUDENT_PROFILE_KEY_CANCEL_BUTTON,
        radius: 10,
        onPressed: () => _dispatchInfoProfileProfileEvent(context),
        color: Colors.black26,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 10,
          child: Text(
            AppText.getInstance().get("profile.profile.action.cancelButton"),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  VoidCallback _pressSaveProfileButton(BuildContext context) {
    return () async {
      if (_formKeyLog.currentState.validate()) {
        _profile = _getProfileProfileFromTextFields();

        if (_saveLock.shouldSave(_profile)) {
          FocusScope.of(context).unfocus();
          await AsyncModalBuilder()
              .perform((context) => _saveProfile(context, _profile))
              .withTitle(_savingMessage())
              .then(_navigateToProfileInfo)
              //.handle(ProfileNotSaved, _showProfileNotSavedFlushBar)
              .build()
              .run(context);
        } else {
          _dispatchInfoProfileProfileEvent(context);
        }
      }
    };
  }

  void _navigateToProfileInfo(BuildContext context) {
    _dispatchInfoProfileProfileEvent(context);
    _showProfileUpdated(context);
  }

  void _dispatchInfoProfileProfileEvent(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileProfileBloc>(context);
    profileBloc.dispatch(InfoProfileProfileEvent(_profile));
  }

  void _showProfileUpdated(BuildContext context) {
    FlushBarBroker()
        .withMessage(AppText.getInstance().get("profile.profile.action.profileUpdated"))
        .withIcon(Icon(Icons.check, color: Colors.green))
        .show(context);
  }

  Future<void> _saveProfile(BuildContext context, Profile profile) async {
    await _getProfileService(context).saveProfileProfile(profile);
  }

  ProfileService _getProfileService(BuildContext context) {
    return Services.of(context).profileService();
  }

  Profile _getProfileProfileFromTextFields() {
    return Profile(
      _profile.userId,
      _profile.alias,
      _lastNameController.text.trim(),
      _nameController.text.trim(),
    );
  }

  void _showProfileNotSavedFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_profileNotSavedMessage())
        .withIcon(Icon(Icons.error_outline, color: Colors.redAccent))
        .show(context);
  }

  String _savingMessage() => AppText.getInstance().get("profile.profile.action.saving");

  String _profileNotSavedMessage() =>
      AppText.getInstance().get("profile.profile.error.profileNotSaved");
}
*/
