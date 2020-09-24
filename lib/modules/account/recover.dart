import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    this.user = user;
    this.animationController = createAnimation();
    this.animationController.reverse(from: 1.0);
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
                  VerifySubTitleWidget(email: user),
                  VerifyCodeWidget(textEditingController: _codeTextController),
                  VerifySendButtonWidget(
                      sendButtonAction: sendVerificationCode),
                  Divider(),
                  _buildCreateAnimationWidget()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateAnimationWidget() {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: VerifyCountDownWidget(
                  duration:
                      animationController.duration * animationController.value),
            ),
            Expanded(
              flex: 8,
              child: VerifyReSendButtonWidget(
                enabled: !animationController.isAnimating,
                resendAction: _resendVerificationCode,
              ),
            )
          ],
        );
      },
    );
  }

  void sendVerificationCode(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).unfocus();
      await AsyncModalBuilder()
          .perform(_confirmCode)
          .withTitle(_sendMessage())
          .then(_navigateToHomeScreen)
          .handle(ConfirmationCodeMismatch, _showCodeMismatchFlushBar)
          .build()
          .run(context);
    }
  }

  Future<void> _confirmCode(BuildContext context) async {
    String code = _getConfirmationCode();
    var accountService = Provider.of<ServiceFactory>(context, listen: false).accountService();
    await accountService.confirmUser(user, code);
    _navigateToSetPasswordWidget(context);


  }

  void _navigateToSetPasswordWidget(BuildContext context) {
    context.read<AccountCubit>().toSetNewPasswordState(user);
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.HOME);
    // TODO: Should we keep this flushbar? We will go to the welcome page!
    // _showVerifiedAccountFlushBar(context);
  }

  void _resendVerificationCode(BuildContext context) async {
    await AsyncModalBuilder()
        .perform(_performResendCode)
        .then(_showEmailSentFlushBar)
        .withTitle(_resendMessage())
        .build()
        .run(context);
  }

  Future _performResendCode(BuildContext context) async {
    await _resendCode(context);
    animationController.reverse(from: 1.0);
  }

  Future<void> _resendCode(BuildContext context) async {
    var accountService =
        Provider.of<ServiceFactory>(context, listen: false).accountService();
    await accountService.resendConfirmationCode(user);
  }

  void _showCodeMismatchFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_codeMismatchMessage())
        .withIcon(Icon(Icons.block, color: Colors.redAccent))
        .show(context);
  }

  void _showEmailSentFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_emailSentMessage())
        .withIcon(Icon(Icons.mail, color: Colors.white))
        .show(context);
  }

  // TODO: Should we show this?
  void _showVerifiedAccountFlushBar(BuildContext context) {
    FlushBarBroker()
        .withMessage(_verifiedAccountMessage())
        .withIcon(Icon(Icons.check_circle, color: Colors.green))
        .withDuration(5)
        .show(context);
  }

  String _getConfirmationCode() => _codeTextController.text.trim();

  String _sendMessage() => AppText.getInstance().get("verify.actions.submit");

  String _resendMessage() => AppText.getInstance().get("verify.info.resending");

  String _emailSentMessage() =>
      AppText.getInstance().get("verify.info.codeSent");

  String _verifiedAccountMessage() =>
      AppText.getInstance().get("verify.info.verified");

  String _codeMismatchMessage() =>
      AppText.getInstance().get("verify.error.codeMismatch");
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

  const VerifySendButtonWidget(
      {Key key, @required Function(BuildContext context) sendButtonAction})
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

  const VerifyReSendButtonWidget(
      {Key key,
      @required Function(BuildContext context) resendAction,
      @required bool enabled})
      : this._resendAction = resendAction,
        this._enabled = enabled,
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
          color: Colors.blue,
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
      style: TextStyle(fontSize: 20.0, color: Colors.black),
    );
  }

  String getTextForDuration() {
    return '${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

/// Verify Code
class VerifyCodeWidget extends StatelessWidget {
  final TextEditingController _textEditingController;

  const VerifyCodeWidget(
      {Key key, @required TextEditingController textEditingController})
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
    return NotEmptyTextFormFieldValidatorBuilder(
      AppText.getInstance().get("verify.input.code.required"),
    );
  }

  TextInputDecorationBuilder _buildNameDecorator() {
    return TextInputDecorationBuilder(
        AppText.getInstance().get("verify.input.code.message"));
  }
}
