part of password_rule_check_translations;

class EnglishTranslation extends PasswordRuleCheckTranslation {
  @override
  String digits(int amount) {
    if (amount == 1) {
      return 'Must contain at least 1 digit';
    } else {
      return 'Must contain at least $amount digits';
    }
  }

  @override
  String maxLength(int length) {
    return 'Must not be longer than $length characters';
  }

  @override
  String minLength(int length) {
    return 'Must be longer than $length characters';
  }

  @override
  String specialCharacters(int amount) {
    if (amount == 1) {
      return 'Must contain at least 1 special character';
    } else {
      return 'Must contain at least $amount characters';
    }
  }

  @override
  String uppercase(int amount) {
    if (amount == 1) {
      return 'Must contain at least 1 capital letter';
    } else {
      return 'Must contain at least $amount capital letters';
    }
  }
}
