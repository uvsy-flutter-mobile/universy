import 'package:universy/services/exceptions/service.dart';

/// [ProfileNotFound] occurs when the user has no profiles
/// created
class ProfileNotFound extends ServiceException {}

class AliasAlreadyExists extends ServiceException {}
