import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/modules/account/keys.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/uvsy/cancel.dart';
import 'package:universy/widgets/buttons/uvsy/save.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';
import 'package:universy/widgets/text/custom.dart';

import 'bloc/cubit.dart';
import 'header.dart';

class ChangePasswordWidget extends StatefulWidget {
  final String _userId;

  const ChangePasswordWidget(String userId, {Key key})
      : this._userId = userId,
        super(key: key);

  @override
  _ChangePasswordWidgetState createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userId;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _firstPasswordController =
      TextEditingController();
  final TextEditingController _secondPasswordController =
      TextEditingController();
  bool _passwordHidden;

  @override
  void initState() {
    super.initState();
    this._passwordHidden = true;
    this._userId = widget._userId;
  }

  @override
  void dispose() {
    this._passwordHidden = null;
    this._userId = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.transparent,
          alignment: AlignmentDirectional.topCenter,
          child: Column(
            children: <Widget>[
              ProfileHeaderWidget.changePassword(),
              _buildPasswordForm(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordForm(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 60,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NewPasswordTitleWidget(),
            OldPasswordWidget(
              textEditingController: _oldPasswordController,
              obscure: _passwordHidden,
              onPressed: _changePasswordVisibilityOnPressedAction,
              hint: AppText.getInstance()
                  .get("recoverPassword.newPassword.input.user.oldPassword"),
            ),
            NewPasswordWidget(
              textEditingController: _firstPasswordController,
              secondEmailEditingController: _secondPasswordController,
              obscure: _passwordHidden,
              onPressed: _changePasswordVisibilityOnPressedAction,
              hint: AppText.getInstance()
                  .get("recoverPassword.newPassword.input.user.message"),
            ),
            NewPasswordWidget(
              textEditingController: _secondPasswordController,
              secondEmailEditingController: _firstPasswordController,
              obscure: _passwordHidden,
              onPressed: _changePasswordVisibilityOnPressedAction,
              hint: AppText.getInstance()
                  .get("recoverPassword.newPassword.input.user.messageCheck"),
            ),
            NewPasswordConfirmButtonWidget(
              createButtonAction: _submitButtonOnPressedAction,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _firstPasswordController.text.trim();
    User user = User(_userId, oldPassword);
    var accountService =
        Provider.of<ServiceFactory>(context, listen: false).accountService();
    await accountService.changePassword(user, newPassword);
  }

  void _submitButtonOnPressedAction(BuildContext context) async {
    if (this._formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_changePassword)
          .then(_navigateToHomeScreen)
          .handle(NotAuthorized, _showActualPasswordIncorrect)
          .build()
          .run(context);
    }
  }

  void _showActualPasswordIncorrect(BuildContext context) {
    FlushBarBroker()
        .withMessage(_actualPasswordIncorrect())
        .withIcon(Icon(Icons.block, color: Colors.redAccent))
        .show(context);
  }

  String _actualPasswordIncorrect() => AppText.getInstance()
      .get("recoverPassword.newPassword.input.user.oldPasswordIncorrect");

  String _passwordChangedCorrectly() => AppText.getInstance()
      .get("recoverPassword.newPassword.passwordChangedCorrectly");

  void _navigateToHomeScreen(BuildContext context) {
    FlushBarBroker().clear();
    _showPasswordChangedCorrectly(context);
    BlocProvider.of<ProfileCubit>(context).toDisplay();
  }

  void _showPasswordChangedCorrectly(BuildContext context) {
    FlushBarBroker()
        .withMessage(_passwordChangedCorrectly())
        .withIcon(Icon(Icons.check, color: Colors.green))
        .show(context);
  }

  void _changePasswordVisibilityOnPressedAction() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }
}

class NewPasswordWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final TextEditingController _secondTextEditingController;
  final bool _obscure;
  final Function() _onPressed;
  final String _hint;

  const NewPasswordWidget(
      {Key key,
      @required TextEditingController textEditingController,
      @required TextEditingController secondEmailEditingController,
      @required bool obscure,
      @required Function() onPressed,
      @required String hint})
      : this._textEditingController = textEditingController,
        this._secondTextEditingController = secondEmailEditingController,
        this._obscure = obscure,
        this._hint = hint,
        this._onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        obscure: _obscure,
        maxLines: 1,
        key: SIGNUP_KEY_USER_FIELD,
        keyboardType: TextInputType.emailAddress,
        controller: _textEditingController,
        validatorBuilder: _buildPasswordValidator(),
        decorationBuilder: _getPasswordDecoration(),
      ),
    );
  }

  InputDecorationBuilder _getPasswordDecoration() {
    return IconButtonInputDecorationBuilder(
      labelText: _hint,
      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: _onPressed,
    );
  }

  TextFormFieldValidatorBuilder _buildPasswordValidator() {
    return NotEqualPatternTextFormValidatorBuilderPassword(
      controllerToComparate: _secondTextEditingController,
      regExp: Regex.PASSWORD_FORMAT_REGEX,
      notEqualMessage:
          AppText.getInstance().get("signUp.input.password.notEqual"),
      patternMessage:
          AppText.getInstance().get("signUp.input.password.notValid"),
      emptyMessage: AppText.getInstance().get("signUp.input.password.required"),
    );
  }
}

class OldPasswordWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _obscure;
  final Function() _onPressed;
  final String _hint;

  const OldPasswordWidget(
      {Key key,
      @required TextEditingController textEditingController,
      @required bool obscure,
      @required Function() onPressed,
      @required String hint})
      : this._textEditingController = textEditingController,
        this._obscure = obscure,
        this._hint = hint,
        this._onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        maxLines: 1,
        obscure: _obscure,
        key: SIGNUP_KEY_USER_FIELD,
        keyboardType: TextInputType.emailAddress,
        controller: _textEditingController,
        validatorBuilder: _getPasswordValidator(),
        decorationBuilder: _getPasswordDecoration(),
      ),
    );
  }

  InputDecorationBuilder _getPasswordDecoration() {
    return IconButtonInputDecorationBuilder(
      labelText: _hint,
      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: _onPressed,
    );
  }

  TextFormFieldValidatorBuilder _getPasswordValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(
      AppText.getInstance().get("login.input.password.required"),
    );
  }
}

class NewPasswordTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: EllipsisCustomText.left(
        text: AppText.getInstance().get("recoverPassword.newPassword.title"),
        textStyle: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

class NewPasswordConfirmButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _createButtonAction;

  const NewPasswordConfirmButtonWidget(
      {Key key, @required Function(BuildContext context) createButtonAction})
      : this._createButtonAction = createButtonAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SaveButton(onSave: () => _createButtonAction(context)),
          CancelButton(onCancel: () => _navigateToDisplay(context)),
        ],
      ),
    );
  }

  void _navigateToDisplay(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).toDisplay();
  }
}
