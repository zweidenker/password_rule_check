// coverage:ignore-file
part of password_rule_check_translations;

/// Portuguese Translations for rule texts
class PortugueseTranslation extends PasswordRuleCheckTranslation {
  @override
  String digits(int amount) {
    if (amount == 1) {
      return 'Tem de conter pelo menos 1 número';
    } else {
      return 'Tem de conter pelo menos $amount números';
    }
  }

  @override
  String maxLength(int length) {
    return 'Tem de ser menor do que $length caracteres';
  }

  @override
  String minLength(int length) {
    return 'Tem de ser maior do que $length caracteres';
  }

  @override
  String specialCharacters(int amount) {
    if (amount == 1) {
      return 'Tem de conter pelo menos 1 caracter especial';
    } else {
      return 'Tem de conter pelo menos $amount caracteres especiais';
    }
  }

  @override
  String uppercase(int amount) {
    if (amount == 1) {
      return 'Tem de conter pelo menos 1 letra maiúscula';
    } else {
      return 'Tem de conter pelo menos $amount letras maiúsculas';
    }
  }

  @override
  String lowercase(int amount) {
    if (amount == 1) {
      return 'Tem de conter pelo menos 1 letra minúscula';
    } else {
      return 'Tem de conter pelo menos $amount letras minúsculas';
    }
  }
}
