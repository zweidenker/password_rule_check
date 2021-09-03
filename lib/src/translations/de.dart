// coverage:ignore-file
part of password_rule_check_translations;

class GermanTranslation extends PasswordRuleCheckTranslation {
  @override
  String digits(int amount) {
    if (amount == 1) {
      return 'Mindestens 1 Ziffer';
    } else {
      return 'Mindestens $amount Ziffern';
    }
  }

  @override
  String maxLength(int length) {
    return 'Kürzer als $length Zeichen';
  }

  @override
  String minLength(int length) {
    return 'Länger als $length Zeichen';
  }

  @override
  String specialCharacters(int amount) {
    if (amount == 1) {
      return 'Mindestens 1 Sonderzeichen';
    } else {
      return 'Mindestens $amount Sonderzeichen';
    }
  }

  @override
  String uppercase(int amount) {
    if (amount == 1) {
      return 'Mindestens 1 Großbuchstabe';
    } else {
      return 'Mindestens $amount Großbuchstaben';
    }
  }

  @override
  String lowercase(int amount) {
    if (amount == 1) {
      return 'Mindestens 1 Kleinbuchstabe';
    } else {
      return 'Mindestens $amount Kleinbuchstaben';
    }
  }
}
