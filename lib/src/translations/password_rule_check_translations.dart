library password_rule_check_translations;

part 'package:password_rule_check/src/translations/en.dart';
part 'package:password_rule_check/src/translations/de.dart';

abstract class PasswordRuleCheckTranslation {
  /// String used to get a message saying that [amount] uppercase letters are required
  String uppercase(int amount);

  /// String used to get a message saying that [amount] lowercase letters are required
  String lowercase(int amount);

  /// String used to get a message saying that the input needs to be at least [length] long
  String minLength(int length);

  /// String used to get a message saying that the input may not be longer than [length]
  String maxLength(int length);

  /// String used to get a message saying that [amount] digits are required
  String digits(int amount);

  /// String used to get a message saying that [amount] special characters are required
  String specialCharacters(int amount);
}

/// Map of supported default [PasswordRuleCheckTranslation]s
Map<String, PasswordRuleCheckTranslation> get translations => {
      'en': EnglishTranslation(),
      'de': GermanTranslation(),
    };
