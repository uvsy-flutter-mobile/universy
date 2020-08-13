import 'package:universy/services/exceptions/service.dart';

// Student services

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

/// [ProfileNotFound] occurs when the user has no profiles
/// created
class ProfileNotFound extends ServiceException {}

/// [CareerNotFound] occurs when an specific career
/// could not be found
class CareerNotFound extends ServiceException {}

/// [CurrentProgramNotFound] occurs the current program
/// is not found in the system
class CurrentProgramNotFound extends ServiceException {}

/// [SessionNotFound] occurs when the user
/// has no session created
class SessionNotFound extends ServiceException {}
