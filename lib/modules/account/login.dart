import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/modules/account/bloc/cubit.dart';
import 'package:universy/services/exceptions/student.dart';
import 'package:universy/services/factory.dart';
import 'package:universy/services/manifest.dart';
import 'package:universy/text/text.dart';
import 'package:universy/widgets/async/modal.dart';
import 'package:universy/widgets/buttons/raised/rounded.dart';
import 'package:universy/widgets/flushbar/builder.dart';
import 'package:universy/widgets/formfield/decoration/builder.dart';
import 'package:universy/widgets/formfield/text/custom.dart';
import 'package:universy/widgets/formfield/text/validators.dart';
import 'package:universy/widgets/paddings/edge.dart';
import 'package:universy/widgets/text/custom.dart';

import 'keys.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginWidgetState();
  }
}

class LoginWidgetState extends State<LogInWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _userController;
  TextEditingController _passwordController;
  bool _passwordHidden;

  LoginWidgetState();

  @override
  void initState() {
    this._formKey = GlobalKey<FormState>();
    this._userController = TextEditingController();
    this._passwordController = TextEditingController();
    this._passwordHidden = true;
    super.initState();
  }

  @override
  void dispose() {
    this._formKey = null;
    this._userController.dispose();
    this._userController = null;
    this._passwordController.dispose();
    this._passwordController = null;
    this._passwordHidden = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 25.0,
        child: Column(
          children: <Widget>[
            LoginTitleWidget(),
            LoginUsernameWidget(textEditingController: _userController),
            LoginPasswordWidget(
                textEditingController: _passwordController,
                obscure: _passwordHidden,
                onPressed: _changePasswordVisibilityOnPressedAction),
            LoginSubmitButtonWidget(loginAction: submitButtonOnPressedAction),
            LoginLinkToSignUp(linkAction: _navigateToSignUp)
          ],
        ),
      ),
    );
  }

  void _changePasswordVisibilityOnPressedAction() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  void submitButtonOnPressedAction(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_logIn)
          .then(_navigateToHomeScreen)
          .handle(NotAuthorized, _showNotAuthorizedFlushBar)
          .handle(UserNeedsConfirmation, _navigateToVerify)
          .withTitle(_verifyingMessage())
          .build()
          .run(context);
    }
  }

  Future<void> _logIn(BuildContext context) async {
    User user = _getUserFromTextFields();
    await _getAccountService(context).logIn(user);
  }

  User _getUserFromTextFields() {
    return User(_userController.text.trim(), _passwordController.text.trim());
  }

  AccountService _getAccountService(BuildContext context) {
    return context.read<ServiceFactory>().accountService();
  }

  void _navigateToHomeScreen(BuildContext context) {
    FlushBarBroker().clear();
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  void _navigateToSignUp(BuildContext context) {
    context.read<AccountCubit>().toSingUp();
  }

  void _navigateToVerify(BuildContext context) {
    User user = _getUserFromTextFields();
    context.read<AccountCubit>().toVerify(user);
  }

  void _showNotAuthorizedFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_notAuthorizeMessage())
        .withIcon(Icon(Icons.block, color: Colors.redAccent))
        .show(context);
  }

  String _notAuthorizeMessage() =>
      AppText.getInstance().get("login.error.notAuthorized");

  String _verifyingMessage() =>
      AppText.getInstance().get("login.info.verifying");
}

/// Login Title
class LoginTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: EllipsisCustomText.left(
        text: AppText.getInstance().get("login.title"),
        textStyle: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

/// Login user input
class LoginUsernameWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const LoginUsernameWidget(
      {Key key, @required TextEditingController textEditingController})
      : this._textEditingController = textEditingController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        key: LOGIN_KEY_USER_FIELD,
        controller: _textEditingController,
        validatorBuilder: _getUserInputValidator(),
        decorationBuilder: _getUserInputDecoration(),
      ),
    );
  }

  InputDecorationBuilder _getUserInputDecoration() {
    return TextInputDecorationBuilder(
        AppText.getInstance().get("login.input.user.message"));
  }

  TextFormFieldValidatorBuilder _getUserInputValidator() {
    return NotEmptyFunctionTextFormValidatorBuilder(
      validationFunction: EmailValidator.validate,
      message: AppText.getInstance().get("login.input.user.notValid"),
      emptyMessage: AppText.getInstance().get("login.input.user.required"),
    );
  }
}

/// Login password input
class LoginPasswordWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obscure;
  final Function() onPressed;

  const LoginPasswordWidget(
      {Key key,
      @required TextEditingController textEditingController,
      @required bool obscure,
      @required Function() onPressed})
      : this.textEditingController = textEditingController,
        this.obscure = obscure,
        this.onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
          key: LOGIN_KEY_PASSWORD_FIELD,
          controller: textEditingController,
          validatorBuilder: _getPasswordValidator(),
          decorationBuilder: _buildPasswordInput(),
          obscure: obscure),
    );
  }

  InputDecorationBuilder _buildPasswordInput() {
    return IconButtonInputDecorationBuilder(
      labelText: AppText.getInstance().get("login.input.password.message"),
      icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: onPressed,
    );
  }

  TextFormFieldValidatorBuilder _getPasswordValidator() {
    return NotEmptyTextFormFieldValidatorBuilder(
      AppText.getInstance().get("login.input.password.required"),
    );
  }
}

/// Login submit button
class LoginSubmitButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _loginAction;

  const LoginSubmitButtonWidget(
      {Key key, @required Function(BuildContext context) loginAction})
      : this._loginAction = loginAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: SizedBox(
        width: double.infinity,
        child: _buildButton(context),
      ),
    );
  }

  CircularRoundedRectangleRaisedButton _buildButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      key: LOGIN_KEY_SUBMIT_BUTTON,
      radius: 10,
      onPressed: () => _loginAction(context),
      color: Colors.black54,
      child: Row(
        children: <Widget>[
          _buildButtonText(),
          _buildButtonIcon(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget _buildButtonText() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Text(
        AppText.getInstance().get("login.actions.submit"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildButtonIcon() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Icon(Icons.arrow_forward, color: Colors.white),
    );
  }
}

/// Login link for signup
class LoginLinkToSignUp extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const LoginLinkToSignUp(
      {Key key, @required Function(BuildContext context) linkAction})
      : this._linkAction = linkAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: Row(
        children: <Widget>[
          _buildAccountQuestionText(),
          _buildLink(context),
        ],
      ),
    );
  }

  Widget _buildLink(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
            child: Text(
              (AppText.getInstance().get("login.actions.register")),
              style: TextStyle(
                  decoration: TextDecoration.underline, color: Colors.blue),
            ),
            onTap: () => _linkAction(context))
      ],
    );
  }

  Widget _buildAccountQuestionText() {
    return Column(
      children: <Widget>[
        EllipsisCustomText.left(
          text: (AppText.getInstance().get("login.actions.signup")),
          textStyle: TextStyle(
              decoration: TextDecoration.underline, color: Colors.black),
        ),
      ],
    );
  }
}
