import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

class InputUserWidget extends StatefulWidget {
  const InputUserWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InputUserWidgetState();
  }
}

class InputUserWidgetState extends State<InputUserWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _userController;

  InputUserWidgetState();

  @override
  void initState() {
    this._formKey = GlobalKey<FormState>();
    this._userController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    this._formKey = null;
    this._userController.dispose();
    this._userController = null;
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
            InputUserTitleWidget(),
            InputUsernameWidget(textEditingController: _userController),
            InputUserLinkToLogin(linkAction: _navigateToLoginWidget),
            InputUserSubmitButtonWidget(loginAction: _submitButtonOnPressedAction),
            InputUserLinkToSignUp(linkAction: _navigateToSignUp)
          ],
        ),
      ),
    );
  }

  void _submitButtonOnPressedAction(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_recoverPassword)
          .withTitle(_verifyingMessage())
          .then(_navigateToRecoverPassword)
          .handle(UserAlreadyExists, _showUsernameNotExistFlushBar)
          .build()
          .run(context);
    }
  }

  Future<void> _recoverPassword(BuildContext context) async {
    String user = _userController.text.trim();
    await _getAccountService(context).forgotPassword(user);
  }

  AccountService _getAccountService(BuildContext context) {
    return Provider.of<ServiceFactory>(context, listen: false).accountService();
  }

  void _showUsernameNotExistFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_usernameAlreadyExistsMessage())
        .withIcon(Icon(Icons.contacts, color: Colors.redAccent))
        .show(context);
  }

  String _usernameAlreadyExistsMessage() => AppText.getInstance() //
      .get("login.input.user.notValid");

  String _verifyingMessage() => AppText.getInstance().get("login.info.verifying");

  void _navigateToLoginWidget(BuildContext context) {
    context.read<AccountCubit>().toLogIn();
  }

  void _navigateToSignUp(BuildContext context) {
    context.read<AccountCubit>().toSingUp();
  }

  void _navigateToRecoverPassword(BuildContext context) {
    String user = _userController.text.trim();
    context.read<AccountCubit>().toRecoverPassword(user);
  }
}

/// Login Title
class InputUserTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: EllipsisCustomText.left(
        text: AppText.getInstance().get("recoverPassword.title"),
        textStyle: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

/// Login user input
class InputUsernameWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const InputUsernameWidget({Key key, @required TextEditingController textEditingController})
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
    return TextInputDecorationBuilder(AppText.getInstance().get("recoverPassword.input.user.message"));
  }

  TextFormFieldValidatorBuilder _getUserInputValidator() {
    return NotEmptyFunctionTextFormValidatorBuilder(
      validationFunction: EmailValidator.validate,
      message: AppText.getInstance().get("recoverPassword.input.user.notValid"),
      emptyMessage: AppText.getInstance().get("recoverPassword.input.user.required"),
    );
  }
}

/// Login submit button
class InputUserSubmitButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _loginAction;

  const InputUserSubmitButtonWidget({Key key, @required Function(BuildContext context) loginAction})
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
        AppText.getInstance().get("recoverPassword.actions.continue"),
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
class InputUserLinkToSignUp extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const InputUserLinkToSignUp({Key key, @required Function(BuildContext context) linkAction})
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
              style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
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
          textStyle: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
        ),
      ],
    );
  }
}

/// SignUp link to login
class InputUserLinkToLogin extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const InputUserLinkToLogin({Key key, @required Function(BuildContext context) linkAction})
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
