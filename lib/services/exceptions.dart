/// [ServiceException] wraps all the exceptions that
/// are expected to happen inside the services level.
class ServiceException implements Exception {}

class NotAuthorized extends ServiceException {}
