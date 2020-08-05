import 'package:universy/services/exceptions/service.dart';

/// [NotAuthorized] occurs when the user has no permissions
/// over a resource/action
class NotAuthorized extends ServiceException {}

/// [UserAlreadyExists] occurs when the user exists already
/// in the userpool
class UserAlreadyExists extends ServiceException {}

/// [UserAlreadyExists] occurs when the user exists
/// in the userpool but is not confirmed
class UserNeedsConfirmation extends ServiceException {}

/// [UserAlreadyExists] occurs when the provided confirmation code
/// does not match the one sent
class ConfirmationCodeMismatch extends ServiceException {}
