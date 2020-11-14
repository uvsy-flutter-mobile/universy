import 'package:universy/services/exceptions/service.dart';

// Account

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

// Profile

/// [ProfileNotFound] occurs when the user has no profiles
/// created
class ProfileNotFound extends ServiceException {}

/// [AliasAlreadyExists] occurs when the user tries
/// to have an an alias already in use
class AliasAlreadyExists extends ServiceException {}

// Notes

/// [StudentNoteNotFound] occurs the an specific note
/// is not found
class StudentNoteNotFound extends ServiceException {}

// Career

/// [CareerNotFound] occurs when an specific career
/// could not be found
class CareerNotFound extends ServiceException {}

/// [CurrentProgramNotFound] occurs the current program
/// is not found in the system
class CurrentProgramNotFound extends ServiceException {}

// Ratings

/// [RatingNotFound] occurs there is not a rating
/// for a given request
class RatingNotFound extends ServiceException {}

class UserNotFoundException extends ServiceException {}
