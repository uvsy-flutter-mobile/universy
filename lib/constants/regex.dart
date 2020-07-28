abstract class Regex {
  // ignore: non_constant_identifier_names
  static final RegExp PASSWORD_FORMAT_REGEX =
      RegExp(r"^(?=.*\d)[A-Za-z\d$@$!%*?&]{8,15}");

  // ignore: non_constant_identifier_names
  static final RegExp USERNAME_FORMAT_REGEX =
      RegExp(r"^[A-Za-z0-9\.*]{3,20}(?<!\.)$");

  // ignore: non_constant_identifier_names
  static final RegExp LETTERS_FORMAT_REGEX = RegExp(r"^[A-Za-z\s]{3,20}$");

  // ignore: non_constant_identifier_names
  static final RegExp NOT_NUM_FORMAT_REGEX = RegExp(r"^[a-z-A-Z]{3,20}$");

  // ignore: non_constant_identifier_names
  static final RegExp NOT_SYMBOLS_FORMAT_REGEX =
      RegExp(r"^([a-z-A-Z]{3,8}?[0-9]{0,4})$");
}
