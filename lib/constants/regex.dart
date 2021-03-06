abstract class Regex {
  // ignore: non_constant_identifier_names
  static final RegExp PASSWORD_FORMAT_REGEX =
      RegExp(r"^(?=.*[a-z])(?=.*\d)[A-Za-z\d$@$!%*?&]{8,15}");

  // ignore: non_constant_identifier_names
  static final RegExp USERNAME_FORMAT_REGEX =
      RegExp(r"^[A-Za-z0-9\.*]{3,20}(?<!\.)$");

  // ignore: non_constant_identifier_names
  static final RegExp LETTERS_FORMAT_REGEX =
      RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d1\s]{3,20}$");

  // ignore: non_constant_identifier_names
  static final RegExp NOT_NUM_FORMAT_REGEX = RegExp(r"^[a-z-A-Z]{3,20}$");

  // ignore: non_constant_identifier_names
  static final RegExp NOT_SYMBOLS_FORMAT_REGEX =
      RegExp(r"^([a-z-A-Z]{3,8}?[0-9]{0,4})$");

  // ignore: non_constant_identifier_names
  static final RegExp ALIAS_FORMAT_REGEX =
      RegExp(r"^[a-zA-ZÀ-ÿ\u00f1\u00d10-9\.*]{3,20}(?<!\.)$");

  // ignore: non_constant_identifier_verification_code max 6 characters
  static final RegExp CODE_MAX_LENGTH = RegExp(r"^[0-9]{6}$");

  static final RegExp URL_DETECT = RegExp(r"^((https?:\/\/)|(www\.))+([\da-z\.-]+)(\.([a-z\s]{2,7}))$");
  //static final RegExp URL_DETECT = RegExp(r"\b((https?: \/\/)|(www.))\S+/gi");

}
