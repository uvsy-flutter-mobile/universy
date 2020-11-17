import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordWidgetState();
  }
}

class ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  GlobalKey<FormState> _formKey;
  TextEditingController _userController;

  ForgotPasswordWidgetState();

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
            ForgotPasswordTitleWidget(),
            ForgotPasswordUserNameWidget(
                textEditingController: _userController),
            ForgotPasswordLinkToLogin(linkAction: _navigateToLoginWidget),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildGoBackButton(context),
                ForgotPasswordSubmitButtonWidget(
                    loginAction: _submitButtonOnPressedAction),
              ],
            ),
            ForgotPasswordLinkToSignUp(linkAction: _navigateToSignUp),
          ],
        ),
      ),
    );
  }

  Widget _buildGoBackButton(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: CircularRoundedRectangleRaisedButton.general(
        key: SIGNUP_KEY_SUBMIT_BUTTON,
        radius: 10,
        onPressed: () => _goToRecovery(),
        color: Colors.amber,
        child: Row(
          children: <Widget>[_buildButtonIcon(), _buildButtonText(context)],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _buildButtonIcon() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: Icon(Icons.arrow_back, color: Colors.white),
    );
  }

  Widget _buildButtonText(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5,
      child: Text(
        AppText.getInstance().get("recoverPassword.actions.goBackToSingUp"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _goToRecovery() {
    AccountCubit cubit = BlocProvider.of<AccountCubit>(context);
    cubit.toLogIn();
  }

  void _submitButtonOnPressedAction(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_recoverPassword)
          .withTitle(_verifyingMessage())
          .then(_navigateToRecoverPassword)
          .handle(NotAuthorized, _showDefaultErrorFlushBar)
          .handle(UserNotFoundException, _showUsernameNotExistFlushBar)
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

  void _showDefaultErrorFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_defaultErrorMessage())
        .withIcon(Icon(Icons.contacts, color: Colors.redAccent))
        .show(context);
  }

  String _usernameAlreadyExistsMessage() => AppText.getInstance() //
      .get("login.input.user.notValid");

  String _defaultErrorMessage() => AppText.getInstance() //
      .get("login.error.unexpectedError");

  String _verifyingMessage() =>
      AppText.getInstance().get("login.info.verifying");

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
class ForgotPasswordTitleWidget extends StatelessWidget {
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
class ForgotPasswordUserNameWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const ForgotPasswordUserNameWidget(
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
        keyboardType: TextInputType.emailAddress,
        validatorBuilder: _getUserInputValidator(),
        decorationBuilder: _getUserInputDecoration(),
      ),
    );
  }

  InputDecorationBuilder _getUserInputDecoration() {
    return TextInputDecorationBuilder(
        AppText.getInstance().get("recoverPassword.input.user.message"));
  }

  TextFormFieldValidatorBuilder _getUserInputValidator() {
    return NotEmptyFunctionTextFormValidatorBuilder(
      validationFunction: EmailValidator.validate,
      message: AppText.getInstance().get("recoverPassword.input.user.notValid"),
      emptyMessage:
          AppText.getInstance().get("recoverPassword.input.user.required"),
    );
  }
}

/// Login submit button
class ForgotPasswordSubmitButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _loginAction;

  const ForgotPasswordSubmitButtonWidget(
      {Key key, @required Function(BuildContext context) loginAction})
      : this._loginAction = loginAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 5.0,
      child: _buildButton(context),
    );
  }

  CircularRoundedRectangleRaisedButton _buildButton(BuildContext context) {
    return CircularRoundedRectangleRaisedButton.general(
      key: LOGIN_KEY_SUBMIT_BUTTON,
      radius: 10,
      onPressed: () => _loginAction(context),
      color: Theme.of(context).accentColor,
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
      paddingValue: 5,
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
class ForgotPasswordLinkToSignUp extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const ForgotPasswordLinkToSignUp(
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
          SymmetricEdgePaddingWidget.horizontal(
              paddingValue: MediaQuery.of(context).size.width * 0.01,
              child: _buildLink(context)),
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
          textStyle: TextStyle(color: Colors.black),
        ),
      ],
    );
  }
}

/// SignUp link to login
class ForgotPasswordLinkToLogin extends StatelessWidget {
  final Function(BuildContext context) _linkAction;

  const ForgotPasswordLinkToLogin(
      {Key key, @required Function(BuildContext context) linkAction})
      : this._linkAction = linkAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 15.0,
      child: Row(
        children: <Widget>[
          _buildAccountQuestionText(),
          SymmetricEdgePaddingWidget.horizontal(
              paddingValue: MediaQuery.of(context).size.width * 0.01,
              child: _buildLink(context)),
        ],
      ),
    );
  }

  Column _buildAccountQuestionText() {
    return Column(
      children: <Widget>[
        EllipsisCustomText.left(
          text: (AppText.getInstance().get("signUp.actions.accountQuestion")),
          textStyle: TextStyle(color: Colors.black),
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
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
          ),
          onTap: () => _linkAction(context),
        )
      ],
    );
  }
}
