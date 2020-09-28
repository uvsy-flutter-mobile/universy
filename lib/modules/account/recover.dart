import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universy/constants/regex.dart';
import 'package:universy/constants/routes.dart';
import 'package:universy/model/account/user.dart';
import 'package:universy/modules/account/bloc/cubit.dart';
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
import 'package:universy/widgets/willpop/will_pop.dart';

import 'keys.dart';

class RecoverPasswordWidget extends StatefulWidget {
  final String user;

  const RecoverPasswordWidget({Key key, this.user}) : super(key: key);

  @override
  _RecoverPasswordWidgetState createState() => _RecoverPasswordWidgetState();
}

class _RecoverPasswordWidgetState extends State<RecoverPasswordWidget>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeTextController = TextEditingController();
  AnimationController animationController;
  String user;

  final TextEditingController _firstPasswordController = TextEditingController();
  final TextEditingController _secondPasswordController = TextEditingController();
  bool _passwordHidden;

  @override
  void initState() {
    super.initState();
    this.user = widget.user;
    this.animationController = createAnimation();
    this.animationController.reverse(from: 1.0);
    _passwordHidden = true;
  }

  @override
  void dispose() {
    this.animationController.dispose();
    this.user = null;
    super.dispose();
  }

  AnimationController createAnimation() {
    return AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopOutWidget(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Form(
            key: _formKey,
            child: SymmetricEdgePaddingWidget.horizontal(
              paddingValue: 25.0,
              child: Column(
                children: <Widget>[
                  VerifyTitleWidget(),
                  VerifySubTitleWidget(email: widget.user),
                  VerifyCodeWidget(textEditingController: _codeTextController),
                  _buildCreateAnimationWidget(this.animationController),
                  NewPasswordTitleWidget(),
                  NewPasswordWidget(
                    textEditingController: _firstPasswordController,
                    secondEmailEditingController: _secondPasswordController,
                    obscure: _passwordHidden,
                    onPressed: _changePasswordVisibilityOnPressedAction,
                    hint:
                        AppText.getInstance().get("recoverPassword.newPassword.input.user.message"),
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
                  SignUpLinkToLogin(linkAction: _navigateToLoginWidget)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _changePassword(BuildContext context) async {
    var accountService = Provider.of<ServiceFactory>(context, listen: false).accountService();
    String code = _getConfirmationCode();
    String username = widget.user;
    String password = _firstPasswordController.text.trim();
    User user = User(username, password);
    await accountService.setNewPassword(username, password, code);
    await accountService.logIn(user);
  }

  void _submitButtonOnPressedAction(BuildContext context) async {
    if (this._formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_changePassword)
          .then(_navigateToHomeScreen)
          .handle(ConfirmationCodeMismatch, _showCodeMismatchFlushBar)
          .build()
          .run(context);
    } else {
      return;
    }
  }

  void _showCodeMismatchFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_codeMismatchMessage())
        .withIcon(Icon(Icons.block, color: Colors.redAccent))
        .show(context);
  }

  void _changePasswordVisibilityOnPressedAction() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  void _navigateToLoginWidget(BuildContext context) {
    context.read<AccountCubit>().toLogIn();
  }

  Widget _buildCreateAnimationWidget(AnimationController animationController) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: VerifyReSendButtonWidget(
                enabled: !animationController.isAnimating,
                resendAction: _resendVerificationCode,
                animationController: animationController,
              ),
            )
          ],
        );
      },
    );
  }

  void _navigateToHomeScreen(BuildContext context) {
    FlushBarBroker().clear();
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  void _resendVerificationCode(BuildContext context) async {
    await AsyncModalBuilder()
        .perform(_performResendCode)
        .then(_showEmailSentFlushBar)
        .withTitle(_resendMessage())
        .build()
        .run(context);
  }

  Future<void> _performResendCode(BuildContext context) async {
    var accountService = Provider.of<ServiceFactory>(context, listen: false).accountService();
    await accountService.forgotPassword(user);
    animationController.reverse(from: 1.0);
  }

  void _showEmailSentFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_emailSentMessage())
        .withIcon(Icon(Icons.mail, color: Colors.white))
        .show(context);
  }

  String _getConfirmationCode() => _codeTextController.text.trim();

  String _resendMessage() => AppText.getInstance().get("verify.info.resending");

  String _emailSentMessage() => AppText.getInstance().get("verify.info.codeSent");

  String _codeMismatchMessage() => AppText.getInstance().get("verify.error.codeMismatch");
}

/// Verify Title
class VerifyTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: EllipsisCustomText.left(
        text: AppText.getInstance().get("verify.title"),
        textStyle: Theme.of(context).primaryTextTheme.subtitle1,
      ),
    );
  }
}

/// Verify Subtitle
class VerifySubTitleWidget extends StatelessWidget {
  final String _email;

  const VerifySubTitleWidget({Key key, @required String email})
      : this._email = email,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtitle = AppText.getInstance().get("verify.subtitle");
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: Text("$subtitle $_email", textAlign: TextAlign.left),
    );
  }
}

/// Verify Send button
class VerifySendButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _sendButtonAction;

  const VerifySendButtonWidget({Key key, @required Function(BuildContext context) sendButtonAction})
      : this._sendButtonAction = sendButtonAction,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: SizedBox(
        width: double.infinity,
        child: CircularRoundedRectangleRaisedButton.general(
          radius: 10,
          onPressed: () => _sendButtonAction(context),
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
      child: Icon(Icons.verified_user, color: Colors.white),
    );
  }

  Widget _buildButtonText() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Text(
        AppText.getInstance().get("verify.actions.submit"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

/// Verify Re-Send button
class VerifyReSendButtonWidget extends StatelessWidget {
  final Function(BuildContext context) _resendAction;
  final bool _enabled;
  final AnimationController _animationController;

  const VerifyReSendButtonWidget(
      {Key key,
      @required Function(BuildContext context) resendAction,
      @required bool enabled,
      @required AnimationController animationController})
      : this._resendAction = resendAction,
        this._enabled = enabled,
        this._animationController = animationController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 8.0,
      child: SizedBox(
        width: double.infinity,
        child: CircularRoundedRectangleRaisedButton.general(
          radius: 10,
          onPressed: _enabled ? () => _resendAction(context) : null,
          color: Colors.deepPurple,
          child: Row(
            children: <Widget>[
              _buildButtonText(),
              _buildButtonIcon(),
              VerifyCountDownWidget(
                  duration: _animationController.duration * _animationController.value),
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
      child: Icon(Icons.loop, color: Colors.white),
    );
  }

  Widget _buildButtonText() {
    return SymmetricEdgePaddingWidget.horizontal(
      paddingValue: 10,
      child: Text(
        AppText.getInstance().get("verify.actions.resend"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

/// Verify Count Down
class VerifyCountDownWidget extends StatelessWidget {
  final Duration _duration;

  const VerifyCountDownWidget({Key key, @required Duration duration})
      : this._duration = duration,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getTextForDuration(),
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    );
  }

  String getTextForDuration() {
    return '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

/// Verify Code
class VerifyCodeWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const VerifyCodeWidget({Key key, @required TextEditingController textEditingController})
      : this._textEditingController = textEditingController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SymmetricEdgePaddingWidget.vertical(
      paddingValue: 6.0,
      child: CustomTextFormField(
        controller: _textEditingController,
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.number,
        validatorBuilder: _buildNameValidator(),
        decorationBuilder: _buildNameDecorator(),
      ),
    );
  }

  TextFormFieldValidatorBuilder _buildNameValidator() {
    return PatternNotEmptyTextFormFieldValidatorBuilder (
      regExp: Regex.CODE_MAX_LENGHT,
      patternMessage: AppText.getInstance().get("verify.input.code.minQuantity"),
      emptyMessage: AppText.getInstance().get("verify.input.code.required"),
    );
  }

  TextInputDecorationBuilder _buildNameDecorator() {
    return TextInputDecorationBuilder(AppText.getInstance().get("verify.input.code.message"));
  }
}

/// New Password Title
class NewPasswordTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var subtitle = AppText.getInstance().get("recoverPassword.newPassword.subtitle");
    return OnlyEdgePaddedWidget.top(
      padding: 12.0,
      child: Text(subtitle),
    );
  }
}

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

/// Signup controller for username
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
        AppText.getInstance().get("recoverPassword.newPassword.actions.confirm"),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
