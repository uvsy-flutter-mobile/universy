import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/modules/account/keys.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';
import 'package:universy/widgets/text/custom.dart';

class ProfileChangePasswordWidget extends StatefulWidget {
  final String _userId;

  const ProfileChangePasswordWidget(String userId, {Key key})
      : this._userId = userId,
        super(key: key);

  @override
  _ProfileChangePasswordWidgetState createState() => _ProfileChangePasswordWidgetState();
}

class _ProfileChangePasswordWidgetState extends State<ProfileChangePasswordWidget> {
  final _formKey = GlobalKey<FormState>();
  String _userId;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _firstPasswordController = TextEditingController();
  final TextEditingController _secondPasswordController = TextEditingController();
  bool _passwordHidden;

  @override
  void initState() {
    super.initState();
    _passwordHidden = true;
    _userId = widget._userId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SymmetricEdgePaddingWidget.horizontal(
          paddingValue: 25.0,
          child: Column(
            children: <Widget>[
              NewPasswordTitleWidget(),
              OldPasswordWidget(
                textEditingController: _oldPasswordController,
                obscure: _passwordHidden,
                onPressed: _changePasswordVisibilityOnPressedAction,
                hint:
                    AppText.getInstance().get("recoverPassword.newPassword.input.user.oldPassword"),
              ),
              NewPasswordWidget(
                textEditingController: _firstPasswordController,
                secondEmailEditingController: _secondPasswordController,
                obscure: _passwordHidden,
                onPressed: _changePasswordVisibilityOnPressedAction,
                hint: AppText.getInstance().get("recoverPassword.newPassword.input.user.message"),
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
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    String oldPassword = _oldPasswordController.text.trim();
    String newPassword = _firstPasswordController.text.trim();
    User user = User(_userId, oldPassword);
    var accountService = Provider.of<ServiceFactory>(context, listen: false).accountService();
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
    } else {
      return;
    }
  }

  void _showActualPasswordIncorrect(BuildContext context) {
    FlushBarBroker()
        .withMessage(_actualPasswordIncorrect())
        .withIcon(Icon(Icons.block, color: Colors.redAccent))
        .show(context);
  }

  String _actualPasswordIncorrect() =>
      AppText.getInstance().get("recoverPassword.newPassword.input.user.oldPasswordIncorrect");

  String _passwordChangedCorrectly() =>
      AppText.getInstance().get("recoverPassword.newPassword.passwordChangedCorrectly");

  void _navigateToHomeScreen(BuildContext context) {
    FlushBarBroker().clear();
    _showPasswordChangedCorrectly(context);
    Navigator.pushReplacementNamed(context, Routes.HOME);
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
      notEqualMessage: AppText.getInstance().get("signUp.input.password.notEqual"),
      patternMessage: AppText.getInstance().get("signUp.input.password.notValid"),
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
        text: AppText.getInstance().get("recoverPassword.newPassword.changePasswordTitle"),
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
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: SizedBox(
        width: double.infinity,
        child: CircularRoundedRectangleRaisedButton.general(
          key: SIGNUP_KEY_SUBMIT_BUTTON,
          radius: 10,
          onPressed: () => _createButtonAction(context),
          color: Colors.deepPurple,
          child: Row(
            children: <Widget>[
              _buildButtonText(),
              _buildButtonIcon(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonIcon() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Icon(Icons.arrow_forward, color: Colors.white),
    );
  }

  Widget _buildButtonText() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Text(
        AppText.getInstance().get("recoverPassword.newPassword.actions.confirm"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
