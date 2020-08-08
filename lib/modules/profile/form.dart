import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/account.dart';
import 'package:universy/model/lock.dart';
import 'package:universy/modules/profile/header.dart';
import 'package:universy/services/exceptions/profile.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/util/strings.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';

import 'bloc/cubit.dart';
import 'keys.dart';

class ProfileFormWidget extends StatefulWidget {
  final Profile _profile;
  final bool _create;

  const ProfileFormWidget._({Key key, @required Profile profile, @required bool create})
      : this._profile = profile,
        this._create = create,
        super(key: key);

  factory ProfileFormWidget.create(String userId) {
    return ProfileFormWidget._(profile: Profile.empty(userId), create: true);
  }

  factory ProfileFormWidget.edit(Profile profile) {
    return ProfileFormWidget._(profile: profile, create: false);
  }

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileFormWidget> {
  GlobalKey<FormState> _formKeyLog;
  TextEditingController _nameController;
  TextEditingController _lastNameController;
  TextEditingController _aliasController;
  bool _aliasAvailable;

  Profile _profile;
  StateLock _saveLock;

  @override
  void initState() {
    this._profile = widget._profile;
    this._saveLock = StateLock.lock(snapshot: _profile);
    this._formKeyLog = GlobalKey<FormState>();
    this._nameController = TextEditingController()..text = _profile.name;
    this._lastNameController = TextEditingController()..text = _profile.lastName;
    this._aliasController = TextEditingController()..text = _profile.alias;
    this._aliasAvailable = true;
    super.initState();
  }


  @override
  void didChangeDependencies() {
    this._aliasController.addListener(() =>_checkAliasAvailability(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    this._profile = null;
    this._saveLock = null;
    this._nameController.dispose();
    this._nameController = null;
    this._lastNameController.dispose();
    this._lastNameController = null;
    this._aliasController.dispose();
    this._aliasController = null;
    this._aliasAvailable = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.topCenter,
            child: Column(
              children: <Widget>[
                ProfileHeaderWidget.edit(this._profile),
                _buildProfileForm(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 75,
      child: Form(
        key: _formKeyLog,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildNameInput(),
            _buildLastNameInput(),
            _buildAliasInput(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        key: STUDENT_PROFILE_KEY_GIVEN_NAME_FIELD,
        textCapitalization: TextCapitalization.words,
        controller: _nameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
          regExp: Regex.LETTERS_FORMAT_REGEX,
          patternMessage: AppText.getInstance().get("profile.input.name.notValid"),
          emptyMessage: AppText.getInstance().get("profile.input.name.required"),
        ),
        decorationBuilder: TextInputDecorationBuilder(
          AppText.getInstance().get("profile.input.name.inputMessage"),
        ),
      ),
    );
  }

  Widget _buildLastNameInput() {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        textCapitalization: TextCapitalization.words,
        key: STUDENT_PROFILE_KEY_FAMILY_NAME_FIELD,
        controller: _lastNameController,
        validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
          regExp: Regex.LETTERS_FORMAT_REGEX,
          patternMessage: AppText.getInstance().get("profile.input.lastName.notValid"),
          emptyMessage: AppText.getInstance().get("profile.input.lastName.required"),
        ),
        decorationBuilder: TextInputDecorationBuilder(
          AppText.getInstance().get("profile.input.lastName.inputMessage"),
        ),
      ),
    );
  }

  Widget _buildAliasInput() {
    return Row(children: <Widget>[
      Expanded(child: _buildAliasTextField(), flex: 16),
      Expanded(child: _buildAvailabilityAliasIcon(), flex: 2)
    ]);
  }

  Widget _buildAliasTextField() {
    return SymmetricEdgePaddingWidget.vertical(
        paddingValue: 6.0,
        child: CustomTextFormField(
          textCapitalization: TextCapitalization.words,
          key: STUDENT_PROFILE_KEY_ALIAS_FIELD,
          controller: _aliasController,
          validatorBuilder: PatternNotEmptyTextFormFieldValidatorBuilder(
            regExp: Regex.ALIAS_FORMAT_REGEX,
            patternMessage: "Alias no valido",
            /*AppText.getInstance().get("profile.input.lastName.notValid"),*/
            emptyMessage:
                "Alias requerido", /* AppText.getInstance().get("profile.input.lastName.required"),*/
          ),
          decorationBuilder: TextInputDecorationBuilder(
            "Ingresa un alias", /* AppText.getInstance().get("profile.input.lastName.inputMessage"),*/
          ),
        ));
  }

  Widget _buildAvailabilityAliasIcon() {
    return Icon(_aliasAvailable ? Icons.check_circle : Icons.cancel,
        color: _aliasAvailable ? Colors.green : Colors.redAccent);
  }

  Future<void> _checkAliasAvailability(BuildContext context) async {
    Profile profile = _getProfileProfileFromTextFields();
    if(!stringEquals(profile.alias, widget._profile.alias) && profile.alias.isNotEmpty) {
      var profileService = Provider.of<ServiceFactory>(context, listen: false).profileService();
      try {
        await profileService.checkAliasProfile(_profile, _aliasController.text);
        setState(() {
          _aliasAvailable = true;
        });
      } on AliasAlreadyExists {
        setState(() {
          _aliasAvailable = false;
        });
      }
    }
  }

  Widget _buildButtons(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SaveButton(onSave: () => _pressSaveProfileButton(context)),
          CancelButton(onCancel: () => _navigateToDisplay(context)),
        ],
      ),
    );
  }

  Future<void> _pressSaveProfileButton(BuildContext context) async {
    if (_formKeyLog.currentState.validate()) {
      _profile = _getProfileProfileFromTextFields();

      if (_saveLock.hasChange(_profile)) {
        FocusScope.of(context).unfocus();
        await AsyncModalBuilder()
            .perform(_saveProfile)
            .withTitle(_savingMessage())
            .handle(AliasAlreadyExists, _showAliasConflict)
            .then(_showProfileUpdated)
            .build()
            .run(context);
      } else {
        _navigateToDisplay(context);
      }
    }
  }

  Future<void> _saveProfile(BuildContext context) async {
    var profileService = Provider.of<ServiceFactory>(context, listen: false).profileService();
    if (widget._create) {
      await profileService.createProfile(_profile);
    } else {
      await profileService.updateProfile(_profile);
    }
  }

  void _navigateToDisplay(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).toDisplay();
  }

  void _showProfileUpdated(BuildContext context) {
    FlushBarBroker.success()
        .withMessage(AppText.getInstance().get("profile.info.profileUpdated"))
        .show(context);
    _navigateToDisplay(context);
  }

  void _showAliasConflict(BuildContext context) {
    FlushBarBroker.error().withMessage("El Alias ya está en uso").show(context);
  }

  Profile _getProfileProfileFromTextFields() {
    return Profile(
      _profile.userId,
      _nameController.text.trim(),
      _lastNameController.text.trim(),
      _aliasController.text.trim(),
    );
  }

  String _savingMessage() => AppText.getInstance().get("profile.info.saving");
}
