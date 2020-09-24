import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/modules/account/keys.dart';
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

import 'bloc/cubit.dart';

class SetNewPasswordWidget extends StatefulWidget {
  final String user;

  const SetNewPasswordWidget({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SetNewPasswordWidgetState();
  }
}

class SetNewPasswordWidgetState extends State<SetNewPasswordWidget> {
  final _formKeyLog = GlobalKey<FormState>();
  final TextEditingController _firstPasswordController = TextEditingController();
  final TextEditingController _secondPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordHidden;

  SetNewPasswordWidgetState();

  @override
  void initState() {
    _passwordHidden = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLog,
      child: SymmetricEdgePaddingWidget.horizontal(
        paddingValue: 25.0,
        child: Column(
          children: <Widget>[
            NewPasswordTitleWidget(),
            NewPasswordWidget(
              textEditingController: _firstPasswordController,
              secondEmailEditingController: _secondPasswordController,
              obscure: _passwordHidden,
              onPressed: _changePasswordVisibilityOnPressedAction,
              hint: AppText.getInstance().get("newPassword.input.user.message"),
            ),
            NewPasswordWidget(
              textEditingController: _secondPasswordController,
              secondEmailEditingController: _firstPasswordController,
              obscure: _passwordHidden,
              onPressed: _changePasswordVisibilityOnPressedAction,
              hint: AppText.getInstance().get("newPassword.input.user.messageCheck"),
            ),
            NewPasswordConfirmButtonWidget(createButtonAction: _submitButtonOnPressedAction),
            SignUpLinkToLogin(linkAction: _navigateToLoginWidget)
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

  void _submitButtonOnPressedAction(BuildContext context) async {
    if (_formKeyLog.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_changePasswordAndLogin)
          .withTitle(_creatingAccountMessage())
          .then(_navigateToVerify)
          .build()
          .run(context);
    }
  }

  Future<void> _changePasswordAndLogin(BuildContext context) async {
    String password = _firstPasswordController.text.trim();
    //await _getAccountService(context)
    await _getAccountService(context).confirmPassword(widget.user,password);
    await _getAccountService(context).signUp(user);
  }

  User _getUserFromTextFields() {
    return User(
      _firstPasswordController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  AccountService _getAccountService(BuildContext context) {
    return Provider.of<ServiceFactory>(context, listen: false).accountService();
  }

  void _navigateToVerify(BuildContext context) {
    _showUserCreated(context);
    User user = _getUserFromTextFields();
    context.read<AccountCubit>().toVerify(user);
  }

  void _navigateToLoginWidget(BuildContext context) {
    context.read<AccountCubit>().toLogIn();
  }

  void _showUserCreated(BuildContext context) {
    FlushBarBroker()
        .withMessage(AppText.getInstance().get("signUp.info.accountCreated"))
        .withIcon(Icon(Icons.check, color: Colors.green))
        .show(context);
  }

  String _creatingAccountMessage() => AppText.getInstance() //
      .get("signUp.info.creatingAccount");
}

/// Signup Title
class NewPasswordTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: EllipsisCustomText.left(
        text: AppText.getInstance().get("newPassword.title"),
        textStyle: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

/// Signup controller for username
class NewPasswordWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final TextEditingController _secondTextEditingController;
  final String _hint;
  final bool _obscure;
  final Function() _onPressed;

  const NewPasswordWidget(
      {Key key,
      @required TextEditingController textEditingController,
      @required bool obscure,
      @required Function() onPressed,
      TextEditingController secondEmailEditingController,
      @required String hint})
      : this._textEditingController = textEditingController,
        this._secondTextEditingController = secondEmailEditingController,
        this._hint = hint,
        this._obscure = obscure,
        this._onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
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
      labelText: AppText.getInstance().get("signUp.input.password.message"),
      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: _onPressed,
    );
  }

  TextFormFieldValidatorBuilder _buildPasswordValidator() {
    return NotEqualTextFormValidatorBuilderPassword(
      controllerToComparate: _secondTextEditingController,
      notEqualMessage: AppText.getInstance().get("signUp.input.user.notEqual"),
      validationFunction: (value) => EmailValidator.validate(value),
      regExp: Regex.PASSWORD_FORMAT_REGEX,
      patternMessage: AppText.getInstance().get("signUp.input.password.notValid"),
      emptyMessage: AppText.getInstance().get("signUp.input.password.required"),
    );
  }
}

/// SignUp controller for password
class SignUpPasswordWidget extends StatelessWidget {
  final TextEditingController _textEditingController;
  final bool _obscure;
  final Function() _onPressed;

  const SignUpPasswordWidget(
      {Key key,
      @required TextEditingController textEditingController,
      @required bool obscure,
      @required Function() onPressed})
      : this._textEditingController = textEditingController,
        this._obscure = obscure,
        this._onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        key: SIGNUP_KEY_PASSWORD_FIELD,
        controller: _textEditingController,
        validatorBuilder: _getPasswordValidator(),
        decorationBuilder: _getPasswordDecoration(),
        obscure: _obscure,
      ),
    );
  }

  InputDecorationBuilder _getPasswordDecoration() {
    return IconButtonInputDecorationBuilder(
      labelText: AppText.getInstance().get("signUp.input.password.message"),
      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
      onPressed: _onPressed,
    );
  }

  TextFormFieldValidatorBuilder _getPasswordValidator() {
    return PatternNotEmptyTextFormFieldValidatorBuilder(
      regExp: Regex.PASSWORD_FORMAT_REGEX,
      patternMessage: AppText.getInstance().get("signUp.input.password.notValid"),
      emptyMessage: AppText.getInstance().get("signUp.input.password.required"),
    );
  }
}

/// SignUp link to login
class SignUpLinkToLogin extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const SignUpLinkToLogin({Key key, @required Function(BuildContext context) linkAction})
      : this._linkAction = linkAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 15.0,
      child: Row(
        children: <Widget>[
          _buildAccountQuestionText(),
          _buildLink(context),
        ],
      ),
    );
  }

  Column _buildAccountQuestionText() {
    return Column(
      children: <Widget>[
        EllipsisCustomText.left(
          text: (AppText.getInstance().get("signUp.actions.accountQuestion")),
          textStyle: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
        ),
      ],
    );
  }

  Column _buildLink(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Text(
            AppText.getInstance().get("signUp.actions.goToLogin"),
            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
          ),
          onTap: () => _linkAction(context),
        )
      ],
    );
  }
}

/// Signup button for account creation
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
        AppText.getInstance().get("newPassword.actions.confirm"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
